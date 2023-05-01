// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;
import "@openzeppelin/contracts/access/Ownable.sol";

// import console;

contract Upload is Ownable {
    // address public owner;

    //initializing the owner as the first account in hardhat that deploys the contract
    // constructor() {
    //     owner = msg.sender;
    // }

    struct student {
        address user;
        string name;
        uint256 age;
    }

    //declaring a string of address that will be appended everytime when a new student will be added
    student[] public studentlist;

    //creating a access structure defining the user and their access rights
    struct Access {
        address user;
        bool access; //true or false
    }

    //mapping to store each addresses ipfs url(can be multiple urls therefore string)
    mapping(address => string[]) ipfsurl;

    //mapping to store access list granted by each address to other addresses
    mapping(address => Access[]) accessList;

    //function to add students can be done only by the admin
    function addStudent(
        address user,
        string memory name,
        uint256 age
    ) external onlyOwner {
        // require(msg.sender == owner, "you are not allowed");
        // console.log("error message");
        student memory std = student(user, name, age);
        studentlist.push(std);
    }

    function display() external view returns (student[] memory) {
        return studentlist;
    }

    function addDetails(address useraddr, string memory url)
        external
        onlyOwner
    {
        ipfsurl[useraddr].push(url);
    }

    function getAddressUrl(address useraddr)
        external
        view
        returns (string[] memory)
    {
        return ipfsurl[useraddr];
    }

    function getUserDetails(address useraddr)
        external
        view
        returns (student memory)
    {
        student memory s = student(address(0), "unknown", 0);
        for (uint256 i = 0; i < studentlist.length; ++i) {
            if (studentlist[i].user == useraddr) {
                s = studentlist[i];
                return s;
            }
        }
        return s;
    }
}
