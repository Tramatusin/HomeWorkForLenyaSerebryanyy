//
//  DrawViewController.swift
//  DrawWithLenya
//
//  Created by Виктория Козырева on 24.07.2021.
//

import UIKit

class DrawViewController: UIViewController{
    
    let canvas = DrawView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        canvas.backgroundColor = .blue
        view = canvas
    }
}
