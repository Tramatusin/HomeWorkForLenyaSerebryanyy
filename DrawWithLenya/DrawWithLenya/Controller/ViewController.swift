//
//  ViewController.swift
//  DrawWithLenya
//
//  Created by Виктория Козырева on 24.07.2021.
//

import UIKit

class ViewController: UIViewController {
    
    let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        //add insets
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.register(PictureViewCell.self, forCellWithReuseIdentifier: "Picture")
    
        return cv
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .cyan
        let rightBarButtonItem = UIBarButtonItem.init(barButtonSystemItem: .add, target: self, action: #selector(addAction))
        navigationItem.rightBarButtonItem = rightBarButtonItem
        confCollestionView()
    }
    
    @objc func addAction() {
        navigationController?.pushViewController(ToolViewController(), animated: true)
    }
    
    func confCollestionView() {
        collectionView.dataSource = self
        collectionView.delegate = self
        
        view.addSubview(collectionView)
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
        
    }
}

