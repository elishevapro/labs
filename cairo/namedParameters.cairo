fn foo(x: u8, y: u8) {}

fn main() {
    let firstArg = 2;
    let secondArg = 5;
    foo(x: firstArg, y: secondArg);

    let x = 2;
    let y = 5;
    foo(:x, :y);
}