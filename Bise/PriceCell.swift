//
//  PriceCell.swift
//  Bise
//
//  Created by Grandon Lin on 2017-12-19.
//  Copyright © 2017 Grandon Lin. All rights reserved.
//

import UIKit

class PriceCell: UITableViewCell {

    @IBOutlet weak var priceAmountUnitLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func configureCell(price: Price) {
        priceAmountUnitLabel.text = "\(price.amount)/\(price.unit)"
    }

}
