use std::fs;
use std::collections::BTreeMap;

fn read_file_string(filepath: &str) -> Result<String, Box<dyn std::error::Error>> {
    let data = fs::read_to_string(filepath)?;
    Ok(data)
}

fn find_calories(s: String) -> BTreeMap<i32, i32> {
    let mut r: BTreeMap<i32, i32>  = BTreeMap::new(); 
    let cs: Vec<Option<i32>> = s.split('\n').map(|s| s.parse::<i32>().ok()).collect();

    let mut idx = 1;
    let mut calories = 0;
    for c in cs.iter() {
        match c {
            None => {
                idx += 1;
                calories = 0;
            },
            Some(i) => {
                calories += i;
                r.insert(idx, calories);
            }
        }
    }
    r
}

fn max<K, V>(hm: &BTreeMap<K, V>) -> Option<(&K, &V)>
where
    V: Ord,
{
   hm 
        .iter()
        .max_by(|a, b| a.1.cmp(b.1))
        .map(|(k, v)| (k, v))
}

fn sort<K, V>(hm: &BTreeMap<K, V>) -> Vec<(&K, &V)>
where
    V: Ord,
{
    let mut v = Vec::from_iter(hm);
    v.sort_by(|&(_, a), &(_, b)| b.cmp(a));
    v
}


fn main() -> Result<(), Box<dyn std::error::Error>> {
    let ds = read_file_string("puzzle")?;
    let rmap = find_calories(ds);

    //  --- Part One ---
    let r1 = max(&rmap);
    match r1 {
        None => { println!("No elf found."); },
        Some(i) => {
            println!("(Elf, calories) {:?}", &i);
        },
    }

    //  --- Part Two ---
    let r2 = sort(&rmap);
    println!("(Elf, calories) {:?}", &r2[..3]);

    let mut sum = 0;
    for i in &r2[..3] {
        sum += i.1;
    }
    println!("\n\tTotal sum : {:?}", sum);

    Ok(())
}
