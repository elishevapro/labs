use debug::PrintTrait;
fn main() {
    let flag = true;
    if flag {
        'flag is true'.print();
    }

    let awesome = true;
    let version:u8 = 2;

    if awesome && version > 0 {
        'lets code'.print();
    } else {
        'coming soon...'.print();
    }
}