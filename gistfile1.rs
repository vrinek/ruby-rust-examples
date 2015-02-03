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
    let point = Box::new(Point { x: x, y: y });

    println!("new point {:p} => ({}, {})", &*point, x, y);

    point
}

#[no_mangle]
pub extern "C" fn get_distance(p1: Box<Point>, p2: Box<Point>) -> f64 {
    println!("{:p} => ({}, {})", &*p1, p1.x, p1.y);
    println!("{:p} => ({}, {})", &*p2, p2.x, p2.y);

    Line {p1: *p1, p2: *p2}.length()
}
