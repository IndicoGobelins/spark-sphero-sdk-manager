
//  OnePattern.swift
//  SparkPerso
//
//  Created by  on 22/10/2020.
//  Copyright © 2020 AlbanPerli. All rights reserved.
//

import Foundation
import UIKit

class OnePattern: PatternsManager {
    
    override func getPattern() -> [[UIColor]] {
        return [
            self.createOneColorLine(color: UIColor.purple),
            self.createColorsLine([
                Combinaison(nbPixels: 3, color: UIColor.purple),
                Combinaison(nbPixels: 2, color: UIColor.blue),
                Combinaison(nbPixels: 3, color: UIColor.purple)
            ]),
            self.createColorsLine([
                Combinaison(nbPixels: 4, color: UIColor.purple),
                Combinaison(nbPixels: 1, color: UIColor.blue),
                Combinaison(nbPixels: 3, color: UIColor.purple)
            ]),
            self.createColorsLine([
                Combinaison(nbPixels: 4, color: UIColor.purple),
                Combinaison(nbPixels: 1, color: UIColor.blue),
                Combinaison(nbPixels: 3, color: UIColor.purple)
            ]),
            self.createColorsLine([
                Combinaison(nbPixels: 4, color: UIColor.purple),
                Combinaison(nbPixels: 1, color: UIColor.blue),
                Combinaison(nbPixels: 3, color: UIColor.purple)
            ]),
            self.createColorsLine([
                Combinaison(nbPixels: 4, color: UIColor.purple),
                Combinaison(nbPixels: 1, color: UIColor.blue),
                Combinaison(nbPixels: 3, color: UIColor.purple)
            ]),
            self.createColorsLine([
                Combinaison(nbPixels: 3, color: UIColor.purple),
                Combinaison(nbPixels: 3, color: UIColor.blue),
                Combinaison(nbPixels: 2, color: UIColor.purple)
            ]),
            self.createOneColorLine(color: UIColor.purple)
        ]
    }
    
}
