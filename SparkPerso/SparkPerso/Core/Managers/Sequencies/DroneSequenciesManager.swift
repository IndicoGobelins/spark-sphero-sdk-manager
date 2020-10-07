//
//  DroneSequenciesManager.swift
//  SparkPerso
//
//  Created by Théo Champion on 06/10/2020.
//  Copyright © 2020 AlbanPerli. All rights reserved.
//

import Foundation

class DroneSequenciesManager {
    // PROPERTIES
    public static var shared: DroneSequenciesManager = DroneSequenciesManager()
    private var _dronePilotManager: DronePilotManager
    private var _sequencies: [Sequence] = []
    private var _state: StateSequence! = nil
    private var _stopDelay: Double = 2.0
    
    
    // CONSTRUCTOR
    init() {
        self._dronePilotManager = DronePilotManager.shared
        self._state = StopStateSequence(self)
    }
    
    // PLAY HANDLER
    public func play() -> Void {
        if self._sequencies.count > 0 {
            /* Retrieve the current sequence of the array */
            let currentSequence = self._sequencies.first
            self.getDronePilotManager().setSpeed(currentSequence!.speed)
            
            /* Set the state of DroneSequenceManager according to the action of the current sequence */
            self.setStateFromAction(action: currentSequence?.action ?? DronePilotManager.Action.STOP)
                /* Execute the sequence according to the current state */
                .playCurrentSequence(duration: currentSequence!.duration) {
                    /* Execute this code below when the moove is finished */
                    if self._sequencies.count > 0 {
                        self._sequencies.removeFirst()
                    }
                    
                    self.play()
                }
        } else {
            Debugger.shared.log("The sequence is finished !")
        }
    }
    
    public func playCurrentSequence(duration: Double, _ onFinishCallback: @escaping () -> ()) -> Void {
        self._state.playCurrentSequence(duration: duration, onFinishCallback)
    }
    
    public func clearSequencies() -> Void {
        Debugger.shared.log("Clear sequencies")
        self._sequencies = []
        self._state = StopStateSequence(self)
        self._dronePilotManager.stop()
        self._dronePilotManager.setSpeed(0.3)
    }
    
    
    // GETTERS
    public func getDronePilotManager() -> DronePilotManager {
        return self._dronePilotManager
    }
    
    public func getSequencies() -> [Sequence] {
        return self._sequencies
    }
    
    
    // SETTTERS
    public func setState(_ state: StateSequence) -> DroneSequenciesManager {
        self._state = state
        Debugger.shared.log("New state for \(String(describing: self)) -> \(String(describing: self._state.self))")
        
        return self
    }
    
    public func setStateFromAction(action: DronePilotManager.Action) -> DroneSequenciesManager {
        switch action {
        case .BACKWARD:
            self._state = BackwardStateSequence(self)
        case .FORWARD:
            self._state = ForwardStateSequence(self)
        case .UP:
            self._state = UpStateSequence(self)
        case .DOWN:
            self._state = DownStateSequence(self)
        case .RIGHT:
            self._state = RightStateSequence(self)
        case .LEFT:
            self._state = LeftStateSequence(self)
        case .STOP:
            self._state = StopStateSequence(self)
        case .TAKEOFF:
            self._state = TakeOffStateSequence(self)
        case .LANDING:
            self._state = LandingStateSequence(self)
        default:
            self._state = StopStateSequence(self)
        }
        
        Debugger.shared.log("New state for \(String(describing: self)) -> \(String(describing: self._state.self))")
        
        return self
    }
    
    public func setSequencies(_ sequencies: [Sequence]) -> DroneSequenciesManager {
        self._sequencies = self._addStopStepsToSequencies(sequencies)
        
        return self
    }
    
    
    // HELPERS
    private func _addStopStepsToSequencies(_ sequencies: [Sequence]) -> [Sequence] {
        var returnedSequencies: [Sequence] = []
        
        for sequence in sequencies {
            returnedSequencies.append(sequence)
            returnedSequencies.append(
                Sequence(speed: 0.3, action: DronePilotManager.Action.STOP, duration: self._stopDelay)
            )
        }
        
        return returnedSequencies
    }
    
    
}

struct Sequence {
    var speed: Float
    var action: DronePilotManager.Action // Why not enum here ?
    var duration: Double // Or Float ? See DispatcherAsync parameters type
}
