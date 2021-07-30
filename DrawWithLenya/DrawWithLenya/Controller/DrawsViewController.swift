//
//  ToolsViewController.swift
//  DrawWithLenya
//
//  Created by Виктор Поволоцкий on 28.07.2021.
//

import UIKit

class DrawsViewController: UIViewController {
    
    let canvas = DrawViewForDrawsController()
    var line :[CGPoint] = []
    let tools = ToolsForDraw()
    var currentTool: ModeDraw = .line
    public var color: UIColor = UIColor.red
    
    override func viewDidLoad() {
        view = canvas
        view.backgroundColor = .white
        super.viewDidLoad()
        
        let backButton = UIBarButtonItem()
        backButton.title = "Gallery"
        self.navigationController?.navigationBar.topItem?.backBarButtonItem = backButton
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let point = touches.first?.location(in: nil) else { return}
        
        print(point)
        
        line.append(point)
        
        let newPath = tools.callWantedDrawFunc(tool: currentTool, line: line)
        
        guard let lastLayer = view.layer.sublayers?.last as? CAShapeLayer else {return}
        
        lastLayer.path = newPath.cgPath
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let pathForLayer = tools.callWantedDrawFunc(tool: currentTool, line: line)
        let shapelayer = CAShapeLayer()
        shapelayer.fillColor = UIColor.clear.cgColor
        shapelayer.strokeColor = color.cgColor
        shapelayer.lineWidth = 4
        shapelayer.path = pathForLayer.cgPath
        view.layer.addSublayer(shapelayer)
        line = [CGPoint]()
    }
}
