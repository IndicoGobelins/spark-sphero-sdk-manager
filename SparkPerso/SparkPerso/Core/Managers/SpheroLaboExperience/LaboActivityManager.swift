//
//  LaboActivityManager.swift
//  SparkPerso
//
//  Created by  on 19/10/2020.
//  Copyright © 2020 AlbanPerli. All rights reserved.
//
 
import Foundation
import UIKit

class LaboActivityManager {
    public static var shared: LaboActivityManager = LaboActivityManager()
    private var _iteration = 0
    private let _iterationmax = 66
    private var isRunning = false
    
    // CONSTRUCTOR
    init() {
        
    }
    
    public func startActivity() {
        self.isRunning = true
        SpheroPilotManager.shared.setSpeed(250)
        self.rotateSphero()
    }
    
    public func stopActivity() {
        self.isRunning = false
        self._iteration = 0
        SpheroLedManager.shared.clearLedScreen()
    }
    
    private func rotateSphero() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {

            self._iteration += 1

            if(self._iteration < self._iterationmax && self.isRunning) {
                
                SpheroPilotManager.shared.setSpheroTarget(spheroNumber: 1)
                self.changeDirection(spheroInstance: SpheroPilotManager.shared)
                
                SpheroPilotManager.shared.setSpheroTarget(spheroNumber: 2)
                self.changeDirection(spheroInstance: SpheroPilotManager.shared)

                self.rotateSphero()

            } else {
                SpheroPilotManager.shared.stop()
                
                SpheroPilotManager.shared.setSpheroTarget(spheroNumber: 1)
                SpheroPilotManager.shared.stop()
                
                SpheroPilotManager.shared.setSpheroTarget(spheroNumber: 2)
                SpheroPilotManager.shared.stop()
                
                self._iteration = 0
                self.displaySymbol()
                
                self.isRunning = false
                
            }

        }
    }
    
    public func displaySymbol() -> Void {
        SpheroLedManager.shared.setSpheroTarget(spheroNumber: 1)
        SpheroLedManager.shared.drawPatternInScreen(givenPattern: "adn")
        
        SpheroLedManager.shared.setSpheroTarget(spheroNumber: 2)

        SpheroLedManager.shared.drawPatternInScreen(givenPattern: "adn")
    }
    
    private func changeDirection(spheroInstance:  SpheroPilotManager) -> Void {
        if let heading = spheroInstance.getHeading() {
            let newHeading = heading + 40
            spheroInstance.setHeading(newHeading)
            SharedToyBox.instance.bolts.map{ $0.roll(heading: newHeading, speed: spheroInstance.getSpeed()) }
        }
    }
}
