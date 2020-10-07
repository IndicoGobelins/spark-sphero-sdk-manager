//
//  StateSequence.swift
//  SparkPerso
//
//  Created by Théo Champion on 06/10/2020.
//  Copyright © 2020 AlbanPerli. All rights reserved.
//

import Foundation

class StateSequence {
    public let droneSequenciesManager: DroneSequenciesManager
    
    init(_ droneSequenciesManager: DroneSequenciesManager) {
        self.droneSequenciesManager = droneSequenciesManager
    }
    
    func playCurrentSequence(duration: Double, _ onFinishCallback: @escaping () -> ()) -> Void {
        let action = self.getAction();
        action();
        self._delay(duration, onFinishCallback)
    }
    
    func getAction() -> () -> () {
        return {
            print("getAction from StateSequence class. Please override me !")
        }
    }
    
    func _delay(_ duration: Double, _ closure: @escaping () -> ()) -> Void {
        DispatchQueue.main.asyncAfter(deadline: .now() +  duration, execute: closure)
    }
}
