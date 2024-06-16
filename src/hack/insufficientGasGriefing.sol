// // SPDX-Identifier-License: UNLICENSE
// pragma solidity ^0.8.19;

// contract Relayer {
//     mapping(bytes=>bool) public executed;
//     function relayer(bytes _data) public {
//         require(gasleft() >= _gasLimit, "no gas");
//         require(executed[_data] ==0, "duplicate call");
//         executed[_data] = 1;
//         innerContract.call(bytes4(keccak256("execute(bytes)")), _data);
//     }
// }