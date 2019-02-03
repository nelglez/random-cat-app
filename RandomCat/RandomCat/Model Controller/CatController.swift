//
//  CatController.swift
//  RandomCat
//
//  Created by Nelson Gonzalez on 2/2/19.
//  Copyright © 2019 Nelson Gonzalez. All rights reserved.
//

import Foundation

class CatController {
    init() {
        loadFromPersistentStore()
    }
    
    private let baseUrl = URL(string: "https://aws.random.cat/meow")!
    private(set) var cats: [Cat] = []
    
   
    
    func loadCats(completion: @escaping(Cat?, Error?) -> Void){
        
        //create a url request But in this case we dont need it since we have a URL
        //let request = URLRequest(url: baseUrl)
        
        //Create URLSession with dataTask
        
        URLSession.shared.dataTask(with: baseUrl) { (data, _, error) in
            if let error = error {
                print("Error fetching data: \(error.localizedDescription)")
                completion(nil, error)
                return
            }
            
            guard let data = data else {
                print("No Data returned!")
                completion(nil, error)
                return
            }
            
            //Decode object
            
            let decoder = JSONDecoder()
            
            
            do {
                 let cats = try decoder.decode(Cat.self, from: data)
              //  self.cats.append(cats)
                completion(cats, nil)
            } catch {
                print("Error decoding data: \(error.localizedDescription)")
                completion(nil, error)
            }
            
        }.resume()
        
    }
    
    
    
    
    //MARK: - Basic persistance
    
    
    private var savedCatListURL: URL? {
        //Get the user's document directory using the FileManager class
        let fileManager = FileManager.default
        guard let documentsDirectory = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first else {return nil}
        // Create a filename string for the plist
        let finalLocation = documentsDirectory.appendingPathComponent("caturllist.plist")
        //Return a url that appends the filename string to the document directory. In doing this, you will create a full path wherein the Books in plist form will be stored on the user's device.
        return finalLocation
    }
    
    func saveToPersistentStore(){
        guard let url = savedCatListURL else {return}
        //Create an instance of PropertyListEncoder.
        let propertyListEncoder = PropertyListEncoder()
        //        Inside of a do-try-catch block create a constant called catsData. Using the encode(value: ...) function of the property list encoder, encode the cats array into Data.
        
        do {
            let catsData = try propertyListEncoder.encode(cats)
            //Call the write(to: URL) function on the data you encoded computed property. The url you pass in should be an unwrapped version of the readingListURL property.
            try catsData.write(to: url)
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func loadFromPersistentStore() {
        // Inside of a do-try-catch- block, unwrap the savedCatListURL property.
        guard let savedCatListURL = savedCatListURL, FileManager.default.fileExists(atPath: savedCatListURL.path) else { return }
        do {
            //Still inside of the block, use the Data(contentsOf: URL) initializer to get access to the property list form of the cats. Assign this data you initialize to a constant.
            let data = try Data(contentsOf: savedCatListURL)
            //Initialize a PropertyListDecoder and assign it to a constant.
            let decoder = PropertyListDecoder()
            //Create a constant called decodedCats. Set its value by calling the decode method on the property list decoder you just created, and passing in the type it should be decoded as, and the data constant you made a couple steps ago. (Hint: the type parameter to this function should be [Cat].self)
            let decodedCats = try decoder.decode([Cat].self, from: data)
            //Set the value of the books property in the CatController to the decodedCats you just made.
            cats = decodedCats
            
        } catch {
            //In the catch block, you should make an error message that is descriptive of what happened
            print(error.localizedDescription)
        }
    }
    
    
    //MARK: - CRUD
    
    func crateCat(url: String) {
        let catUrl = Cat(file: url)
        cats.append(catUrl)
        saveToPersistentStore()
    }
    
    func removeCat(cat: Cat) {
        guard let index = cats.index(of: cat) else {return}
        cats.remove(at: index)
        saveToPersistentStore()
    }
    
    
}
