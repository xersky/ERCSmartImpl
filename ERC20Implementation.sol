// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import {ERC20Interface} from "./ERC20Interface.sol";

/**
   * @title ERC20Implementation
   * @dev ContractDescription
   * @custom:dev-run-script scripts/deploy_with_ethers.ts
   */
abstract contract ERC20Implementation is ERC20Interface {
    mapping (address account => uint256) private _balances;
    mapping (address account => mapping (address spender => uint256)) private _allowances;
    uint256 private _totalSupply;
    string private _name;
    string private _symbol;
    uint8 private _decimals;

    constructor(string memory name_, string memory symbol_) {
        _name = name_;
        _symbol = symbol_;
        _decimals = 18;
    }

    //virtual to allow inheriting contracts to override the behavior
    function name() public view virtual returns (string memory) {
        return _name;
    }

    function symbol() public view virtual returns (string memory) {
        return _symbol;
    }
    
    function decimals() public view virtual returns (uint8) {
        return _decimals;
    }

    function totalSupply() public view virtual returns (uint256) {
        return _totalSupply;
    }

    function balanceOf(address owner) public view virtual returns (uint256) {
        return _balances[owner];
    }

/*     function _setDecimals(uint8 decimals_) internal {
        _decimals = decimals_;
    } */

    function transfer(address to, uint256 value) public virtual returns (bool) {
        address from = msg.sender;
        _transfer(from, to, value);
        return true;
    }

    function transferFrom(address from, address to, uint256 value) public virtual returns (bool) {
        address spender = msg.sender;
        _transfer(from, to, value);
        _approve(from, spender, _allowances[from][spender] - value);
        return true;
    }

    function allowance(address owner, address spender) public view virtual returns (uint256) {
        return _allowances[owner][spender];
    }

    function increaseAllowance(address spender, uint256 addedValue) public virtual returns (bool) {
        address owner = msg.sender;
        _approve(owner, spender, _allowances[owner][spender] + addedValue);
        return true;
    }

    function decreaseAllowance(address spender, uint256 subtractedValue) public virtual returns (bool) {
        address owner = msg.sender;
        _approve(owner, spender, _allowances[owner][spender] - subtractedValue);
        return true;
    }

    function approve(address spender, uint256 value) public virtual returns (bool) {
        address owner = msg.sender;
        _approve(owner, spender, value);
        return true;
    }

    function _approve(address owner, address spender, uint256 value) internal virtual {
        require(owner != address(0), "ERC20: approve from the zero address");
        require(spender != address(0), "ERC20: approve to the zero address");

        _allowances[owner][spender] = value;

        emit Approval(owner, spender, value);
    }

    function _transfer(address from, address to, uint256 value) internal virtual {
        require(from != address(0), "ERC20: transfer from the zero address");
        require(to != address(0), "ERC20: transfer to the zero address");

        _beforeTokenTransfer(from, to, value);

        _balances[from] = _balances[from] - value;
        _balances[to] = _balances[to] + value;

        emit Transfer(from, to, value);
    }

    function _mint(address owner, uint256 value) internal virtual {
        require(owner != address(0), "ERC20: mint to the zero address");
        _beforeTokenTransfer(address(0), owner, value);
        _totalSupply = _totalSupply + value;
        _balances[owner] = _balances[owner] + value;
        emit Transfer(address(0), owner, value);
    }
    
    function _burn(address owner, uint256 value) internal virtual {
        require(owner != address(0), "ERC20: burn from the zero address");
        _beforeTokenTransfer(owner, address(0), value);
        _balances[owner] = _balances[owner] - value;
        _totalSupply = _totalSupply - value;
        emit Transfer(owner, address(0), value);
    }

    function _beforeTokenTransfer(address from, address to, uint256 value) internal virtual { }

}
