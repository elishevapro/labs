// use cairo_math_64x61::Math64x61;
// use starkware.cairo.common.math256;

// use traits::TryInto;
// use option::OptionTrait;
use core::panic_with_felt252;

use dict::Felt252DictTrait;
use array::ArrayTrait;
use debug::PrintTrait;
fn rotate(imageData: @Array<u256>, degress: u256) -> Array<u256> {
    let width = 3;
    // let width: u256 = Math64x61::sqrt(array_len(imageData));
    let height = width;
    let mut dict_rotateImage = felt252_dict_new::<u32>();
    if degress == 90 {
        let mut i: u32 = 0;
        let mut j: u32 = 0;
        loop {
            if i == width { 
                break ();
            }
            j = 0;
            loop {
                if j == height {
                    break();
                }
                let newIndex: felt252 = ((j*width) + (width - i - 1)).into();
                let value: u32 = (*imageData.at(i * height + j)).try_into().unwrap();
                dict_rotateImage.insert(newIndex, value);
                j = j+ 1;
            };
            i = i + 1;
        };
    } else if degress == 270 {
        let mut i: u32 = 0;
        let mut j: u32 = 0;
        loop {
            if i == width { 
                break ();
            }
            j = 0;
            loop {
                if j == height {
                    break();
                }
                let newIndex: felt252 = (((height - j - 1) * width) + i).into();
                let value: u32 = (*imageData.at(i * height + j)).try_into().unwrap();
                dict_rotateImage.insert(newIndex, value);
                j = j+ 1;
            };
            i = i + 1;
        };        
    } else {
        let x = 404;
        panic_with_felt252(x);
    }
    let mut rotatedImage:Array<u256> = ArrayTrait::new();
    let mut k: u32 = 0;
    loop {
        if k == imageData.len() {
            break();
        }
        let newIndex: felt252 = (k).into();
        let value: u256 = dict_rotateImage[newIndex].into();
        rotatedImage.append(value);
        k = k + 1;
    };
    rotatedImage
}

fn main() {
    let mut a = ArrayTrait::new();
    a.append(3);
    a.append(10);
    a.append(3);
    a.append(10);
    a.append(2);
    a.append(3);
    a.append(10);
    a.append(3);
    a.append(10);
    a.append(2);
    rotate(@a, 90);
    'success'.print();
}