//
//  ToolsViewCellCollectionViewCell.swift
//  DrawWithLenya
//
//  Created by Виктор Поволоцкий on 28.07.2021.
//

import UIKit

class ToolsViewCell: UICollectionViewCell {
    
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
