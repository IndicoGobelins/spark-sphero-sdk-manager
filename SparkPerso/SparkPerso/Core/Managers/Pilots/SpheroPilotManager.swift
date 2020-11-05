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
    private var _headingTarget: Heading? = nil
    private var _speed: Double = 90
    private var _heading1: Heading = Heading()
    private var _heading2: Heading = Heading()
    public static var shared = SpheroPilotManager()
    
    init() {
        self.setSpheroTarget(spheroNumber: 1)
    }
    
    func stop() {
        if let sphero = self._spheroTarget {
            if let heading = self._headingTarget {
                sphero.stopRoll(heading: heading.value)
                Debugger.shared.log("Sphero is STOP with speed : \(self._speed) and heading : \(heading.value)")
            }
        }
    }
    
    func goForward() {
        if let sphero = self._spheroTarget {
            if let heading = self._headingTarget {
                heading.value = heading.reference
                sphero.roll(heading: heading.value, speed: self._speed)
                Debugger.shared.log("Sphero is FORWARD with speed : \(self._speed) and heading : \(heading.value)")
            }
        }
    }
    
    func goBackward() {
        if let sphero = self._spheroTarget {
            if let heading = self._headingTarget {
                heading.value = heading.reference
                sphero.roll(heading: heading.value, speed: self._speed, rollType: .roll, direction: .reverse)
                Debugger.shared.log("Sphero is BACKWARD with speed : \(self._speed) and heading : \(heading.value)")
            }
        }
    }
    
    func goLeft() {
        if let sphero = self._spheroTarget {
            if let heading = self._headingTarget {
                heading.value = heading.reference - 90
                sphero.roll(heading: heading.value, speed: self._speed)
                Debugger.shared.log("Sphero is LEFT with speed : \(self._speed) and heading : \(heading.value)")
            }
        }
    }
    
    func goRight() {
        if let sphero = self._spheroTarget {
            if let heading = self._headingTarget {
                heading.value = heading.reference + 90
                sphero.roll(heading: heading.value, speed: self._speed)
                Debugger.shared.log("Sphero is RIGHT with speed : \(self._speed) and heading : \(heading.value)")
            }
        }
    }
    
    public func setSpheroTarget(spheroNumber: Int) -> Void {
        let index = spheroNumber - 1
        
        if spheroNumber <= SharedToyBox.instance.bolts.count {
            let sphero = SharedToyBox.instance.bolts[index]
            self._spheroTarget = sphero
            self._headingTarget = spheroNumber == 1 ? self._heading1 : self._heading2;
        }
    }
    
    // SETTERS
    public func setSpeed(_ speed: Double) -> Void {
        self._speed = speed
    }
    
    public func setHeading(_ value: Double) -> Void {
        if let heading = self._headingTarget {
            heading.value = value
        }
    }
    
    public func setReferenceHeading(_ value: Double) -> Void {
        if let heading = self._headingTarget {
            heading.reference = value
        }
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
    
    public func getHeading() -> Double? {
        return self._headingTarget?.value
    }
    
    public func getReferenceHeading() -> Double? {
        return self._headingTarget?.reference
    }
    
}

class Heading {
    public var value: Double = 0
    public var reference: Double = 0
    
    init() {
        
    }
}
