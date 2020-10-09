//
//  SandboxViewController.swift
//  SparkPerso
//
//  Created by  on 08/10/2020.
//  Copyright © 2020 AlbanPerli. All rights reserved.
//

import UIKit
import Foundation

class SandboxViewController: UIViewController {
    
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
            let header = String(str.first!)
            
            if header == CommunicationHelper.header {
                let formatedData: CommunicationData = CommunicationHelper().formatDataToStruct(str)
                
            }
        })
    
    }
    
    @IBAction func standupClicked(_ sender: Any) {
        DogActivity.shared.standUpAction()
    }
    
    @IBAction func searchClicked(_ sender: Any) {
        DogActivity.shared.searchAction()
    }
    
    @IBAction func backClicked(_ sender: Any) {
        DogActivity.shared.backAction()
    }
    
    @IBAction func sitdownClicked(_ sender: Any) {
        DogActivity.shared.sitDownAction()
    }
    
    
    @IBAction func foundClicked(_ sender: Any) {
        DroneSequenciesManager.shared.clearSequencies()
    }
    
    
    @IBAction func stopClicked(_ sender: Any) {
        DronePilotManager.shared.stop()
    }
    
    
    
}
