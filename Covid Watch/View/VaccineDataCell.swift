//
//  VaccineDataCell.swift
//  Covid Watch
//
//  Created by Abraham Estrada on 4/21/21.
//

import UIKit

class VaccineDataCell: UICollectionViewCell {
    
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

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.textColor = .white
        label.text = "Vaccine Data"
        return label
    }()
    
    private lazy var administeredLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textAlignment = .center
        label.textColor = .white
        label.attributedText = attributedStatText(value: "0", label: "Administered")
        return label
    }()
    
    private lazy var fullyVaccinatedLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textAlignment = .center
        label.textColor = .white
        label.attributedText = attributedStatText(value: "0", label: "Fully Vaccinated")
        return label
    }()
    
    private lazy var partiallyVaccinatedLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textAlignment = .center
        label.textColor = .white
        label.attributedText = attributedStatText(value: "0", label: "Partially Vaccinated")
        return label
    }()
    
    private let percentVaccinatedLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.textAlignment = .center
        label.textColor = .white
        return label
    }()
    
    // MARK: - Lifecycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(roundedView)
        roundedView.anchor(top: topAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, paddingTop: 0, paddingLeft: 10, paddingBottom: 0, paddingRight: 10)
        
        addSubview(titleLabel)
        titleLabel.centerX(inView: roundedView, topAnchor: topAnchor, paddingTop: 18)
        
        let stack = UIStackView(arrangedSubviews: [administeredLabel, fullyVaccinatedLabel, partiallyVaccinatedLabel])
        stack.distribution = .fillEqually
        stack.spacing = 15
        stack.axis = .vertical
        
        addSubview(stack)
        stack.centerX(inView: roundedView, topAnchor: titleLabel.bottomAnchor, paddingTop: 24)
        
        addSubview(percentVaccinatedLabel)
        percentVaccinatedLabel.centerX(inView: roundedView, topAnchor: stack.bottomAnchor, paddingTop: 16)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Helpers
    
    func configure() {
        guard let country = country else {return}
        administeredLabel.attributedText = attributedStatText(value: country.administered, label: "Administered")
        fullyVaccinatedLabel.attributedText = attributedStatText(value: country.fullyVaccinated, label: "Fully Vaccinated")
        partiallyVaccinatedLabel.attributedText = attributedStatText(value: country.partiallyVaccinated, label: "Partially Vaccinated")
        percentVaccinatedLabel.text = "Population Fully Vaccinated: \(country.percentVaccinated)"
    }
}
