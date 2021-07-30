//
//  Colors.swift
//  DrawWithLenya
//
//  Created by Виктор Поволоцкий on 28.07.2021.
//

import Foundation
import UIKit

class DataStash{
    static var colorsForLines: [UIColor] = [
        UIColor.systemRed, UIColor.systemBlue, UIColor.systemPink, UIColor.systemTeal,
        UIColor.systemGray, UIColor.systemGray3, UIColor.systemGray4, UIColor.systemGray5,
        UIColor.systemGray6, UIColor.systemGreen,UIColor.systemOrange, UIColor.systemYellow,
        UIColor.systemPurple, UIColor.systemIndigo, UIColor.systemFill, UIColor.systemBackground
    ]
    
    static var namesOfImage: [Figure] = [
        Figure(namedForImage: "Circle.png", type: .circle),
        Figure(namedForImage: "Rect.png", type: .rect),
        Figure(namedForImage: "Straight.png", type: .straight),
        Figure(namedForImage: "Triangle.png", type: .triangle),
        Figure(namedForImage: "Line.png", type: .line),
        Figure(namedForImage: "RectWithCornRadius.png", type: .rectWithCornRadius)
    ]
}
