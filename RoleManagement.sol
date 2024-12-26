// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/access/AccessControl.sol";

contract RoleManagement is Ownable, AccessControl {
    bytes32 public constant ADMIN_ROLE = keccak256("ADMIN_ROLE");

    event AdminAdded(address indexed admin);
    event AdminRemoved(address indexed admin);

    constructor() {
        _setupRole(DEFAULT_ADMIN_ROLE, msg.sender);
        _setupRole(ADMIN_ROLE, msg.sender);
    }

    modifier onlyAdmin() {
        require(hasRole(ADMIN_ROLE, msg.sender), "Not an admin");
        _;
    }

    function addAdmin(address _admin) public onlyOwner {
        grantRole(ADMIN_ROLE, _admin);
        emit AdminAdded(_admin);
    }

    function removeAdmin(address _admin) public onlyOwner {
        revokeRole(ADMIN_ROLE, _admin);
        emit AdminRemoved(_admin);
    }

    function isAdmin(address _admin) public view returns (bool) {
        return hasRole(ADMIN_ROLE, _admin);
    }

    function transferOwnership(address newOwner) public override onlyOwner {
        _setupRole(DEFAULT_ADMIN_ROLE, newOwner);
        _setupRole(ADMIN_ROLE, newOwner);
        super.transferOwnership(newOwner);
    }
}
