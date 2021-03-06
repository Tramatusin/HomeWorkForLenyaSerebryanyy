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
    
    let canvas = DrawView()
    var line :[CGPoint] = []
    let tools = ToolsForDraw()
    var currentTool: ModeDraw = .triangle
    var color: UIColor = UIColor.red
    
    override func viewDidLoad() {
        super.viewDidLoad()
        canvas.backgroundColor = .blue
        view = canvas
        
        setupConstraints()
    }
    
    func setupConstraints(){
        view.addSubview(collectionFromTools)
        view.addSubview(tableViewForColors)

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
        color = Colors.colorsForLines[indexPath.row]
        tableView.isHidden = true
    }
    
}
