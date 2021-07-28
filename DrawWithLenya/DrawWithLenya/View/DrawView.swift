//
//  DrawView.swift
//  DrawWithLenya
//
//  Created by Виктория Козырева on 24.07.2021.
//

import UIKit

enum ModeDraw{
    case circle
    case rect
    case line
    case straight
    case triangle
    case rectWithCornRadius
}

class DrawView: UIView {
    override func draw(_ rect: CGRect) {
        super.draw(rect)
    }
}

