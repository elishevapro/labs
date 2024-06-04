fn main() {
    let immutable: felt252 = 18;
    let mut mutable: felt252 = immutable;
    mutable = 234;
    assert(immutable != mutable, 'it had modified yet!!');
}
#[test]
fn testMain() {
    main();
}