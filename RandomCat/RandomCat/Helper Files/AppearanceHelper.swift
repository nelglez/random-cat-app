//
//  AppearanceHelper.swift
//  RandomCat
//
//  Created by Nelson Gonzalez on 2/2/19.
//  Copyright © 2019 Nelson Gonzalez. All rights reserved.
//

import UIKit

enum AppearanceHelper {
    
    static var lightRedColor = UIColor(red: 243/255, green: 57/255, blue: 7/255, alpha: 0.5)

    static func setupAppearance() {
        //MARK: - Navigation Bar Appearance
        UINavigationBar.appearance().barTintColor = lightRedColor
        //bar button item text color
        UIBarButtonItem.appearance().tintColor = .white
        //Set nav bar title color
        let attributes = [NSAttributedString.Key.foregroundColor : UIColor.white]
        UINavigationBar.appearance().titleTextAttributes = attributes
        UINavigationBar.appearance().largeTitleTextAttributes = attributes
        

    }
    
}
