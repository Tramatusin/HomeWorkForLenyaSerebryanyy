//
//  DrawViewController.swift
//  DrawWithLenya
//
//  Created by Виктория Козырева on 24.07.2021.
//

import UIKit

class ToolViewController: UIViewController{
    
    lazy var collectionFromTools: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.dataSource = self
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.addChild(drawVC)
        view.addSubview(drawVC.view)
        setupConstraints()
        tableViewForColors.isHidden = false
        drawVC.canvas.tapOnBut = { [weak self] in
            self?.tableViewForColors.isHidden = false
        }
        //drawVC.didMove(toParent: self)
    }
    
    
    func setupConstraints(){
        view.addSubview(collectionFromTools)
        view.addSubview(tableViewForColors)
        
        drawVC.view.translatesAutoresizingMaskIntoConstraints = false

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
            collectionFromTools.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.15)
        ])
        
        NSLayoutConstraint.activate([
            tableViewForColors.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 8),
            tableViewForColors.topAnchor.constraint(equalTo: view.topAnchor, constant:74),
            tableViewForColors.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.6),
            tableViewForColors.widthAnchor.constraint(equalToConstant: 60)
        ])
    }
}

extension ToolViewController:  UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        //значение постоянно, потому что у нас ровно 6 инструментов
        return 6
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let toolCell = collectionView.dequeueReusableCell(withReuseIdentifier: "tools", for: indexPath) as! ToolsViewCell
        return toolCell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 70, height: 70)
    }
    
}

extension ToolViewController: UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        Colors.colorsForLines.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellForColor =  tableView.dequeueReusableCell(withIdentifier: "color", for: indexPath) as! ColorViewCell
        cellForColor.contentView.backgroundColor = Colors.colorsForLines[indexPath.row]
        return cellForColor
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        drawVC.color = Colors.colorsForLines[indexPath.row]
        tableView.isHidden = true
        drawVC.canvas.buttonForPalette.isHidden = false
    }
    
}
