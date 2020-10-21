//
//  CollectCluesActivity.swift
//  SparkPerso
//
//  Created by  on 09/10/2020.
//  Copyright © 2020 AlbanPerli. All rights reserved.
//

import Foundation

class CollectCluesActivity: BaseActivity {
    public static var shared: CollectCluesActivity = CollectCluesActivity()
    
    public func goForwardAction(device: Router.Device) -> Void {
        SpheroPilotManager.shared
            .setSpheroTargetFromDevice(sphero: device)
            .goForward()
    }
    
    public func goBackwardAction(device: Router.Device) -> Void {
        SpheroPilotManager.shared
            .setSpheroTargetFromDevice(sphero: device)
            .goBackward()
    }
    
    public func goLeftAction(device: Router.Device) -> Void {
        SpheroPilotManager.shared
            .setSpheroTargetFromDevice(sphero: device)
            .goLeft()
    }
    
    public func goRightAction(device: Router.Device) -> Void {
        SpheroPilotManager.shared
            .setSpheroTargetFromDevice(sphero: device)
            .goRight()
    }
    
    public func stopAction(device: Router.Device) -> Void {
        SpheroPilotManager.shared
            .setSpheroTargetFromDevice(sphero: device)
            .stop()
    }
    
    public func collectAction(device: Router.Device) -> Void {
        Debugger.shared.log("collectionAction method triggered from CollectCluesActivity class")
        SpheroLedManager.shared
            .setSpheroTargetFromDevice(sphero: device)
            .drawPatternInScreen(givenPattern: "blood")
    }
}
