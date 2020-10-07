//
//  Debugger.swift
//  SparkPerso
//
//  Created by Théo Champion on 06/10/2020.
//  Copyright © 2020 AlbanPerli. All rights reserved.
//

import Foundation

class Debugger {
    public static let shared = Debugger()
    private var _isMuted: Bool = false
    
    public func log(_ message: String) -> Void {
        if (!message.hasPrefix("###") && !self._isMuted) {
            print(message)
        }
    }
    
    public func mute() -> Void {
        self._isMuted = true
    }
}
