#[macro_use(bson, doc)]
extern crate bson;
extern crate mongodb;

use bson::Bson;
use mongodb::{Client, ThreadedClient};
use mongodb::db::ThreadedDatabase;
use std::time::Duration;
use std::thread;

fn main() {
    let client = Client::connect("mongodb", 27017)
        .ok().expect("Failed to initialize standalone client.");

    let coll = client.db("test").collection("movies");

    loop {

        let doc = doc! { "title" => "Jaws",
                        "array" => [ 1, 2, 3 ] };

        // Insert document into 'test.movies' collection
        coll.insert_one(doc.clone(), None)
            .ok().expect("Failed to insert document.");

        println!("Inserted movie in db");

        // Find the document and receive a cursor
        let mut cursor = coll.find(Some(doc.clone()), None)
            .ok().expect("Failed to execute find.");

        let item = cursor.next();

        // cursor.next() returns an Option<Result<Document>>
        match item {
            Some(Ok(doc)) => match doc.get("title") {
                Some(&Bson::String(ref title)) => println!("Fetched movie {} from db", title),
                _ => panic!("Expected title to be a string!"),
            },
            Some(Err(_)) => panic!("Failed to get next from server!"),
            None => panic!("Server returned no results!"),
        }

        thread::sleep(Duration::from_secs(2))
    }
}