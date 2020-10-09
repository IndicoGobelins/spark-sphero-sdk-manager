//
//  CommunicationHelper.swift
//  SparkPerso
//
//  Created by  on 09/10/2020.
//  Copyright © 2020 AlbanPerli. All rights reserved.
//

import Foundation

class CommunicationHelper {
    
    static let separator: String = "@#"
    static let header: String = "$"
    
    // convert data string to struct
    public func formatDataToStruct(_ data: String) -> CommunicationData {
        print(data)
        let dataArray = data.components(separatedBy: CommunicationHelper.separator)
        print(data)
        return CommunicationData(
            device: dataArray[1],
            action: dataArray[2],
            activity: dataArray[3]
        )
    }
}

// data received from the web user interfaces
struct CommunicationData {
    let device, action, activity: String
}
