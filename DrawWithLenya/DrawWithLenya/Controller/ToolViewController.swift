//
//  DrawViewController.swift
//  DrawWithLenya
//
//  Created by Виктория Козырева on 24.07.2021.
//

import UIKit

class ToolViewController: UIViewController{
    
    weak var delegate: SaveImageProtocol?
    
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
        collection.showsHorizontalScrollIndicator = false
        collection.register(ToolsViewCell.self, forCellWithReuseIdentifier: "tools")
        return collection
    }()
    
    lazy var leftGradientView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var leftGradient: CAGradientLayer = {
        let gradient = CAGradientLayer()
        gradient.colors = [UIColor.white.cgColor, UIColor.white.withAlphaComponent(0).cgColor]
        gradient.startPoint = CGPoint(x: 0.0, y: 0.5)
        gradient.endPoint = CGPoint(x: 1.0, y: 0.5)
        return gradient
    }()
    
    lazy var rightGradientView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var rightGradient: CAGradientLayer = {
        let gradient = CAGradientLayer()
        gradient.colors = [UIColor.white.cgColor, UIColor.white.withAlphaComponent(0).cgColor]
        gradient.startPoint = CGPoint(x: 1.0, y: 0.5)
        gradient.endPoint = CGPoint(x: 0.0, y: 0.5)
        return gradient
    }()
    
    lazy var tableViewForColors: UITableView = {
        let tableView = UITableView(frame: .zero)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.showsVerticalScrollIndicator = false
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
        setupCollectonViewSideGradient()
        let rightBarButtonSave = UIBarButtonItem.init(barButtonSystemItem: .save, target: self, action: #selector(saveImage))
        let rightBarButtonCancel = UIBarButtonItem.init(barButtonSystemItem: .cancel, target: self, action: #selector(tapOnBar))
        navigationItem.rightBarButtonItems = [rightBarButtonCancel, rightBarButtonSave]
        //drawVC.didMove(toParent: self)
    }
    
    @objc func saveImage() {
        let renderer = UIGraphicsImageRenderer(bounds: drawVC.view.bounds)
        let image = renderer.image { rendererContext in
            drawVC.view.layer.render(in: rendererContext.cgContext)
        }
        let alertView = UIAlertController(title: "Name", message: nil, preferredStyle: .alert)
        var namedTextField: UITextField?
        var imageName: String = ""
        alertView.addTextField { text in
            namedTextField = text
            text.placeholder = "Enter picture name"
        }
        alertView.addAction(UIAlertAction(title: "OK", style: .default, handler: { _ in
            imageName = namedTextField?.text ?? "Unnamed image"
            let renderedImage = Picture.init(name: imageName, image: image)
            self.delegate?.save(image: renderedImage)
            self.navigationController?.popViewController(animated: true)
        }))
        
        self.present(alertView, animated: true, completion: nil)
    }
    
    func setupCollectonViewSideGradient() {
        view.addSubview(rightGradientView)
        view.addSubview(leftGradientView)
        
        NSLayoutConstraint.activate([
            leftGradientView.topAnchor.constraint(equalTo: collectionFromTools.topAnchor, constant: 10),
            leftGradientView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            leftGradientView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            leftGradientView.widthAnchor.constraint(equalToConstant: 15)
        ])
        NSLayoutConstraint.activate([
            rightGradientView.topAnchor.constraint(equalTo: collectionFromTools.topAnchor, constant: 10),
            rightGradientView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            rightGradientView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            rightGradientView.widthAnchor.constraint(equalToConstant: 15)
        ])
        
        rightGradient.removeFromSuperlayer()
        leftGradient.removeFromSuperlayer()
        
        leftGradient.frame = CGRect(x: 0, y: 0, width: view.bounds.width / 8, height: 80)
        leftGradient.cornerRadius = 25
        leftGradient.maskedCorners = [.layerMinXMaxYCorner, .layerMinXMinYCorner]
        rightGradient.frame = CGRect(x: -32, y: 0, width: view.bounds.width / 8, height: 80)
        rightGradient.cornerRadius = 25
        rightGradient.maskedCorners = [.layerMaxXMaxYCorner, .layerMaxXMinYCorner]
        rightGradientView.layer.addSublayer(rightGradient)
        leftGradientView.layer.addSublayer(leftGradient)
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
            collectionFromTools.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 8),
            collectionFromTools.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -8),
            collectionFromTools.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -8),
            collectionFromTools.heightAnchor.constraint(equalToConstant: 100)
        ])
        
        NSLayoutConstraint.activate([
            tableViewForColors.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 8),
            tableViewForColors.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant:34),
            tableViewForColors.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.6),
            tableViewForColors.widthAnchor.constraint(equalToConstant: 60)
        ])
        
        collectionFromTools.setNeedsLayout()
        collectionFromTools.layoutIfNeeded()
    }
}
