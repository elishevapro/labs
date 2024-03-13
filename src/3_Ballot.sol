// SPDX-License-Identirier: GPL-0.3
pragma solidity >=0.7.0 <0.9.0;
/**
* @title Ballot
* @dev Implements voting process along with vote delegation
*/
contract Ballot {
    struct Voter {
        uint weight; //weight is accumulated by delegation??
        bool voted; // this person already voted or not
        address delegate; //voter address
        uint vote; // voted proposal' index
    }
    struct Proposal {
        // up to 32 bytes is the best, 'cause it cheaper
        bytes32 name;
        uint voteCount;
    }
    // *the "manager"
    address public chairperson;
    mapping(address => Voter) public voters;
    Proposal[] public proposals;
    /**
    * @dev Generate a ballot to choose one of 'proposalNames'
    * @param proposalNames names of proposals
    */
    //* what is memory??
    constructor(bytes32[] memory proposalNames) {
        chairperson = msg.sender;
        voters[chairperson].weight = 1;
        for(uint i = 0; i < proposalNames.length; i++) {
            // 'Proposal({...})' creates a temporary
            // proposal object and 'proposal.push(...)'
            // appends it to the end of 'proposals'.
            proposals.push(Proposal({
                name: proposalNames[i],
                voteCount: 0
            }));
        }
    }
    
}