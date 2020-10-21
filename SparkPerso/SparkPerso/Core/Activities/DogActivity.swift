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
    private let ACTION_SEARCH: DronePilotManager.Action = DronePilotManager.Action.FORWARD
    private let ACTION_BACK: DronePilotManager.Action = DronePilotManager.Action.RIGHT
    private let SEQUENCE_SPEED: Float = 0.2
    private let SEQUENCE_DURATION: Double = 2
    private var countMoves: Int = 0
    public var isQrcodeDetectionActivated: Bool = true
    public static var shared: DogActivity = DogActivity()
    public static let QRCODE_MESSAGE_VALID = "indico"
    public static let NUMBER_SUSPECT = "3"
    
    override init() {
        self._droneSequenciesManager = DroneSequenciesManager.shared
    }
    
    public func standUpAction(device: Router.Device) -> Void {
        Debugger.shared.log("dog activity : stand up")
        self.isQrcodeDetectionActivated = true
        DroneCameraManager.shared.lookUnder()
        self._droneSequenciesManager.getDronePilotManager().takeOff()
    }
    
    public func searchAction(device: Router.Device) -> Void {
        Debugger.shared.log("dog activity : search")
        self.isQrcodeDetectionActivated = true
        DronePilotManager.shared.goForward();
    }
    
    public func sitDownAction(device: Router.Device) -> Void {
        Debugger.shared.log("dog activity : sit down")
        self._droneSequenciesManager.getDronePilotManager().landing()
    }
}
