//
//  StopPattern.swift
//  SparkPerso
//
//  Created by  on 17/10/2020.
//  Copyright © 2020 AlbanPerli. All rights reserved.
//

import Foundation
import UIKit

class StopPattern: PatternsManager {
    
    override func getPattern() -> [[UIColor]] {
        return [
            self.createOneColorLine(color: UIColor.white),
            self.createOneColorLine(color: UIColor.white),
            self.createColorsLine([
                Combinaison(nbPixels: 2, color: UIColor.white),
                Combinaison(nbPixels: 4, color: UIColor.black),
                Combinaison(nbPixels: 2, color: UIColor.white)
            ]),
            self.createColorsLine([
                Combinaison(nbPixels: 2, color: UIColor.white),
                Combinaison(nbPixels: 4, color: UIColor.black),
                Combinaison(nbPixels: 2, color: UIColor.white)
            ]),
            self.createColorsLine([
                Combinaison(nbPixels: 2, color: UIColor.white),
                Combinaison(nbPixels: 4, color: UIColor.black),
                Combinaison(nbPixels: 2, color: UIColor.white)
            ]),
            self.createColorsLine([
                Combinaison(nbPixels: 2, color: UIColor.white),
                Combinaison(nbPixels: 4, color: UIColor.black),
                Combinaison(nbPixels: 2, color: UIColor.white)
            ]),
            self.createOneColorLine(color: UIColor.white),
            self.createOneColorLine(color: UIColor.white)
        ]
    }
}
