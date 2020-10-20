//
//  heartPattern.swift
//  SparkPerso
//
//  Created by  on 11/10/2020.
//  Copyright © 2020 AlbanPerli. All rights reserved.
//

import Foundation
import UIKit

class BloodPattern: PatternsManager {
    
    override func getPattern() -> [[UIColor]] {
        return [
            self.createOneColorLine(color: UIColor.red),
            self.createOneColorLine(color: UIColor.red),
            self.createOneColorLine(color: UIColor.red),
            self.createOneColorLine(color: UIColor.red),
            self.createOneColorLine(color: UIColor.red),
            self.createOneColorLine(color: UIColor.red),
            self.createOneColorLine(color: UIColor.red),
            self.createOneColorLine(color: UIColor.red)
        ]
    }
    
}
