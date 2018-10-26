//
//  RestaurantCells.swift
//  RestaurantsTozny
//
//  Created by Joshua  Rambert on 10/26/18.
//  Copyright © 2018 Joshua Rambert. All rights reserved.
//

import Foundation
import UIKit

class RestaurantCells: UITableViewCell {
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    //Smaller functions for cell classes -- atleast thats the idea
    func getRestaurantInfo(name: String, rating: String){
        restaurantTitle.text = name
        
        if rating == "0"{
            ratingLabel.text = "nil"
        } else {
            ratingLabel.text = "\(rating) out of 5"
        }
        
    }
    
    //MARK Properties
    @IBOutlet private weak var restaurantTitle: UILabel!
    @IBOutlet private weak var ratingLabel: UILabel!
}
