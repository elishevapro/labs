pragma solidity ^0.8.19;

import "./structDeclaration.sol";

contract Struct {
    Todo[] public todos;
    function create(string calldata _text) public {
        todos.push(Todo(_text, false));
        todos.push(Todo({text: _text, completed: false}));
        Todo memory t;
        t.text = _text;
        todos.push(t);
    }
    function get(uint index) public view returns (string memory _text, bool completed) {
        Todo storage t = todos[index];
        return (t.text, t.completed);
    }
    function changeText(string calldata _text, uint index) public {
        Todo storage t = todos[index];
        t.text = _text;
    }
    function toggleCompleted(uint index) public {
        Todo storage t = todos[index];
        t.completed = !t.completed;
    }
}