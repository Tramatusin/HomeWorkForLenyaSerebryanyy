//
//  DrawViewController.swift
//  DrawWithLenya
//
//  Created by Виктория Козырева on 24.07.2021.
//

import UIKit

class DrawViewController: UIViewController{
    
    let canvas = DrawView()
    var line :[CGPoint] = []
    let tools = ToolsForDraw()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        canvas.backgroundColor = .blue
        view = canvas
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let point = touches.first?.location(in: nil) else { return}
        
        print(point)
        
        line.append(point)
        
        let newPath = tools.callWantedDrawFunc(tool: .line, line: line)
        
        guard let lastLayer = view.layer.sublayers?.last as? CAShapeLayer else {return}
        
        lastLayer.path = newPath.cgPath
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let pathForLayer = tools.callWantedDrawFunc(tool: .line, line: line)
        let shapelayer = CAShapeLayer()
        shapelayer.fillColor = UIColor.clear.cgColor
        shapelayer.strokeColor = UIColor.red.cgColor
        shapelayer.lineWidth = 3
        shapelayer.path = pathForLayer.cgPath
        view.layer.addSublayer(shapelayer)
        line = [CGPoint]()
    }
    
}
