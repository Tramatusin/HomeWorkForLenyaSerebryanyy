//
//  PictureViewCell.swift
//  DrawWithLenya
//
//  Created by Виктория Козырева on 24.07.2021.
//

import UIKit

class PictureViewCell: UICollectionViewCell {
    
//    
//    var imgView: UIImageView = {
//        let imageView = UIImageView(frame: .zero)
//        imageView.backgroundColor = .red
//        imageView.translatesAutoresizingMaskIntoConstraints = false
//        return imageView
//    }()
//    
    var label: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        return label
    }()
    
    func configCell(name: String) {
        label.text = name
    }
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        contentView.backgroundColor = .red
        contentView.addSubview(label)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            label.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
            label.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            label.heightAnchor.constraint(equalToConstant: 20),
            label.widthAnchor.constraint(equalToConstant: 100)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        
    }
}
