//
//  NewFileViewCell.swift
//  DrawWithLenya
//
//  Created by Виктория Козырева on 28.07.2021.
//

import UIKit

class NewFileViewCell: UICollectionViewCell {
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        contentView.backgroundColor = .white
        setImage()
    }
    
    func setImage() {
        let image = UIImage(named: "NewFile")
        let imageView = UIImageView(image: image)
        
        contentView.addSubview(imageView)

        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
        imageView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
        imageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            imageView.heightAnchor.constraint(equalToConstant: 100),
            imageView.widthAnchor.constraint(equalToConstant: 100)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
