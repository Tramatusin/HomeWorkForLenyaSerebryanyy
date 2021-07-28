//
//  ViewController.swift
//  DrawWithLenya
//
//  Created by Виктория Козырева on 24.07.2021.
//

import UIKit

class ViewController: UIViewController {
    
    var rightBarButtonItem = UIBarButtonItem()
    
    let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 2
        layout.minimumInteritemSpacing = 2
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.register(PictureViewCell.self, forCellWithReuseIdentifier: "Picture")
        cv.register(NewFileViewCell.self, forCellWithReuseIdentifier: "New")
    
        return cv
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        rightBarButtonItem = UIBarButtonItem.init(barButtonSystemItem: .add, target: self, action: #selector(addAction))
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

