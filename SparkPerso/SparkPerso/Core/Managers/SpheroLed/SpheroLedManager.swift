//
//  SpheroLedManager.swift
//  SparkPerso
//
//  Created by  on 11/10/2020.
//  Copyright © 2020 AlbanPerli. All rights reserved.
//

import Foundation
import UIKit

class SpheroLedManager {
    private var _pattern: PatternsManager! = nil
    public static var shared: SpheroLedManager = SpheroLedManager()
    private var _spheroTarget: BoltToy? = nil
    
    // CONSTRUCTOR
    init() {
        self.connectFirstSphero()
    }
    
    // Draw pattern in sphero led screen from a pattern if this pattern is not null
    public func drawPatternInScreen(givenPattern: String) -> Void {
        self.setPattern(pattern: givenPattern)
        if self._pattern != nil {
            for i in 0...8-1 {
                for j in 0...8-1 {
                    self._spheroTarget?.drawMatrix(pixel: Pixel(x: i, y: j), color: self._pattern.getPattern()[i][j])
                }
            }
        }
    }
    
    public func connectFirstSphero() -> Void {
        if let sphero = SharedToyBox.instance.bolts[0] as BoltToy? {
            Debugger.shared.log("first sphero")
            self._spheroTarget = sphero
        }
    }
    
    public func connectSecondSphero() -> Void {
        if let sphero = SharedToyBox.instance.bolts[1] as BoltToy? {
            Debugger.shared.log("second sphero")
            self._spheroTarget = sphero
        }
    }
    
    public func setSpheroTargetFromDevice(sphero: Router.Device) -> SpheroLedManager {
        switch sphero {
            case .SPHERO1:
                self.connectFirstSphero()
            case .SPHERO2:
                self.connectSecondSphero()
            default:
                self.connectFirstSphero()
        }
        
        return self
    }
    
    // Clean sphero led screen
    public func clearLedScreen() {
        self._pattern = nil
        SharedToyBox.instance.bolts.map{ $0.clearMatrix() }
    }
    
    public func getRandomChoicesPatterns() -> [String] {
        return ["erlenmayer","doggy","question"]
    }
    
    
    // set the pattern's matrix
    private func setPattern(pattern: String) -> Void {
        switch pattern {
            case "heart":
                self._pattern = HeartPattern(self)
            case "star":
                self._pattern = StarPattern(self)
            case "car":
                self._pattern = CarPattern(self)
            case "stop":
                self._pattern = StopPattern(self)
            case "blood":
                self._pattern = BloodPattern(self)
            case "erlenmayer":
                self._pattern = ErlenmayerPattern(self)
            case "dog":
                self._pattern = DogPattern(self)
            case "doggy":
                self._pattern = DoggyPattern(self)
            case "question":
                self._pattern = QuestionPattern(self)
            case "adn":
                self._pattern = AdnPattern(self)
            default:
                self._pattern = nil
        }
    }

    
}
