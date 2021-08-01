//
//  ToolsViewCellCollectionViewCell.swift
//  DrawWithLenya
//
//  Created by Виктор Поволоцкий on 28.07.2021.
//

import UIKit

class ToolsViewCell: UICollectionViewCell {
    
    var imageViewForTools: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        contentView.layer.cornerRadius = frame.width/2.0
        contentView.layer.masksToBounds = true
        layer.cornerRadius = frame.width/2.0
        layer.masksToBounds = false
        self.layer.borderWidth = 1.5
        self.layer.borderColor = UIColor.black.cgColor
        backgroundColor = .lightGray
        setupConstraint()
    }
    
    func setImage(image: UIImage){
        imageViewForTools.image = image
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setupConstraint(){
        self.addSubview(imageViewForTools)
        NSLayoutConstraint.activate([
            imageViewForTools.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 6),
            imageViewForTools.rightAnchor.constraint(equalTo: contentView.rightAnchor,constant: -6),
            imageViewForTools.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            imageViewForTools.bottomAnchor.constraint(equalTo: contentView.bottomAnchor,constant: -8)
        ])
    }
    
}
