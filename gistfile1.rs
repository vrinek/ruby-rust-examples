#![feature(core)]
#![allow(missing_copy_implementations)]

use std::num::Int;
use std::num::Float;

pub struct Point { x: i32, y: i32 }
struct Line  { p1: Point, p2: Point }

impl Line {
  pub fn length(&self) -> f64 {
    let xdiff = self.p1.x - self.p2.x;
    let ydiff = self.p1.y - self.p2.y;
    ((xdiff.pow(2) + ydiff.pow(2)) as f64).sqrt()
  }
}

#[no_mangle]
pub extern "C" fn make_point(x: i32, y: i32) -> Box<Point> {
    Box::new(Point { x: x, y: y })
}

#[no_mangle]
pub extern "C" fn get_distance(p1: Box<Point>, p2: Box<Point>) -> f64 {
    Line {p1: *p1, p2: *p2}.length()
}
