pragma solidity ^0.4.13;


contract Roulette {

    struct Player {
        uint playerID;
        address addr;
        bool alive;
        uint balance;
        bool init;
        uint prevTurn;
        uint nextTurn;
    }

    modifier isOwner (address owner) {if(msg.sender == owner) {_;}}

    address public owner;
    
    mapping (uint => address) public playerNum;
    mapping (address => Player) public playerList;
    
    uint public numOfPlayers;
    uint public turn;
    uint public buyin;
    uint public maxPlayers;
    uint public numAlive;
    uint public pot;
    uint private randHelper;
    State public state;

    enum State {Lobby, Playing}
    

    function Roulette() {
        owner = msg.sender;
        numOfPlayers = 0;
        buyin = 100 wei;
        state = State.Lobby;
        maxPlayers = 5;
        numAlive = 5;
        randHelper = 0;
    }

    function spinRoulette(uint rand) {
        if (numAlive == 1) {
            revert();
        }
        
        if (state == State.Lobby) {
            revert();
        }

        if (playerList[msg.sender].playerID != turn) {
            revert();
        }

        randHelper += uint(sha256(rand));


        if ((uint(block.blockhash(block.number-1))+randHelper) % maxPlayers + 1 == 1) {
            playerList[msg.sender].alive = false;
            turn = playerList[msg.sender].nextTurn;
            playerList[playerNum[playerList[msg.sender].prevTurn]].nextTurn = playerList[msg.sender].nextTurn;
            playerList[playerNum[playerList[msg.sender].nextTurn]].prevTurn = playerList[msg.sender].prevTurn;
            numAlive -= 1;
        }
        
        if (numAlive == 1) {
            state = State.Lobby;
            playerList[playerNum[turn]].balance += pot;
            pot = 0;
            turn = 0;
        } else {
            turn = playerList[msg.sender].nextTurn;
        }


    }
    
    function startGame() 
        isOwner(msg.sender)
    {
        if (numOfPlayers != maxPlayers) {
            revert();
        }

        if (state == State.Playing) {
            revert();
        }
        
        state = State.Playing;
        turn = (uint(block.blockhash(block.number-1))+randHelper) % maxPlayers + 1;
    }
    
    function getPot() returns (uint) {
        return pot;
    }

    function setBuyin(uint buy) 
        isOwner(msg.sender) 
    {
        if (numOfPlayers != 0) {
            revert();
        }

        buyin = buy;
    }

    function getBuyin() returns(uint) {
        return buyin;
    }

    function addPlayer(uint rand) payable {
        if (numOfPlayers >= maxPlayers) revert();

        if (state == State.Playing) revert();

        if (playerList[msg.sender].init == true) revert();

        if (msg.value < buyin) revert();

        randHelper += uint(sha256(rand));
        numOfPlayers += 1;
        playerNum[numOfPlayers] = msg.sender;
        uint pre = numOfPlayers - 1;
        if (pre == 0) {
            pre = maxPlayers;
        }

        uint nex = numOfPlayers + 1;
        if (nex == maxPlayers + 1) {
            nex = 1;
        }

        playerList[msg.sender] = Player(numOfPlayers, msg.sender, true, msg.value - buyin, true, pre, nex);
        pot += buyin;

    }

    function withdraw() returns (uint) {
        if (state == State.Playing) {
            revert();
        }

        numOfPlayers -= 1;
        uint val = playerList[msg.sender].balance;
        playerList[msg.sender].balance = 0;
        msg.sender.transfer(val);
        return val;
    }
    


    function getNumAlive() returns (uint) {
        return numAlive;
    }

    function getCurrentTurn() returns (uint) {
        return turn;
    } 

    function getOwner() returns (address) {
        return owner;
    }

    function getPlayerAddr(uint u) returns (address) {
        return playerNum[u];
    }

    function getPlayer(address addr) returns (address, bool, uint, uint, uint) {
        return (playerList[addr].addr, playerList[addr].alive, playerList[addr].balance, playerList[addr].prevTurn, playerList[addr].nextTurn);
    }

    function getRandHelper() returns (uint) {
    	return randHelper;
    }
}
