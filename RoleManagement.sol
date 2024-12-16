// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract RoleManagement {
    mapping(address => bool) public admins;
    address public owner;

    constructor() {
        owner = msg.sender;
        admins[owner] = true;
    }

    modifier onlyOwner() {
        require(msg.sender == owner, "Not the owner");
        _;
    }

    modifier onlyAdmin() {
        require(admins[msg.sender], "Not an admin");
        _;
    }

    function addAdmin(address _admin) public onlyOwner {
        admins[_admin] = true;
    }

    function removeAdmin(address _admin) public onlyOwner {
        admins[_admin] = false;
    }
}