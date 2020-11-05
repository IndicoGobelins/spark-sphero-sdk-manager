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
        print("Init led manager")
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
    
    public func setSpheroTarget(spheroNumber: Int) -> Void {
        let index = spheroNumber - 1
        
        if spheroNumber <= SharedToyBox.instance.bolts.count {
            let sphero = SharedToyBox.instance.bolts[index]
            Debugger.shared.log("connect sphero n° \(spheroNumber)")
            self._spheroTarget = sphero
        }
    }
    
    public func startAiming() -> Void {
        if let sphero = self._spheroTarget {
            sphero.startAiming()
        }
    }
    
    public func stopAiming() -> Void {
        if let sphero = self._spheroTarget {
            sphero.stopAiming()
        }
    }
    
    public func setSpheroTargetFromDevice(sphero: Router.Device) -> SpheroLedManager {
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
            case "stop":
                self._pattern = StopPattern(self)
                break
            case "blood":
                self._pattern = BloodPattern(self)
                break
            case "erlenmayer":
                self._pattern = ErlenmayerPattern(self)
                break
            case "doggy":
                self._pattern = DoggyPattern(self)
                break
            case "question":
                self._pattern = QuestionPattern(self)
                break
            case "adn":
                self._pattern = AdnPattern(self)
                break
            case "one":
                self._pattern = OnePattern(self)
                break
            case "two":
                self._pattern = TwoPattern(self)
                break
            default:
                self._pattern = nil
        }
    }

    
}
