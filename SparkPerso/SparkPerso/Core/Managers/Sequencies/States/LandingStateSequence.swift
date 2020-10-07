//
//  LandingStateSequence.swift
//  SparkPerso
//
//  Created by  on 07/10/2020.
//  Copyright © 2020 AlbanPerli. All rights reserved.
//

import Foundation

class LandingStateSequence: StateSequence {
    override func getAction() -> () -> () {
        return {
            self.droneSequenciesManager
                .getDronePilotManager()
                .landing()
        }
    }
}
