//
//  SpheroLedManager.swift
//  SparkPerso
//
//  Created by  on 11/10/2020.
//  Copyright © 2020 AlbanPerli. All rights reserved.
//

import Foundation
import UIKit

class SpheroLedManager {
    private var pattern: String? = nil
    public static var shared: SpheroLedManager = SpheroLedManager()
    
    // CONSTRUCTOR
    init() {
        
    }
    
    // Draw pattern in sphero led screen from a pattern if this pattern is not null
    public func drawPatternInScreen(pattern: String) -> Void {
        self.setPattern(pattern)
        if self.pattern != nil {
            for i in 0...8-1 {
                for j in 0...8-1 {
                    SharedToyBox.instance.bolts.map{ $0.drawMatrix(pixel: Pixel(x: i, y: j), color: self.getPatternMatrix()[i][j]) }
                }
            }
        }

    }
    
    // Clean sphero led screen
    public func clearLedScreen() {
        SharedToyBox.instance.bolts.map{ $0.clearMatrix() }
    }
    
    
    // Get the pattern's matrix
    private func getPatternMatrix() -> [[UIColor]] {
        var matrix = [[UIColor]]()
        if pattern != nil {
            // code here
            switch pattern {
            case "heart":
                matrix = self.getHeartMatrix()
            default:
                matrix = [[]]
            }
        }
        return matrix
    }
    
    // Build one line mtrix with just one color
    private func createOnColorLine(color: UIColor) -> [UIColor] {
        var line = [UIColor]()
        for _ in 0...8-1 {
            line.append(color)
        }
        return line
    }
    
    // Build one line matrix with some colors
    private func createColorsLine(_ schema: [Combinaison]) -> [UIColor] {
        var line = [UIColor]()
        
        for item in schema {
            for _ in 0...item.nbPixels-1 {
                line.append(item.color)
            }
        }

        return line
    }
    
    // SETTERS
    private func setPattern(_ pattern: String) {
        self.pattern = pattern
    }
    
    // Patterns
    private func getHeartMatrix() -> [[UIColor]] {
        var matrice = [
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
            self.createOnColorLine(color: UIColor.red),
            self.createOnColorLine(color: UIColor.red),
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
            self.createOnColorLine(color: UIColor.white)
        ]
        
        return matrice
    }
    
}


struct Combinaison {
    var nbPixels: Int
    var color: UIColor
}
