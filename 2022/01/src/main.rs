use std::fs;
use std::collections::HashMap;

fn read_file_string(filepath: &str) -> Result<String, Box<dyn std::error::Error>> {
    let data = fs::read_to_string(filepath)?;
    Ok(data)
}

fn find_calories(s: String) -> HashMap<i32, i32> {
    let mut r: HashMap<i32, i32>  = HashMap::new(); 
    let cs: Vec<Option<i32>> = s.split('\n').map(|s| s.parse::<i32>().ok()).collect();

    let mut idx = 1;
    let mut calories = 0;
    for c in cs.iter() {
        match c {
            None => {
                idx = idx + 1;
                calories = 0;
            },
            Some(i) => {
                calories = calories + i;
                r.insert(idx, calories);
            }
        }
    }
    r
}

fn max<K, V>(hm: &HashMap<K, V>) -> Option<(&K, &V)>
where
    V: Ord,
{
   hm 
        .iter()
        .max_by(|a, b| a.1.cmp(&b.1))
        .map(|(k, v)| (k, v))
}

fn main() -> Result<(), Box<dyn std::error::Error>> {
    let ds = read_file_string("puzzle")?;
    let rmap = find_calories(ds);
    let r = max(&rmap);

    match r {
            None => { println!("No elf found."); },
            Some(i) => {
                println!("(Elf, calories) {:?}", &i);
            },
        }

    Ok(())
}
