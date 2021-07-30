//
//  DrawViewController.swift
//  DrawWithLenya
//
//  Created by Виктория Козырева on 24.07.2021.
//

import UIKit

class ToolViewController: UIViewController{
    
    var buttonForPalette: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "paintpalette"), for: .normal)
        button.backgroundColor = .white
        button.translatesAutoresizingMaskIntoConstraints = false
        button.clipsToBounds = true
        button.layer.cornerRadius = 30
        button.backgroundColor = .systemRed
        button.addTarget(self, action: #selector(tapOnPaletteAction), for: .touchUpInside)
        return button
    }()
    
    lazy var collectionFromTools: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.dataSource = self
        collection.backgroundColor = .clear
        collection.delegate = self
        collection.translatesAutoresizingMaskIntoConstraints = false
        collection.register(ToolsViewCell.self, forCellWithReuseIdentifier: "tools")
        return collection
    }()
    
    lazy var tableViewForColors: UITableView = {
        let tableView = UITableView(frame: .zero)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(ColorViewCell.self, forCellReuseIdentifier: "color")
        return tableView
    }()
    
    let drawVC = DrawsViewController()
    var selectedIndexPath: IndexPath?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tapOnPaletteAction()
        self.addChild(drawVC)
        view.addSubview(drawVC.view)
        buttonForPalette.isHidden = false
        tableViewForColors.isHidden = true
        setupConstraints()
        let rightBarButtonItem = UIBarButtonItem.init(barButtonSystemItem: .cancel, target: self, action: #selector(tapOnBar))
        navigationItem.rightBarButtonItem = rightBarButtonItem
        //drawVC.didMove(toParent: self)
    }
    
    @objc
    func tapOnBar(){
        drawVC.view.layer.sublayers?.removeLast()
        drawVC.line = .init()
    }
    
    @objc
    func tapOnPaletteAction(){
        tableViewForColors.isHidden = false
        buttonForPalette.isHidden  = true
    }
    
    func setupConstraints(){
        view.addSubview(collectionFromTools)
        view.addSubview(tableViewForColors)
        view.addSubview(buttonForPalette)
        
        drawVC.view.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            buttonForPalette.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 8),
            buttonForPalette.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 34),
            buttonForPalette.widthAnchor.constraint(equalToConstant: 60),
            buttonForPalette.heightAnchor.constraint(equalTo: buttonForPalette.widthAnchor)
        ])
        
        NSLayoutConstraint.activate([
            drawVC.view.leftAnchor.constraint(equalTo: self.view.leftAnchor),
            drawVC.view.rightAnchor.constraint(equalTo: self.view.rightAnchor),
            drawVC.view.topAnchor.constraint(equalTo: self.view.topAnchor),
            drawVC.view.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)
        ])
        
        NSLayoutConstraint.activate([
            collectionFromTools.leftAnchor.constraint(equalTo: view.leftAnchor),
            collectionFromTools.rightAnchor.constraint(equalTo: view.rightAnchor),
            collectionFromTools.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -8),
            collectionFromTools.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.135)
        ])
        
        NSLayoutConstraint.activate([
            tableViewForColors.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 8),
            tableViewForColors.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant:34),
            tableViewForColors.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.6),
            tableViewForColors.widthAnchor.constraint(equalToConstant: 60)
        ])
    }
}
