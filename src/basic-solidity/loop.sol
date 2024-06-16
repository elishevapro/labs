pragma solidity ^0.8.19;

contract Loop {
    function loop() public pure{
        for(uint i = 0; i < 10; i++) {
            if (i == 3)
                continue; //skip this iteration
            if (i == 5)
                break;
        }
        uint x = 0;
        while (x < 10)
            x++;
    }
}