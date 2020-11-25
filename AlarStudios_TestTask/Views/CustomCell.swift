//
//  CustomCell.swift
//  AlarStudios_TestTask
//
//  Created by Олег Еременко on 03.10.2020.
//

import UIKit

final class CustomCell: UITableViewCell {

    // MARK: Public properties

    static let identifier = "CustomCellId"
    let flagImage = CustomImageView()
    let titleLabel = UILabel()
    let countryLabel = UILabel()
    let containerView = UIView()

    // MARK: Lifecycle

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: Private methods

    private func setupView() {
        setupImageView()
        setupContainerView()
    }

    private func setupImageView() {
        addSubview(flagImage)
        flagImage.translatesAutoresizingMaskIntoConstraints = false
        flagImage.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10).isActive = true
        flagImage.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        flagImage.widthAnchor.constraint(equalToConstant: 50).isActive = true
        flagImage.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }

    private func setupContainerView() {
        containerView.addSubview(titleLabel)
        containerView.addSubview(countryLabel)
        addSubview(containerView)

        containerView.translatesAutoresizingMaskIntoConstraints = false
        containerView.topAnchor.constraint(equalTo: topAnchor, constant: 5).isActive = true
        containerView.leadingAnchor.constraint(equalTo: flagImage.trailingAnchor, constant: 20).isActive = true
        containerView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10).isActive = true
        containerView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -5).isActive = true

        setupTitleLabel()
        setupCountryLabel()
    }

    private func setupTitleLabel() {
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor).isActive = true
        titleLabel.topAnchor.constraint(equalTo: containerView.topAnchor).isActive = true
        titleLabel.font = UIFont(name: "Verdana-Bold", size: 16)
        titleLabel.numberOfLines = 0
    }
    
    private func setupCountryLabel() {
        countryLabel.translatesAutoresizingMaskIntoConstraints = false
        countryLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor).isActive = true
        countryLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor).isActive = true
        countryLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 5).isActive = true
        countryLabel.font = UIFont(name: "Verdana", size: 14)
        countryLabel.numberOfLines = 0
    }

}
