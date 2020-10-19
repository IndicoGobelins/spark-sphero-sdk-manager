//
//  heartPattern.swift
//  SparkPerso
//
//  Created by  on 11/10/2020.
//  Copyright © 2020 AlbanPerli. All rights reserved.
//

import Foundation
import UIKit

class HeartPattern: PatternsManager {
    
    override func getPattern() -> [[UIColor]] {
        return [
            self.createColorsLine([
                Combinaison(nbPixels: 2, color: UIColor.white),
                Combinaison(nbPixels: 1, color: UIColor.red),
                Combinaison(nbPixels: 2, color: UIColor.white),
                Combinaison(nbPixels: 1, color: UIColor.red),
                Combinaison(nbPixels: 2, color: UIColor.white)
            ]),
            self.createColorsLine([
                Combinaison(nbPixels: 1, color: UIColor.white),
                Combinaison(nbPixels: 2, color: UIColor.red),
                Combinaison(nbPixels: 2, color: UIColor.white),
                Combinaison(nbPixels: 2, color: UIColor.red),
                Combinaison(nbPixels: 1, color: UIColor.white)
            ]),
            self.createOneColorLine(color: UIColor.red),
            self.createOneColorLine(color: UIColor.red),
            self.createColorsLine([
                Combinaison(nbPixels: 1, color: UIColor.white),
                Combinaison(nbPixels: 6, color: UIColor.red),
                Combinaison(nbPixels: 1, color: UIColor.white)
            ]),
            self.createColorsLine([
                Combinaison(nbPixels: 2, color: UIColor.white),
                Combinaison(nbPixels: 4, color: UIColor.red),
                Combinaison(nbPixels: 2, color: UIColor.white)
            ]),
            self.createColorsLine([
                Combinaison(nbPixels: 3, color: UIColor.white),
                Combinaison(nbPixels: 2, color: UIColor.red),
                Combinaison(nbPixels: 3, color: UIColor.white)
            ]),
            self.createOneColorLine(color: UIColor.white)
        ]
    }
    
}
