//
//  ThreeDimDirections.swift
//  SparkPerso
//
//  Created by Théo Champion on 06/10/2020.
//  Copyright © 2020 AlbanPerli. All rights reserved.
//

import Foundation

protocol ThreeDimDirections: TwoDimDirections {
    func goUp() -> Void
    func goDown() -> Void
}
