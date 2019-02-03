//
//  SavedCatImagesTableViewCell.swift
//  RandomCat
//
//  Created by Nelson Gonzalez on 2/2/19.
//  Copyright © 2019 Nelson Gonzalez. All rights reserved.
//

import UIKit

class SavedCatImagesTableViewCell: UITableViewCell {
    
    @IBOutlet weak var catImageView: UIImageView!
    
    
    var cats: Cat? {
        didSet {
            updateView()
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func updateView(){
        guard let cat = cats else {return}
        guard let imageUrl = URL(string: cat.file), let imageData = try? Data(contentsOf: imageUrl) else {return}
        catImageView.image = UIImage(data: imageData)
      //  catImageView.makeCorner(of: 50)
    }

    

}
