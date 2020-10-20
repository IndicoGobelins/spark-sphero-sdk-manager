//
//  LaboActivity.swift
//  SparkPerso
//
//  Created by  on 19/10/2020.
//  Copyright © 2020 AlbanPerli. All rights reserved.
//

import Foundation

class LaboActivity: BaseActivity {
    public static var shared: LaboActivity = LaboActivity()
    
    public func startActivity(device: Router.Device) -> Void {
        SpheroPilotManager.shared
        .setSpheroTargetFromDevice(sphero: device)
        .goForward()
    }
}
