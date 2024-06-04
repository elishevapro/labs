fn main(x: felt252, y: felt252) {
    assert(x != y, 'error, x equal y');
}
#[test]
fn testMain() {
    main(1, 2);
}