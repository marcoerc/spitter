const Splitter = artifacts.require("Splitter");

contract('Splitter', (accounts) => {

  let SplitterInstance; 
  let bob; 
  let carol;
  let amount; 

  before("Accounts initialization", function() {
    bob = accounts[1];
    carol = accounts[2];
    amount = 10; 
  });

  beforeEach('deploy new instance', async () => {
    SplitterInstance = await Splitter.new(accounts[1],accounts[2])
  })

  it('split correctly', async () => {
       
    console.log("contract address: " +  SplitterInstance.address);

    // Get initial balances of first and second account.
    const bobStartingBalance = await web3.eth.getBalance(bob);
    const carolStartingBalance = await web3.eth.getBalance(carol);
    const BN = web3.utils.BN;

    await SplitterInstance.split({value: amount});
    let bobTxInfo = await SplitterInstance.withdraw(amount/2, {from: bob});
    const bobTx = await web3.eth.getTransaction(bobTxInfo.tx);
    const bobFee = new BN(bobTx.gasPrice).mul(new BN(bobTxInfo.receipt.gasUsed));

    
    let carolTxInfo = await SplitterInstance.withdraw(amount/2, {from: carol});
    const carolTx = await web3.eth.getTransaction(carolTxInfo.tx);
    const carolFee = new BN(carolTx.gasPrice).mul(new BN(carolTxInfo.receipt.gasUsed));


    // Get balances of first and second account after the transactions.
    const bobEndingBalance = await web3.eth.getBalance(bob);
    const carolEndingBalance = await web3.eth.getBalance(carol);

    console.log("bobStartingBalance " + bobStartingBalance);
    console.log("bobEndingBalance " + bobEndingBalance);
    console.log("carolStartingBalance " + carolStartingBalance);
    console.log("carolEndingBalance " + carolEndingBalance);

    

    assert.equal(bobEndingBalance, new BN(bobStartingBalance).sub(bobFee).add(new BN(""+amount/2)).toString(), "Amount wasn't splitted correctly");
    assert.equal(carolEndingBalance, new BN(carolStartingBalance).sub(carolFee).add(new BN(""+amount/2)).toString(), "Amount wasn't splitted correctly");
  });

});
