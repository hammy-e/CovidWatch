//
//  TrackerHeader.swift
//  Covid Watch
//
//  Created by Abraham Estrada on 4/20/21.
//

import UIKit
import SwiftyJSON

class TrackerHeader: UICollectionReusableView {
    
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
    
    private let icon: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 72)
        label.textAlignment = .center
        label.textColor = .red
        label.text = "🌎"
        return label
    }()
    
    private let countryNameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 24)
        label.textAlignment = .center
        label.textColor = .white
        label.text = "Lodaing..."
        return label
    }()
    
    private lazy var confirmedLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textAlignment = .center
        label.textColor = .white
        label.attributedText = attributedStatText(value: "0", label: "Confirmed")
        return label
    }()
    
    private lazy var recoveredLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textAlignment = .center
        label.textColor = .white
        label.attributedText = attributedStatText(value: "0", label: "Recovered")
        return label
    }()
    
    private lazy var deathsLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textAlignment = .center
        label.textColor = .white
        label.attributedText = attributedStatText(value: "0", label: "Deaths")
        return label
    }()
    
    private let percentInfectedLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.textAlignment = .center
        label.textColor = .white
        label.text = "Population Infected: 0%"
        return label
    }()
    
    // MARK: - Lifecycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(roundedView)
        roundedView.anchor(top: topAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, paddingTop: 8, paddingLeft: 10, paddingBottom: 58, paddingRight: 10)
        
        addSubview(icon)
        icon.centerX(inView: roundedView)
        icon.anchor(top: topAnchor, paddingTop: 32)
        
        addSubview(countryNameLabel)
        countryNameLabel.centerX(inView: roundedView)
        countryNameLabel.anchor(top: icon.bottomAnchor, paddingTop: 24)
        
        let stack = UIStackView(arrangedSubviews: [confirmedLabel, recoveredLabel, deathsLabel])
        stack.distribution = .fillEqually
        stack.spacing = 15
        
        addSubview(stack)
        stack.centerX(inView: roundedView)
        stack.anchor(top: countryNameLabel.bottomAnchor, paddingTop: 12)
        
        addSubview(percentInfectedLabel)
        percentInfectedLabel.centerX(inView: roundedView)
        percentInfectedLabel.anchor(bottom: bottomAnchor, paddingBottom: 16)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Helpers
    
    func configure() {
        guard let country = country else {return}
        countryNameLabel.text = country.name
        icon.text = country.icon
        confirmedLabel.attributedText = attributedStatText(value: country.confirmed, label: "Confirmed")
        recoveredLabel.attributedText = attributedStatText(value: country.recovered, label: "Recovered")
        deathsLabel.attributedText = attributedStatText(value: country.deaths, label: "Deaths")
        percentInfectedLabel.text = "Population Infected: \(country.percentInfected)"
    }
}
