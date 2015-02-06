#![feature(std_misc)]
#![feature(libc)]

extern crate libc;
extern crate crypto;
use crypto::digest::Digest;

fn from_c_string(c_string: *const libc::c_char) -> String {
    unsafe {
        std::str::from_utf8(std::ffi::c_str_to_bytes(&c_string)).unwrap().to_string()
    }
}

fn to_c_string(rust_string: String) -> *const libc::c_char {
    std::ffi::CString::from_slice(rust_string.as_bytes()).as_ptr()
}

static SALT: &'static str = "moufa";

#[no_mangle]
pub extern "C" fn md5_int(num: i32) -> *const libc::c_char {
    to_c_string(_md5_int(num))
}

fn _md5_int(num: i32) -> String {
    let hash_str = format!("{}{}", SALT, num);
    let mut sh = crypto::md5::Md5::new();

    sh.input_str(&hash_str);
    sh.result_str()
}

#[test]
fn md5_int_for_42() {
    assert_eq!(_md5_int(42), "15d2e6411b3b0f078049aa0a156889f0");
}

#[test]
fn md5_int_for_123() {
    assert_eq!(_md5_int(123), "cbb1747730a326d9587b6c8fdb1d8d84");
}

#[no_mangle]
pub extern "C" fn md5_str(string: *const libc::c_char) -> *const libc::c_char {
    to_c_string(_md5_str(from_c_string(string)))
}

fn _md5_str(string: String) -> String {
    let hash_str = format!("{}{}", SALT, string);
    let mut sh = crypto::md5::Md5::new();

    sh.input_str(&hash_str);
    sh.result_str()
}

#[test]
fn md5_str_for_42() {
    assert_eq!(_md5_str("42".to_string()), "15d2e6411b3b0f078049aa0a156889f0");
}

#[test]
fn md5_str_for_123() {
    assert_eq!(_md5_str("123".to_string()), "cbb1747730a326d9587b6c8fdb1d8d84");
}

#[test]
fn md5_str_for_secret() {
    assert_eq!(_md5_str("secret".to_string()), "d28d9f5753ab86b22f0f173253bf0e7c");
}
