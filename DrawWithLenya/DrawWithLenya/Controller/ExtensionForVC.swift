//
//  ExtensionForVC.swift
//  DrawWithLenya
//
//  Created by Виктория Козырева on 24.07.2021.
//

import UIKit

//MARK: Расширение для коллекции главного экрана
extension ViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        PictureStash.pictures.count + 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.row == 0 {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "New", for: indexPath) as! NewFileViewCell
        return cell
        }
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Picture", for: indexPath) as! PictureViewCell
        cell.configCell(name: PictureStash.pictures[indexPath.row - 1].imgName, img: PictureStash.pictures[indexPath.row - 1].img)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didEndDisplaying cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if indexPath.row == 0 {
            navigationItem.rightBarButtonItem = rightBarButtonItem
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if indexPath.row == 0 {
            navigationItem.rightBarButtonItem = nil
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.row == 0 {
            pushDrawVC()
        }
    }
}

extension ViewController: UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: view.bounds.width/2 - 1, height: view.bounds.width/2 - 1)
    }
}

extension ViewController: SaveImageProtocol {
    func save(image: Picture) {
        PictureStash.pictures.insert(image, at: 0)
        updateNavTitle()
        collectionView.reloadData()
    }
}

//MARK: Здесь расширения для коллекции, которая находится в рисовалке
extension ToolViewController:  UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        //значение постоянно, потому что у нас ровно 6 инструментов
        return 6
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let toolCell = collectionView.dequeueReusableCell(withReuseIdentifier: "tools", for: indexPath) as! ToolsViewCell
        toolCell.setImage(image: UIImage(named: DataStash.namesOfImage[indexPath.row].namedForImage) ?? UIImage())
        return toolCell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectedIndexPath = indexPath
        let cell = collectionView.cellForItem(at: indexPath)
        UIView.animate(withDuration: 0.3, animations: {
            cell?.layer.cornerRadius = (60*1.5)/2.0
        })
        collectionView.performBatchUpdates(nil, completion: nil)
        drawVC.currentTool = DataStash.namesOfImage[indexPath.row].type
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath)
        UIView.animate(withDuration: 0.3, animations: {
            cell?.layer.cornerRadius = 60 / 2.0
        })
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        var size = CGSize(width: 60, height: 60)
        if let index = selectedIndexPath, index.row == indexPath.row{
            size = CGSize(width: 60*1.5, height: 60*1.5)
            return size
        }
        return size
    }
}

//MARK: Здесь расширения для таблицы, которая находится в рисовалке
extension ToolViewController: UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        DataStash.colorsForLines.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellForColor =  tableView.dequeueReusableCell(withIdentifier: "color", for: indexPath) as! ColorViewCell
        cellForColor.contentView.backgroundColor = DataStash.colorsForLines[indexPath.row]
        return cellForColor
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        drawVC.color = DataStash.colorsForLines[indexPath.row]
        buttonForPalette.backgroundColor = DataStash.colorsForLines[indexPath.row]
        UIView.animate(withDuration: 2.5, animations: {
            [weak self] in
            tableView.isHidden = true
            self?.buttonForPalette.isHidden = false
        })
    }
    
}
