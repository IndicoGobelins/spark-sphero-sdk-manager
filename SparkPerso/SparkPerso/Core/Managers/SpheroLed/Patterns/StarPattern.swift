//
//  starPattern.swift
//  SparkPerso
//
//  Created by  on 11/10/2020.
//  Copyright © 2020 AlbanPerli. All rights reserved.
//

import Foundation
import UIKit

class StarPattern: PatternsManager {
    
    override func getPattern() -> [[UIColor]] {
        return [
            self.createColorsLine([
                Combinaison(nbPixels: 1, color: UIColor.yellow),
                Combinaison(nbPixels: 2, color: UIColor.white),
                Combinaison(nbPixels: 1, color: UIColor.yellow),
                Combinaison(nbPixels: 2, color: UIColor.white),
                Combinaison(nbPixels: 1, color: UIColor.yellow),
                Combinaison(nbPixels: 1, color: UIColor.white)
            ]),
            self.createColorsLine([
                Combinaison(nbPixels: 1, color: UIColor.white),
                Combinaison(nbPixels: 1, color: UIColor.yellow),
                Combinaison(nbPixels: 1, color: UIColor.white),
                Combinaison(nbPixels: 1, color: UIColor.yellow),
                Combinaison(nbPixels: 1, color: UIColor.white),
                Combinaison(nbPixels: 1, color: UIColor.yellow),
                Combinaison(nbPixels: 2, color: UIColor.white)
            ]),
            self.createColorsLine([
                Combinaison(nbPixels: 2, color: UIColor.white),
                Combinaison(nbPixels: 3, color: UIColor.yellow),
                Combinaison(nbPixels: 3, color: UIColor.white)
            ]),
            self.createColorsLine([
                Combinaison(nbPixels: 7, color: UIColor.yellow),
                Combinaison(nbPixels: 1, color: UIColor.white)
            ]),
            self.createColorsLine([
                Combinaison(nbPixels: 2, color: UIColor.white),
                Combinaison(nbPixels: 3, color: UIColor.yellow),
                Combinaison(nbPixels: 3, color: UIColor.white)
            ]),
            self.createColorsLine([
                Combinaison(nbPixels: 1, color: UIColor.white),
                Combinaison(nbPixels: 1, color: UIColor.yellow),
                Combinaison(nbPixels: 1, color: UIColor.white),
                Combinaison(nbPixels: 1, color: UIColor.yellow),
                Combinaison(nbPixels: 1, color: UIColor.white),
                Combinaison(nbPixels: 1, color: UIColor.yellow),
                Combinaison(nbPixels: 2, color: UIColor.white)
            ]),
            self.createColorsLine([
                Combinaison(nbPixels: 1, color: UIColor.yellow),
                Combinaison(nbPixels: 2, color: UIColor.white),
                Combinaison(nbPixels: 1, color: UIColor.yellow),
                Combinaison(nbPixels: 2, color: UIColor.white),
                Combinaison(nbPixels: 1, color: UIColor.yellow),
                Combinaison(nbPixels: 1, color: UIColor.white)
            ]),
            self.createOneColorLine(color: UIColor.white)
        ]
    }
}
