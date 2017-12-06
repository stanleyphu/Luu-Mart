//
//  CartItemCell.swift
//  Luu Mart
//
//  Created by Stanley Phu on 12/4/17.
//  Copyright © 2017 Stanley Phu. All rights reserved.
//

import UIKit

class CartItemCell: UITableViewCell {

    var callback : (() -> Void)?
    @IBOutlet weak var cartItemImageView: UIImageView!
    @IBOutlet weak var cartItemName: UILabel!
    @IBOutlet weak var cartItemPrice: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func removeButtonPressed(_ sender: UIButton) {
        ShoppingCart.shoppingCart.cartItems.remove(at: sender.tag)
        callback?()
    }
}
