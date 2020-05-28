//
//  AlternateTableViewCell.swift
//  SearchController
//
//  Created by Stuart Breckenridge on 2/9/14.
//  Copyright (c) 2014 Stuart Breckenridge. All rights reserved.
//

import UIKit

class AlternateTableViewCell: UITableViewCell {

    @IBOutlet weak var hugeCountryLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configureCell(countryName:String)
    {
        hugeCountryLabel.text = countryName
    }

}
