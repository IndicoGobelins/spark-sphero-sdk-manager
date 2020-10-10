//
//  DogActivity.swift
//  SparkPerso
//
//  Created by  on 09/10/2020.
//  Copyright © 2020 AlbanPerli. All rights reserved.
//

import Foundation

class DogActivity: BaseActivity {
    
    private var _droneSequenciesManager: DroneSequenciesManager
    private let NB_MAX_BOWL: Int = 3
    private let ACTION_SEARCH: DronePilotManager.Action = DronePilotManager.Action.LEFT
    private let ACTION_BACK: DronePilotManager.Action = DronePilotManager.Action.RIGHT
    private let SEQUENCE_SPEED: Float = 0.2
    private let SEQUENCE_DURATION: Double = 2
    private var countMoves: Int = 0
    private var _state: DogActivityState! = nil
    public var isQrcodeDetectionActivated: Bool = false
    public static var shared: DogActivity = DogActivity()
    public static let QRCODE_MESSAGE_VALID = "indico"
    
    override init() {
        self._droneSequenciesManager = DroneSequenciesManager.shared
    }
    
    public func standUpAction() -> Void {
        Debugger.shared.log("dog activity : stand up")
        DroneCameraManager.shared.lookUnder()
        self._droneSequenciesManager.getDronePilotManager().takeOff()
    }
    
    public func searchAction() -> Void {
        Debugger.shared.log("dog activity : search")
        self.isQrcodeDetectionActivated = true
        
        self._droneSequenciesManager
            .setSequencies(self._getSequenceForSearchAction())
            .afterPlayingCurrentSequence {
                let currentSequence: Sequence? = self._droneSequenciesManager.getCurrentSequence()
                
                if let action = currentSequence?.action {
                    if action == self.ACTION_SEARCH {
                        self.countMoves += 1
                        Debugger.shared.log("Search value of countMoves : \(self.countMoves)")
                    }
                }
                
            }
            .play()
    }
    
    public func backAction() -> Void {
        Debugger.shared.log("dog activity : back")
        self.isQrcodeDetectionActivated = false
        self._droneSequenciesManager
            .setSequencies(self._getSequenceForBackAction())
            .afterPlayingCurrentSequence {
                let currentSequence: Sequence? = self._droneSequenciesManager.getCurrentSequence()
                
                if let action = currentSequence?.action {
                    if action == self.ACTION_BACK {
                        self.countMoves -= 1
                        Debugger.shared.log("Back value of countMoves : \(self.countMoves)")
                    }
                }
                
            }
            .play()
    }
    
    public func sitDownAction() -> Void {
        Debugger.shared.log("dog activity : sit down")
        self._droneSequenciesManager.getDronePilotManager().landing()
    }
    
    private func _getSequenceForSearchAction() -> [Sequence] {
        let nbSequenciesToAdd: Int = self.NB_MAX_BOWL - self.countMoves
        var sequencies: [Sequence] = []
        
        if nbSequenciesToAdd > 0 {
            for _ in 1...nbSequenciesToAdd {
                sequencies.append(Sequence(speed: self.SEQUENCE_SPEED, action: self.ACTION_SEARCH, duration: self.SEQUENCE_DURATION))
            }
        }

        return sequencies
    }
    
    private func _getSequenceForBackAction() -> [Sequence] {
        var sequencies: [Sequence] = []
        
        if self.countMoves > 0 {
            for _ in 1...self.countMoves {
                sequencies.append(Sequence(speed: self.SEQUENCE_SPEED, action: self.ACTION_BACK, duration: self.SEQUENCE_DURATION))
            }
        }
        
        return sequencies
    }
}
