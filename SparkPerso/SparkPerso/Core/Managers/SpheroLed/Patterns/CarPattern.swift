//
//  CarPattern.swift
//  SparkPerso
//
//  Created by  on 17/10/2020.
//  Copyright © 2020 AlbanPerli. All rights reserved.
//

import Foundation
import UIKit

class CarPattern: PatternsManager {
    
    override func getPattern() -> [[UIColor]] {
        return [
            self.createOneColorLine(color: UIColor.blue),
            self.createOneColorLine(color: UIColor.blue),
            self.createColorsLine([
                Combinaison(nbPixels: 3, color: UIColor.blue),
                Combinaison(nbPixels: 2, color: UIColor.red),
                Combinaison(nbPixels: 3, color: UIColor.blue)
            ]),
            self.createColorsLine([
                Combinaison(nbPixels: 1, color: UIColor.green),
                Combinaison(nbPixels: 1, color: UIColor.yellow),
                Combinaison(nbPixels: 4, color: UIColor.red),
                Combinaison(nbPixels: 1, color: UIColor.yellow),
                Combinaison(nbPixels: 1, color: UIColor.green)
            ]),
            self.createColorsLine([
                Combinaison(nbPixels: 1, color: UIColor.green),
                Combinaison(nbPixels: 1, color: UIColor.red),
                Combinaison(nbPixels: 1, color: UIColor.black),
                Combinaison(nbPixels: 2, color: UIColor.red),
                Combinaison(nbPixels: 1, color: UIColor.black),
                Combinaison(nbPixels: 1, color: UIColor.red),
                Combinaison(nbPixels: 1, color: UIColor.green)
            ]),
            self.createColorsLine([
                Combinaison(nbPixels: 2, color: UIColor.gray),
                Combinaison(nbPixels: 1, color: UIColor.black),
                Combinaison(nbPixels: 2, color: UIColor.gray),
                Combinaison(nbPixels: 1, color: UIColor.black),
                Combinaison(nbPixels: 2, color: UIColor.gray)
            ]),
            self.createColorsLine([
                Combinaison(nbPixels: 1, color: UIColor.gray),
                Combinaison(nbPixels: 3, color: UIColor.white),
                Combinaison(nbPixels: 2, color: UIColor.gray),
                Combinaison(nbPixels: 2, color: UIColor.white)
            ]),
            self.createOneColorLine(color: UIColor.gray),
        ]
    }
}
