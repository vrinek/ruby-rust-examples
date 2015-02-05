#![feature(std_misc)]
#![feature(libc)]

extern crate libc;
use std::ffi;
use std::str;

fn from_c_string(c_string: *const libc::c_char) -> String {
    unsafe {
        str::from_utf8(ffi::c_str_to_bytes(&c_string)).unwrap().to_string()
    }
}

fn to_c_string(rust_string: String) -> *const libc::c_char {
    ffi::CString::from_slice(rust_string.as_bytes()).as_ptr()
}

#[no_mangle]
pub extern "C" fn last_message() -> *const libc::c_char {
    to_c_string("We apologize for the inconvinience.".to_string())
}

#[no_mangle]
pub extern "C" fn greeting(gender: char) -> *const libc::c_char {
    to_c_string(match gender {
        'f' => "Miss",
        'm' => "Mister",
        _ => ""
    }.to_string())
}

#[no_mangle]
pub extern "C" fn format_address(c_street: *const libc::c_char, number: i32, c_city: *const libc::c_char) -> *const libc::c_char {

    let street = from_c_string(c_street);
    let city = from_c_string(c_city);

    let address = format!("{} {}, {}", street, number, city);

    to_c_string(address)
}
