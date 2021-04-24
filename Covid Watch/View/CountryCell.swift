//
//  CountryCell.swift
//  Covid Watch
//
//  Created by Abraham Estrada on 4/20/21.
//

import UIKit

class CountryCell: UICollectionViewCell {
    
    // MARK: - Properties
    
    var country: Country? {
        didSet{configure()}
    }
    
    private let roundedView: UIView = {
        let view = UIView()
        view.backgroundColor = DARKGRAY
        view.layer.cornerRadius = 25
        return view
    }()

    private let countryLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.textColor = .white
        return label
    }()
    
    // MARK: - Lifecycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(roundedView)
        roundedView.anchor(top: topAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, paddingTop: 0, paddingLeft: 10, paddingBottom: 0, paddingRight: 10)
        
        addSubview(countryLabel)
        countryLabel.centerY(inView: roundedView, leftAnchor: leftAnchor, paddingLeft: 22)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Helpers
    
    func configure() {
        guard let country = country else {return}
        countryLabel.text = "\(country.icon) \(country.name)"
    }
}
