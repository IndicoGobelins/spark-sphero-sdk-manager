//
//  patternsManager.swift
//  SparkPerso
//
//  Created by  on 11/10/2020.
//  Copyright © 2020 AlbanPerli. All rights reserved.
//

import Foundation
import UIKit

class PatternsManager {
    
    public let spheroLedManager: SpheroLedManager
    
    init(_ spheroLedManager: SpheroLedManager) {
        self.spheroLedManager = spheroLedManager
    }

    func getPattern() -> [[UIColor]] {
       // print("getPattern from PatternsManager class. Please override me !")
        return [[]]
    }
    
    // La couleur noire est en fait une "sans couleur" pour l'écran du sphero
    
    // Build one line mtrix with just one color
    func createOneColorLine(color: UIColor) -> [UIColor] {
        var line = [UIColor]()
        for _ in 0...8-1 {
            line.append(color)
        }
        return line
    }
    
    // Build one line matrix with some colors
    func createColorsLine(_ schema: [Combinaison]) -> [UIColor] {
        var line = [UIColor]()
        
        for item in schema {
            for _ in 0...item.nbPixels-1 {
                line.append(item.color)
            }
        }

        return line
    }
}

struct Combinaison {
    var nbPixels: Int
    var color: UIColor
}
