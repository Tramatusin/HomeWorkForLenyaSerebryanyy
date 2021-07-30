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
            buttonForPalette.topAnchor.constraint(equalTo: view.topAnchor, constant: 74),
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
        toolCell.setImage(image: UIImage(named: Colors.namesOfImage[indexPath.row]) ?? UIImage())
        return toolCell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectedIndexPath = indexPath
        collectionView.performBatchUpdates(nil, completion: nil)
        switch indexPath.row {
        case 0:
            drawVC.currentTool = .circle
        case 1:
            drawVC.currentTool = .rect
        case 2:
            drawVC.currentTool = .straight
        case 3:
            drawVC.currentTool = .triangle
        case 4:
            drawVC.currentTool = .line
        case 5:
            drawVC.currentTool = .rectWithCornRadius
        default:
            print(indexPath)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cell = collectionView.cellForItem(at: indexPath)
        var size = CGSize(width: 60, height: 60)
        if let index = selectedIndexPath, index.row == indexPath.row{
            size = CGSize(width: 60*1.5, height: 60*1.5)
            UIView.animate(withDuration: 2.0, animations: {
                cell?.layer.cornerRadius = (60*1.5)/2.0
                cell?.transform = CGAffineTransform(scaleX: 1.5, y: 1.5)
            })
            return size
        }
        UIView.animate(withDuration: 0.5, animations: {
            cell?.layer.cornerRadius = 60 / 2.0
            cell?.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
        })
        return size
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
        buttonForPalette.backgroundColor = Colors.colorsForLines[indexPath.row]
        UIView.animate(withDuration: 2.5, animations: {
            [weak self] in
            tableView.isHidden = true
            self?.buttonForPalette.isHidden = false
        })
    }
    
}
