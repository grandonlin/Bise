//
//  StoreSetupVC.swift
//  Bise
//
//  Created by Grandon Lin on 2017-11-27.
//  Copyright © 2017 Grandon Lin. All rights reserved.
//

import UIKit

class OwnerSetupVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.setNavigationBarHidden(false, animated: true)
        self.navigationItem.hidesBackButton = true
    }

    

}
