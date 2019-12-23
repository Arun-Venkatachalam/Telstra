//
//  EmployeeTableViewCell.swift
//  TelstraDemo
//
//  Created by Arun.V on 11/12/19.
//  Copyright © 2019 Arun.V. All rights reserved.
//

import UIKit

class CountryTableViewCell: UITableViewCell {
    
    let mainStackView =  UIStackView()
    let cellImageView = UIImageView()
    let descriptionStackView =  UIStackView()
    let titleLabel = UILabel()
    let descriptionLabel = UILabel()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    func commonInit() {
        mainStackView.axis = .horizontal
        mainStackView.alignment = .center
        mainStackView.distribution = .fill
        mainStackView.spacing = 16
        contentView.addSubview(mainStackView)
        mainStackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            mainStackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 24),
            mainStackView.leadingAnchor.constraint(equalTo: contentView.readableContentGuide.leadingAnchor),
            mainStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -24),
            mainStackView.trailingAnchor.constraint(equalTo: contentView.readableContentGuide.trailingAnchor)
            ])
        
        //Added horz stack elements.
        cellImageView.translatesAutoresizingMaskIntoConstraints = false
        cellImageView.contentMode = .scaleAspectFill
        cellImageView.clipsToBounds = true
        cellImageView.widthAnchor.constraint(equalToConstant: 100).isActive = true
        cellImageView.heightAnchor.constraint(equalToConstant: 78).isActive = true
        mainStackView.addArrangedSubview(cellImageView)
        
        descriptionStackView.translatesAutoresizingMaskIntoConstraints = false
        descriptionStackView.axis = .vertical
        descriptionStackView.alignment = .fill
        descriptionStackView.distribution = .fill
        mainStackView.addArrangedSubview(descriptionStackView)

        //Added desc vert stack elements.
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.numberOfLines = 0
        titleLabel.font = .preferredFont(forTextStyle: .subheadline)
        descriptionStackView.addArrangedSubview(titleLabel)
        descriptionStackView.setCustomSpacing(6, after: titleLabel)

        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        descriptionLabel.numberOfLines = 0
        descriptionLabel.font = .preferredFont(forTextStyle: .subheadline)
        descriptionStackView.addArrangedSubview(descriptionLabel)
        descriptionStackView.setCustomSpacing(8, after: descriptionLabel)
    }
    
    override func prepareForReuse() {
        titleLabel.text = nil
        descriptionLabel.text = nil
        cellImageView.image = nil
    }
}
