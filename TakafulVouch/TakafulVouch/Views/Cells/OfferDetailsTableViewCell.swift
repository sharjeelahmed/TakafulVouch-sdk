//
//  OfferDetailsTableViewCell.swift
//  Vouch365
//
//  Created by Veer Suthar on 11/26/17.
//  Copyright © 2017 Veer Suthar. All rights reserved.
//

import UIKit

class OfferDetailsTableViewCell: UITableViewCell {

    @IBOutlet weak var imageview_available : UIImageView!
    @IBOutlet weak var label_available : UILabel!

    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
