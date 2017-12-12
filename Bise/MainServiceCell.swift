//
//  MainServiceCell.swift
//  Bise
//
//  Created by Grandon Lin on 2017-12-08.
//  Copyright © 2017 Grandon Lin. All rights reserved.
//

import UIKit

class MainServiceCell: UITableViewCell {
    

    @IBOutlet weak var serviceNameLbl: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        
        
    }
    
    func configureCell(service: Service) {
        serviceNameLbl.text = service.serviceName
    }
    

}
