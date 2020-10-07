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
    
    private var _speed: Float = 0.3
    
    // CONSTRUCTOR
    init() {
        
    }
    
    // DIRECTION HANDLER
    public func goUp() -> Void {
        if let mySpark = DJISDKManager.product() as? DJIAircraft {
            Debugger.shared.log("Drone is UP ...")
            mySpark.mobileRemoteController?.leftStickVertical = self._speed
        }
    }
    
    public func goDown() -> Void {
        if let mySpark = DJISDKManager.product() as? DJIAircraft {
            Debugger.shared.log("Drone is DOWN ...")
            mySpark.mobileRemoteController?.leftStickVertical = -self._speed
        }
    }
    
    public func goForward() -> Void {
        if let mySpark = DJISDKManager.product() as? DJIAircraft {
            Debugger.shared.log("Drone is FORWARD ...")
            mySpark.mobileRemoteController?.rightStickHorizontal = self._speed
        }
    }
    
    public func goBackward() -> Void {
        if let mySpark = DJISDKManager.product() as? DJIAircraft {
            Debugger.shared.log("Drone is BACKWARD ...")
            mySpark.mobileRemoteController?.rightStickHorizontal = -self._speed
        }
    }
    
    public func goLeft() -> Void {
        if let mySpark = DJISDKManager.product() as? DJIAircraft {
            Debugger.shared.log("Drone is LEFT ...")
            mySpark.mobileRemoteController?.rightStickHorizontal = -self._speed
        }
    }
    
    public func goRight() -> Void {
        if let mySpark = DJISDKManager.product() as? DJIAircraft {
            Debugger.shared.log("Drone is RIGHT ...")
            mySpark.mobileRemoteController?.rightStickHorizontal = self._speed
        }
    }
    
    public func landing() -> Void {
        if let spark = DJISDKManager.product() as? DJIAircraft {
            if let flightController = spark.flightController {
                Debugger.shared.log("Drone is LANDING ...")
                flightController.startLanding { (err) in
                    print(err.debugDescription)
                }
            }
        }
    }
    
    public func takeOff() -> Void {
        if let spark = DJISDKManager.product() as? DJIAircraft {
            if let flightController = spark.flightController {
                Debugger.shared.log("Drone is TAKEOFF ...")
                flightController.startTakeoff(completion: { (err) in
                    print(err.debugDescription)
                })
            }
        }
    }
    
    public func stop() {
        if let mySpark = DJISDKManager.product() as? DJIAircraft {
            Debugger.shared.log("Drone is STOP ...")
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
