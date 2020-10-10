//
//  DroneCameraManager.swift
//  SparkPerso
//
//  Created by  on 09/10/2020.
//  Copyright © 2020 AlbanPerli. All rights reserved.
//

import Foundation
import DJISDK

class DroneCameraManager {
    
    private var _startDetectQrcodeHook: () -> () = { }
    public static var shared = DroneCameraManager()
    
    public func getCamera() -> DJICamera? {
        if let mySpark = DJISDKManager.product() as? DJIAircraft {
             return mySpark.camera
        }
        return nil
    }
    
    public func lookUnder() -> Void {
        GimbalManager.shared.lookUnder()
    }
    
    public func lookFront() -> Void {
        GimbalManager.shared.lookFront()
    }
    
    public func startDetectQrcode() -> Void {
        self._startDetectQrcodeHook()
    }
    
    public func onStartDetectQrcode(hookCallback: @escaping () -> ()) -> Void {
        self._startDetectQrcodeHook = hookCallback
    }
}
