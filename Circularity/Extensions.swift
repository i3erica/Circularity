//
//  Extensions.swift
//  Circularity
//
//  Created by Brian  on 4/29/18.
//  Copyright © 2018 Brian Abbondanza. All rights reserved.
//

import Foundation
import SpriteKit

extension CGFloat {
    static func random(min: CGFloat, max: CGFloat) -> CGFloat {
        return CGFloat(Float(arc4random()) / 0xFFFFFFFF) * (max - min) + min
        
    }
}
