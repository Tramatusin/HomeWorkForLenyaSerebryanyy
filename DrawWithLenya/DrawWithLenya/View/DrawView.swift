//
//  DrawView.swift
//  DrawWithLenya
//
//  Created by Виктория Козырева on 24.07.2021.
//

import UIKit

class DrawView: UIView {
    
    var tapOnBut: (()->Void)?
    
    var buttonForPalette: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "paintpalette"), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(tapOnColorButton), for: .touchUpInside)
        return button
    }()
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc
    func tapOnColorButton(){
        tapOnBut?()
    }
    
    func setupConstraint(){
        self.addSubview(buttonForPalette)

        NSLayoutConstraint.activate([
            buttonForPalette.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 8),
            buttonForPalette.topAnchor.constraint(equalTo: self.topAnchor, constant: 74),
            buttonForPalette.heightAnchor.constraint(equalToConstant: 60),
            buttonForPalette.widthAnchor.constraint(equalTo: buttonForPalette.heightAnchor)
        ])
    }
}

