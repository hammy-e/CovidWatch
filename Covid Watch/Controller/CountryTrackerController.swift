//
//  CountryTrackerController.swift
//  Covid Watch
//
//  Created by Abraham Estrada on 4/20/21.
//

import Foundation

import UIKit
import SwiftyJSON

private let cellIdentifier = "cell"
private let headerIdentifier = "header"

class CountryTrackerController: UICollectionViewController {
    
    // MARK: - Properties

    var country: Country? {
        didSet{
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }
    }
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.backgroundColor = .black
        
        collectionView.register(VaccineDataCell.self, forCellWithReuseIdentifier: cellIdentifier)
        collectionView.register(TrackerHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: headerIdentifier)
    }
}

// MARK: - UICollectionViewDataSource

extension CountryTrackerController {
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as! VaccineDataCell
        cell.country = country
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: headerIdentifier, for: indexPath) as! TrackerHeader
        header.country = country
        return header
    }
}

// MARK: - UICollectionViewDelegateFlowLayout

extension CountryTrackerController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: 250)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: view.frame.width, height: 300)
    }
}
