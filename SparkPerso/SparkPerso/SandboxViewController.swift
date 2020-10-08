//
//  SandboxViewController.swift
//  SparkPerso
//
//  Created by  on 08/10/2020.
//  Copyright © 2020 AlbanPerli. All rights reserved.
//

import UIKit

class SandboxViewController: UIViewController {
    
    
    @IBOutlet weak var logLabel: UILabel!
    @IBOutlet weak var logTextView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func bridgeClicked(_ sender: Any) {
        Debugger.shared.log("sandbooooox")
        
        USBBridge.shared.connect {
            
        }
        
        USBBridge.shared.receivedMessage({ (str) in
            //print("Received \(str)")
            //Debugger.shared.log("Received \(str)")
            
            self.logTextView.text = str
        })
        
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
