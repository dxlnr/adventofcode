use std::env;
use std::fs;
use std::collections::HashMap;

fn read_file_string(filepath: &str) -> Result<String, Box<dyn std::error::Error>> {
    let data = fs::read_to_string(filepath)?;
    Ok(data)
}

fn find_calories(s: String) -> Option<HashMap<i32, i32>> {
    let mut r: HashMap<i32, i32>  = HashMap::new(); 
    let mut cs = s.split('\n').collect::<Vec<&str>>();

    println!("{:?}", &cs);
    None
}

fn main() {

    let ds = read_file_string("input");
    _ = find_calories(ds.unwrap());
}
