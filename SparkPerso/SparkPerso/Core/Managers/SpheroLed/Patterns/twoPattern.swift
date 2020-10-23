
//  TwoPattern.swift
//  SparkPerso
//
//  Created by  on 22/10/2020.
//  Copyright © 2020 AlbanPerli. All rights reserved.
//

import Foundation
import UIKit

class TwoPattern: PatternsManager {
    
    override func getPattern() -> [[UIColor]] {
        return [
            self.createOneColorLine(color: UIColor.blue),
            self.createColorsLine([
                Combinaison(nbPixels: 2, color: UIColor.blue),
                Combinaison(nbPixels: 4, color: UIColor.purple),
                Combinaison(nbPixels: 2, color: UIColor.blue)
            ]),
            self.createColorsLine([
                Combinaison(nbPixels: 5, color: UIColor.blue),
                Combinaison(nbPixels: 1, color: UIColor.purple),
                Combinaison(nbPixels: 2, color: UIColor.blue)
            ]),
            self.createColorsLine([
                Combinaison(nbPixels: 2, color: UIColor.blue),
                Combinaison(nbPixels: 4, color: UIColor.purple),
                Combinaison(nbPixels: 2, color: UIColor.blue)
            ]),
            self.createColorsLine([
                Combinaison(nbPixels: 2, color: UIColor.blue),
                Combinaison(nbPixels: 1, color: UIColor.purple),
                Combinaison(nbPixels: 5, color: UIColor.blue)
            ]),
            self.createColorsLine([
                Combinaison(nbPixels: 2, color: UIColor.blue),
                Combinaison(nbPixels: 4, color: UIColor.purple),
                Combinaison(nbPixels: 2, color: UIColor.blue)
            ]),
            self.createOneColorLine(color: UIColor.blue),
            self.createOneColorLine(color: UIColor.blue)
        ]
    }
    
}

