import Web3 from 'web3'; 

const web3 = new Web3(new Web3.providers.HttpProvider("http://localhost:8545"));

var abi = [{"constant":true,"inputs":[{"name":"","type":"address"}],"name":"playerList","outputs":[{"name":"playerID","type":"uint256"},{"name":"addr","type":"address"},{"name":"alive","type":"bool"},{"name":"balance","type":"uint256"},{"name":"init","type":"bool"},{"name":"prevTurn","type":"uint256"},{"name":"nextTurn","type":"uint256"}],"payable":false,"type":"function"},{"constant":false,"inputs":[],"name":"spinRoulette","outputs":[],"payable":false,"type":"function"},{"constant":false,"inputs":[],"name":"addPlayer","outputs":[],"payable":true,"type":"function"},{"constant":false,"inputs":[],"name":"getBuyin","outputs":[{"name":"","type":"uint256"}],"payable":false,"type":"function"},{"constant":false,"inputs":[],"name":"getPot","outputs":[{"name":"","type":"uint256"}],"payable":false,"type":"function"},{"constant":false,"inputs":[],"name":"getNumAlive","outputs":[{"name":"","type":"uint256"}],"payable":false,"type":"function"},{"constant":false,"inputs":[{"name":"u","type":"uint256"}],"name":"getPlayerAddr","outputs":[{"name":"","type":"address"}],"payable":false,"type":"function"},{"constant":false,"inputs":[{"name":"addr","type":"address"}],"name":"getPlayer","outputs":[{"name":"","type":"address"},{"name":"","type":"bool"},{"name":"","type":"uint256"},{"name":"","type":"uint256"},{"name":"","type":"uint256"}],"payable":false,"type":"function"},{"constant":false,"inputs":[],"name":"getOwner","outputs":[{"name":"","type":"address"}],"payable":false,"type":"function"},{"constant":true,"inputs":[{"name":"","type":"uint256"}],"name":"playerNum","outputs":[{"name":"","type":"address"}],"payable":false,"type":"function"},{"constant":false,"inputs":[],"name":"getCurrentTurn","outputs":[{"name":"","type":"uint256"}],"payable":false,"type":"function"},{"constant":false,"inputs":[{"name":"buy","type":"uint256"}],"name":"setBuyin","outputs":[],"payable":false,"type":"function"},{"constant":false,"inputs":[],"name":"startGame","outputs":[],"payable":false,"type":"function"},{"inputs":[],"payable":false,"type":"constructor"}];

var address = '0x0f7f118cf90d5891833cffac280b32ce72975913';

const rContract = web3.eth.contract(abi).at(address);

var acct = web3.eth.accounts[0];

var balance = web3.fromWei(web3.eth.getBalance(acct)).toString();

export {rContract, acct, balance};