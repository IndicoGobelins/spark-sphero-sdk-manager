//
//  AdnPattern.swift
//  SparkPerso
//
//  Created by  on 19/10/2020.
//  Copyright © 2020 AlbanPerli. All rights reserved.
//

import Foundation
import UIKit

class AdnPattern: PatternsManager {
    
    override func getPattern() -> [[UIColor]] {
        return [
            self.createColorsLine([
                Combinaison(nbPixels: 1, color: UIColor.black),
                Combinaison(nbPixels: 1, color: UIColor.blue),
                Combinaison(nbPixels: 3, color: UIColor.white),
                Combinaison(nbPixels: 1, color: UIColor.purple),
                Combinaison(nbPixels: 2, color: UIColor.black)
            ]),
            self.createColorsLine([
                Combinaison(nbPixels: 1, color: UIColor.black),
                Combinaison(nbPixels: 1, color: UIColor.blue),
                Combinaison(nbPixels: 3, color: UIColor.black),
                Combinaison(nbPixels: 1, color: UIColor.purple),
                Combinaison(nbPixels: 2, color: UIColor.black)
            ]),
            self.createColorsLine([
                Combinaison(nbPixels: 2, color: UIColor.black),
                Combinaison(nbPixels: 1, color: UIColor.blue),
                Combinaison(nbPixels: 1, color: UIColor.white),
                Combinaison(nbPixels: 1, color: UIColor.purple),
                Combinaison(nbPixels: 3, color: UIColor.black)
            ]),
            self.createColorsLine([
                Combinaison(nbPixels: 3, color: UIColor.black),
                Combinaison(nbPixels: 1, color: UIColor.blue),
                Combinaison(nbPixels: 4, color: UIColor.black)
            ]),
            self.createColorsLine([
                Combinaison(nbPixels: 2, color: UIColor.black),
                Combinaison(nbPixels: 1, color: UIColor.purple),
                Combinaison(nbPixels: 1, color: UIColor.white),
                Combinaison(nbPixels: 1, color: UIColor.blue),
                Combinaison(nbPixels: 3, color: UIColor.black)
            ]),
            self.createColorsLine([
                Combinaison(nbPixels: 1, color: UIColor.black),
                Combinaison(nbPixels: 1, color: UIColor.purple),
                Combinaison(nbPixels: 3, color: UIColor.black),
                Combinaison(nbPixels: 1, color: UIColor.blue),
                Combinaison(nbPixels: 2, color: UIColor.black)
            ]),
            self.createColorsLine([
                Combinaison(nbPixels: 1, color: UIColor.black),
                Combinaison(nbPixels: 1, color: UIColor.purple),
                Combinaison(nbPixels: 3, color: UIColor.white),
                Combinaison(nbPixels: 1, color: UIColor.blue),
                Combinaison(nbPixels: 2, color: UIColor.black)
            ]),
            self.createColorsLine([
                Combinaison(nbPixels: 1, color: UIColor.black),
                Combinaison(nbPixels: 1, color: UIColor.purple),
                Combinaison(nbPixels: 3, color: UIColor.black),
                Combinaison(nbPixels: 1, color: UIColor.blue),
                Combinaison(nbPixels: 2, color: UIColor.black)
            ])
        ]
    }
    
}
