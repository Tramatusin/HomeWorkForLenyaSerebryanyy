//
//  PictureViewCell.swift
//  DrawWithLenya
//
//  Created by Виктория Козырева on 24.07.2021.
//

import UIKit

class PictureViewCell: UICollectionViewCell {
    
    
    var imgView: UIImageView = {
        let imageView = UIImageView(frame: .zero)
        imageView.backgroundColor = .red
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    var label: UILabel = {
        let label = UILabel()
        label.text = "Hello world!"
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        contentView.backgroundColor = .red
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        
    }
}
