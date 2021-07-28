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
        contentView.backgroundColor = .blue
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
