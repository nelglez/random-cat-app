//
//  ViewController.swift
//  RandomCat
//
//  Created by Nelson Gonzalez on 2/2/19.
//  Copyright © 2019 Nelson Gonzalez. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var catImageView: UIImageView!
    @IBOutlet weak var getCatButton: UIButton!
    @IBOutlet weak var showSavedImages: UIButton!
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    var catController: CatController = CatController()
    
    var cats: Cat? {
        didSet {
            updateViews()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
       
        catImageView.makeCorner(of: 30)
        getCatButton.makeCorner(of: 5)
        getCatButton.layer.borderColor = UIColor.black.cgColor
       getCatButton.layer.borderWidth = 1
        
        showSavedImages.makeCorner(of: 5)
        showSavedImages.layer.borderColor = UIColor.black.cgColor
        showSavedImages.layer.borderWidth = 1
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Save", style: .done, target: self, action: #selector(saveBarButtonPressed(_:)))
        
        self.navigationItem.rightBarButtonItem?.isEnabled = false
        
        
    }
    

    
    func updateViews() {
        guard let cats = cats else {
            
            return
            
        }
        guard let imageUrl = URL(string: cats.file), let imageData = try? Data(contentsOf: imageUrl) else {return}
        DispatchQueue.main.async {
            self.catImageView.image = UIImage(data: imageData)
            
        }
        
    }
    
    @IBAction func getCatButtonPressed(_ sender: UIButton) {
        getCatButton.isEnabled = false
        self.activityIndicator.startAnimating()
        
        catController.loadCats { (cat, error) in
            if error != nil {
                print(error!.localizedDescription)
            }
            
            self.cats = cat
            DispatchQueue.main.async {
                self.getCatButton.isEnabled = true
                self.navigationItem.rightBarButtonItem?.isEnabled = true
                self.activityIndicator.stopAnimating()
                
                
            }
        }
    }
    
    
    @IBAction func saveBarButtonPressed(_ sender: UIBarButtonItem) {
        
        
                if let cat = cats {
                catController.crateCat(url: cat.file)

                    performSegue(withIdentifier: "toTableVC", sender: self)

                    
                } else {
                    print("No Cat available")
                }
        
    }
//    
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        if segue.identifier == "toTableVC" {
//        let destinationVC = segue.destination as? SavedCatImagesTableViewController
//        destinationVC?.catController = catController
//        }
//    }
    
}

