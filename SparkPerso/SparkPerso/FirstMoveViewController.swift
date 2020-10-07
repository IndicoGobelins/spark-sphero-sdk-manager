//
//  FirstMoveViewController.swift
//  SparkPerso
//
//  Created by Alban on 23/09/2020.
//  Copyright © 2020 AlbanPerli. All rights reserved.
//

import UIKit
import DJISDK
class FirstMoveViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func stopOnUp(_ sender: Any) {
        
    }
    @IBAction func frontClicked(_ sender: Any) {
        DronePilotManager.shared.goForward()

    }
    
    @IBAction func lefftClicked(_ sender: Any) {
        DronePilotManager.shared.goLeft()

    }
    
    @IBAction func rightClicked(_ sender: Any) {
        DronePilotManager.shared.goRight()
    }
    
    @IBAction func backClicked(_ sender: Any) {
        DronePilotManager.shared.goBackward()
    }

    
    @IBAction func stopClicked(_ sender: UIButton){
        DronePilotManager.shared.stop()
    }
    
    @IBAction func takeOffClicked(_ sender: Any) {
        DronePilotManager.shared.takeOff()
    }
    
    @IBAction func landingClicked(_ sender: Any) {
        DronePilotManager.shared.landing()
    }
    
    @IBAction func upClicked(_ sender: Any) {
        DronePilotManager.shared.goUp()
    }
    
    @IBAction func downClicked(_ sender: Any) {
        DronePilotManager.shared.goDown()
    }
    
    @IBAction func startSeqClicked(_ sender: Any) {
        Debugger.shared.log("HELLOOO")
        
        let sequencies: [Sequence] = [
            Sequence(speed: 0.2, action: DronePilotManager.Action.TAKEOFF, duration: 4),
            Sequence(speed: 0.2, action: DronePilotManager.Action.FORWARD, duration: 2),
            Sequence(speed: 0.2, action: DronePilotManager.Action.RIGHT, duration: 2),
            Sequence(speed: 0.2, action: DronePilotManager.Action.BACKWARD, duration: 2),
            Sequence(speed: 0.2, action: DronePilotManager.Action.LEFT, duration: 2),
            Sequence(speed: 0.2, action: DronePilotManager.Action.LANDING, duration: 4),
        ]
        
        DroneSequenciesManager.shared.setSequencies(sequencies).play()
    }

    
    @IBAction func stopSequenceClicked(_ sender: Any) {
        DroneSequenciesManager.shared.clearSequencies()
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
