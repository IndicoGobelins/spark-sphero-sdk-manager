//
//  SpheroPilotManager.swift
//  SparkPerso
//
//  Created by Théo Champion on 06/10/2020.
//  Copyright © 2020 AlbanPerli. All rights reserved.
//

import Foundation

class SpheroPilotManager: TwoDimPilotManager {
    private var _spheroTarget: BoltToy? = nil
    private var _speed: Double = 125
    private var _heading: Double = 0
    private var _referenceHeading: Double = 0
    public static var shared = SpheroPilotManager()
    
    init() {
        self.setSpheroTarget(spheroNumber: 1)
    }
    
    func stop() {
        if let sphero = self._spheroTarget {
            sphero.stopRoll(heading: self._heading)
            Debugger.shared.log("Sphero is STOP with speed : \(self._speed) and heading : \(self._heading)")
        }
    }
    
    func goForward() {
        if let sphero = self._spheroTarget {
            self._heading = self._referenceHeading
            sphero.roll(heading: self._heading, speed: self._speed)
            Debugger.shared.log("Sphero is FORWARD with speed : \(self._speed) and heading : \(self._heading)")
        }
    }
    
    func goBackward() {
        if let sphero = self._spheroTarget {
            self._heading = self._referenceHeading
            sphero.roll(heading: self._heading, speed: self._speed, rollType: .roll, direction: .reverse)
            Debugger.shared.log("Sphero is BACKWARD with speed : \(self._speed) and heading : \(self._heading)")
        }
    }
    
    func goLeft() {
        if let sphero = self._spheroTarget {
            self._heading = self._referenceHeading - 90.0
            sphero.roll(heading: self._heading, speed: self._speed)
            Debugger.shared.log("Sphero is LEFT with speed : \(self._speed) and heading : \(self._heading)")
        }
    }
    
    func goRight() {
        if let sphero = self._spheroTarget {
            self._heading = self._referenceHeading + 90.0
            sphero.roll(heading: self._heading, speed: self._speed)
            Debugger.shared.log("Sphero is RIGHT with speed : \(self._speed) and heading : \(self._heading)")
        }
    
    }
    
    public func setSpheroTarget(spheroNumber: Int) -> Void {
        let index = spheroNumber - 1
        
        if spheroNumber <= SharedToyBox.instance.bolts.count {
            let sphero = SharedToyBox.instance.bolts[index]
            self._spheroTarget = sphero
//            _spheroTarget?.setToyOptions(.EnableVectorDrive)
//            _spheroTarget?.setStabilization(state: .on)
        }
    }
    
    // SETTERS
    public func setSpeed(_ speed: Double) -> Void {
        self._speed = speed
    }
    
    public func setHeading(_ heading: Double) -> Void {
        self._heading = heading
    }
    
    public func setReferenceHeading(_ referenceheading: Double) -> Void {
        self._referenceHeading = referenceheading
    }
    
    public func setSpheroTargetFromDevice(sphero: Router.Device) -> SpheroPilotManager {
        switch sphero {
        case .SPHERO1:
            self.setSpheroTarget(spheroNumber: 1)
        case .SPHERO2:
            self.setSpheroTarget(spheroNumber: 2)
        default:
            self.setSpheroTarget(spheroNumber: 1)
        }
        
        return self
    }
    
    // GETTERS
    public func getSpeed() -> Double {
        return self._speed
    }
    
    public func getHeading() -> Double {
        return self._heading
    }
    
    public func getReferenceHeading() -> Double {
        return self._referenceHeading
    }
    
}
