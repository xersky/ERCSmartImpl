/* ERC-20 token Standard Interface
 * Doc from:
 * https://github.com/ethereum/ercs/blob/master/ERCS/erc-20.md
*/

pragma solidity ^0.8.24;

interface ERC20Interface {

    //Methods

    //According to the documentation, name(), symbol() and decimal() methods are optional.

    //----------------------- OPTIONAL -----------------------\\
    function name() public view returns (string);

    function symbol() public view returns (string);

    function decimals() public view returns (uint8);
    //--------------------------------------------------------\\

    function totalSupply() public view returns (uint256);

    function balanceOf(address _owner) public view returns (uint256 balance);

    function transfer(address _to, uint256 _value) public returns (bool success);

    function transferFrom(address _from, address _to, uint256 _value) public returns (bool success);

    function approve(address _spender, uint256 _value) public returns (bool success);

    function allowance(address _owner, address _spender) public view returns (uint256 remaining);

    //Events

    event Transfer(address indexed _from, address indexed _to, uint256 _value);

    event Approval(address indexed _owner, address indexed _spender, uint256 _value);

}