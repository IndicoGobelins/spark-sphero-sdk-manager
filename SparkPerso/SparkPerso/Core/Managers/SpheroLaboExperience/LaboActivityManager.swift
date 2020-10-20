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
    private let _iterationmax = 1000
    private var isRunning = false
    
    // CONSTRUCTOR
    init() {
        
    }
    
    public func startActivity() {

        self.isRunning = true
        self.rotateSphero()

    }
    
    public func stopActivity() {
        self.isRunning = false
        self._iteration = 0
        SpheroLedManager.shared.clearLedScreen()
    }
    
    private func rotateSphero() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.9) {

            self._iteration += 1

            if(self._iteration < self._iterationmax && self.isRunning) {
                
                SpheroPilotManager.shared.connectFirstSphero()
                self.changeDirection(spheroInstance: SpheroPilotManager.shared)
                
                SpheroPilotManager.shared.connectSecondSphero()
                self.changeDirection(spheroInstance: SpheroPilotManager.shared)

                self.rotateSphero()

            } else {
                SpheroPilotManager.shared.stop()
                
                SpheroPilotManager.shared.connectFirstSphero()
                SpheroPilotManager.shared.stop()
                
                SpheroPilotManager.shared.connectSecondSphero()
                SpheroPilotManager.shared.stop()
                
                self._iteration = 0
                SpheroLedManager.shared.drawPatternInScreen(givenPattern: "adn")
                
                self.isRunning = false
                
            }

        }
    }
    
    private func changeDirection(spheroInstance:  SpheroPilotManager) -> Void {
        spheroInstance.setHeading(spheroInstance.getHeading() + 30.0)
        SharedToyBox.instance.bolts.map{ $0.roll(heading: spheroInstance.getHeading(), speed: spheroInstance.getSpeed()) }
    }
}
