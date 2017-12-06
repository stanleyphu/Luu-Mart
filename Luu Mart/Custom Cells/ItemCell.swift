//
//  ItemCell.swift
//  Luu Mart
//
//  Created by Stanley Phu on 12/3/17.
//  Copyright © 2017 Stanley Phu. All rights reserved.
//

import UIKit
import SVProgressHUD

class ItemCell: UITableViewCell {

    @IBOutlet weak var itemImageView: UIImageView!
    @IBOutlet weak var itemName: UILabel!
    @IBOutlet weak var itemPrice: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func addButtonPressed(_ sender: UIButton) {
        ShoppingCart.shoppingCart.cartItems.append(Item(name: itemName.text!, price: itemPrice.text!, image: itemImageView.image!))
        SVProgressHUD.showSuccess(withStatus: "Added!")
        SVProgressHUD.dismiss(withDelay: 1)
        print(ShoppingCart.shoppingCart.cartItems.count)
    }
    
}
