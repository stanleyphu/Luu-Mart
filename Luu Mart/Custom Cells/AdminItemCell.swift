//
//  AdminItemCell.swift
//  Luu Mart
//
//  Created by Stanley Phu on 12/10/17.
//  Copyright © 2017 Stanley Phu. All rights reserved.
//

import UIKit

class AdminItemCell: UITableViewCell {

    @IBOutlet weak var adminItemImageView: UIImageView!
    @IBOutlet weak var adminItemName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
