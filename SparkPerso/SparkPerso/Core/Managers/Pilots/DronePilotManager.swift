//
//  DronePilotManager.swift
//  SparkPerso
//
//  Created by Théo Champion on 06/10/2020.
//  Copyright © 2020 AlbanPerli. All rights reserved.
//

import Foundation
import DJISDK


class DronePilotManager: ThreeDimPilotManager {
    // CONSTANTS
    enum Action {
        case FORWARD
        case BACKWARD
        case LEFT
        case RIGHT
        case UP
        case DOWN
        case LANDING
        case TAKEOFF
        case STOP
    }
    
    // PROPERTIES
    public static var shared: DronePilotManager = DronePilotManager()
    private var _speed: Float = 0.1
    
    // CONSTRUCTOR
    init() {
        
    }
    
    // DIRECTION HANDLER
    public func goUp() -> Void {
        Debugger.shared.log("Drone is UP with speed : \(self._speed)")
        if let mySpark = DJISDKManager.product() as? DJIAircraft {
            mySpark.mobileRemoteController?.leftStickVertical = self._speed
        }
    }
    
    public func goDown() -> Void {
        Debugger.shared.log("Drone is DOWN with speed : \(self._speed)")
        if let mySpark = DJISDKManager.product() as? DJIAircraft {
            mySpark.mobileRemoteController?.leftStickVertical = -self._speed
        }
    }
    
    public func goForward() -> Void {
        Debugger.shared.log("Drone is FORWARD with speed : \(self._speed)")
        if let mySpark = DJISDKManager.product() as? DJIAircraft {
            mySpark.mobileRemoteController?.rightStickVertical = self._speed
        }
    }
    
    public func goBackward() -> Void {
        Debugger.shared.log("Drone is BACKWARD with speed : \(self._speed)")
        if let mySpark = DJISDKManager.product() as? DJIAircraft {
            mySpark.mobileRemoteController?.rightStickVertical = -self._speed
        }
    }
    
    public func goLeft() -> Void {
        Debugger.shared.log("Drone is LEFT with speed : \(self._speed)")
        if let mySpark = DJISDKManager.product() as? DJIAircraft {
            mySpark.mobileRemoteController?.rightStickHorizontal = -self._speed
        }
    }
    
    public func goRight() -> Void {
        Debugger.shared.log("Drone is RIGHT with speed : \(self._speed)")
        if let mySpark = DJISDKManager.product() as? DJIAircraft {
            mySpark.mobileRemoteController?.rightStickHorizontal = self._speed
        }
    }
    
    public func landing() -> Void {
        Debugger.shared.log("Drone is LANDING ...")
        if let spark = DJISDKManager.product() as? DJIAircraft {
            if let flightController = spark.flightController {
                flightController.startLanding { (err) in
                    print(err.debugDescription)
                }
            }
        }
    }
    
    public func takeOff() -> Void {
        Debugger.shared.log("Drone is TAKEOFF ...")
        if let spark = DJISDKManager.product() as? DJIAircraft {
            if let flightController = spark.flightController {
                flightController.startTakeoff(completion: { (err) in
                    print(err.debugDescription)
                    })
            }
        }
    }
    
    public func stop() {
        Debugger.shared.log("Drone is STOP with speed : \(self._speed)")
        if let mySpark = DJISDKManager.product() as? DJIAircraft {
            mySpark.mobileRemoteController?.leftStickVertical = 0.0
            mySpark.mobileRemoteController?.leftStickHorizontal = 0.0
            mySpark.mobileRemoteController?.rightStickHorizontal = 0.0
            mySpark.mobileRemoteController?.rightStickVertical = 0.0
        }
    }
    
    // SETTERS
    public func setSpeed(_ speed: Float) -> Void {
        self._speed = speed
    }
    
    // GETTERS
    public func getSpeed(_ speed: Float) -> Float {
        return self._speed
    }
    
}
