include "../util/number.dfy"
include "../util/maps.dfy"
include "../util/tx.dfy"

import opened Number
import opened Maps
import opened Tx

class ERC20 {
    var balances: mapping<u160,u256>
    var allowance: mapping<u160, mapping<u160, u256>>

    method transferSpec(msg: Transaction, recipient: u160, amount: u256) returns (r: Result<()>)
    {
        var balance_sender_before := balances.Get(msg.sender);
        var balance_recip_before := balances.Get(recipient);
        r := transfer(msg, recipient, amount);
        var balance_sender_after := balances.Get(msg.sender);
        var balance_recip_after := balances.Get(recipient);

    }
    // // Operations on mathints can never overflow nor underflow
    // assert balance_sender_after == balance_sender_before - amount,
    //     "transfer must decrease sender's balance by amount";

    // assert balance_recip_after == balance_recip_before + amount,
    //     "transfer must increase recipient's balance by amount";
}