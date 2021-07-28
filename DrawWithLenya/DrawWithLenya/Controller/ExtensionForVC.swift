//
//  ExtensionForVC.swift
//  DrawWithLenya
//
//  Created by Виктория Козырева on 24.07.2021.
//

import UIKit

extension ViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        PictureStash.pictures.count
        15
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.row == 0 {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "New", for: indexPath) as! NewFileViewCell
            return cell
        }
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Picture", for: indexPath) as! PictureViewCell
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didEndDisplaying cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if indexPath.row == 1 {
            navigationItem.rightBarButtonItem = rightBarButtonItem
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if indexPath.row == 1 {
            navigationItem.rightBarButtonItem = nil
        }
    }
}

extension ViewController: UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: view.bounds.width/2 - 1, height: view.bounds.width/2 - 1)
    }
}

