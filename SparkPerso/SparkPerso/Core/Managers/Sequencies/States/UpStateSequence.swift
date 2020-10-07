//
//  UpStateSequence.swift
//  SparkPerso
//
//  Created by Théo Champion on 06/10/2020.
//  Copyright © 2020 AlbanPerli. All rights reserved.
//

import Foundation

class UpStateSequence: StateSequence {
    override func getAction() -> () -> () {
        return {
            self.droneSequenciesManager
                .getDronePilotManager()
                .goUp()
        }
    }
}
