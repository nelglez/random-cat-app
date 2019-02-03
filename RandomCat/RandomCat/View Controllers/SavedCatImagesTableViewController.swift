//
//  SavedCatImagesTableViewController.swift
//  RandomCat
//
//  Created by Nelson Gonzalez on 2/2/19.
//  Copyright © 2019 Nelson Gonzalez. All rights reserved.
//

import UIKit

class SavedCatImagesTableViewController: UITableViewController {
    
    var catController = CatController()

    override func viewDidLoad() {
        super.viewDidLoad()

       tableView.separatorStyle = .none
    }

    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
            self.tableView.reloadData()
 
    }
   

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       
        return catController.cats.count
    }

   
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "savedCatCell", for: indexPath) as! SavedCatImagesTableViewCell

        let cats = catController.cats[indexPath.row]
        
        cell.cats = cats
        

        return cell
    }
   

    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            
            let cat = catController.cats[indexPath.row]
            
            catController.removeCat(cat: cat)
            
            tableView.deleteRows(at: [indexPath], with: .fade)
            
            tableView.reloadData()
        }
    }
   

}
