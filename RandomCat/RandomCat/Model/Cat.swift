//
//  Cat.swift
//  RandomCat
//
//  Created by Nelson Gonzalez on 2/2/19.
//  Copyright © 2019 Nelson Gonzalez. All rights reserved.
//

import Foundation

struct Cat: Equatable, Codable {
    let file: String
    
    init(file: String) {
        self.file = file
    }
}
