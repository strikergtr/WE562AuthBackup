//
//  NShopCell.swift
//  Authentication
//
//  Created by Instructor on 11/11/2566 BE.
//

import UIKit

class NShopCell: UITableViewCell {
    
    @IBOutlet var itemImage : UIImageView!
    @IBOutlet var itemName : UILabel!
    @IBOutlet var itemPrice : UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
