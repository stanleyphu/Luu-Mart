//
//  Item.swift
//  Luu Mart
//
//  Created by Stanley Phu on 12/4/17.
//  Copyright © 2017 Stanley Phu. All rights reserved.
//

import UIKit

class Item {
    
    var itemName : String = ""
    var itemPrice : String = ""
    var itemImage : UIImage?
    
    init() {
        
    }
    
    init(name: String, price: String, image: UIImage) {
        itemName = name
        itemPrice = price
        itemImage = image
    }
    
}
