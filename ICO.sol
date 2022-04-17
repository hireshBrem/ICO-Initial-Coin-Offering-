// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

contract ICO {

    uint256 public ICOEndTime;
    uint256 public minimumFundForToken;
    address public host;

    uint256 public currentFunds;
    mapping(address=>uint256) public addrToToken;
    address[] public addresses;

    constructor() {
        host = msg.sender;
        ICOEndTime = block.timestamp + 10 days;
        minimumFundForToken = 1 ether;
    }

    modifier onlyHost {
        require(msg.sender==host, "Invalid only host can access this function");
        _;
    }

    event Fund(
        address _addr,
        uint256 _amount
    );

    function addDayICOEndTime() public onlyHost {
        ICOEndTime = block.timestamp + 1 days;
    }

    function fund() public payable{

        if(msg.value == minimumFundForToken && block.timestamp <= ICOEndTime){
            currentFunds+=msg.value;
            addresses.push(msg.sender);
            addrToToken[msg.sender] += 1;
            emit Fund(msg.sender, msg.value);
        }
    }
    
    function viewTokens() public view returns(uint256){
        return addrToToken[msg.sender]; 
    }

}
