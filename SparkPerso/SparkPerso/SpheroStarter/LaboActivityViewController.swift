//
//  LaboActivityViewController.swift
//  SparkPerso
//
//  Created by  on 19/10/2020.
//  Copyright © 2020 AlbanPerli. All rights reserved.
//

import UIKit

class LaboActivityViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func StartActivityClicked(_ sender: Any) {
        LaboActivityManager.shared.startActivity()
    }
    
    @IBAction func StopActivityClicked(_ sender: Any) {
        LaboActivityManager.shared.stopActivity()
    }
}
