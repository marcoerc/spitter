const Splitter = artifacts.require("Splitter");

contract('Splitter', (accounts) => {
  it('should start with 0', async () => {
    const SplitterInstance = await Splitter.deployed();
    const balance = await SplitterInstance.getBalance.call();

    assert.equal(balance.valueOf(), 0, "The contract has not zero balance");
  });
  it('should split ether correctly', async () => {
    const SplitterInstance = await Splitter.deployed();

    const bob = accounts[1];
    const carol = accounts[2];

    // Get initial balances of first and second account.
    const bobStartingBalance = await web3.eth.getBalance(bob);
    const carolStartingBalance = await web3.eth.getBalance(carol);

    // Make transaction from first account to second.
    const amount = 10;
    await SplitterInstance.split({value: amount});

    // Get balances of first and second account after the transactions.
    const bobEndingBalance = await web3.eth.getBalance(bob);
    const carolEndingBalance = await web3.eth.getBalance(carol);

    console.log("bobStartingBalance " + bobStartingBalance);
    console.log("bobEndingBalance " + bobEndingBalance);
    console.log("carolStartingBalance " + carolStartingBalance);
    console.log("carolEndingBalance " + carolEndingBalance);

    assert.equal(Number(bobEndingBalance), Number(bobStartingBalance)+(amount/2), "Amount wasn't splitted correctly");
    assert.equal(Number(carolEndingBalance), Number(carolStartingBalance)+(amount/2), "Amount wasn't splitted correctly");
  });
});
