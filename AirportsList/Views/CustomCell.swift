//
//  CustomCell.swift
//  AirportsList_TestTask
//
//  Created by Олег Еременко on 03.10.2020.
//

import UIKit

final class CustomCell: UITableViewCell {

    // MARK: - Public properties

    static let identifier = "CustomCellId"
    let flagImage = CustomImageView()
    let titleLabel = UILabel()
    let countryLabel = UILabel()
    let containerView = UIView()

    // MARK: - Lifecycle

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
        setupSubviews()
        setupConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Private methods

    private func setupView() {
        [flagImage, titleLabel, countryLabel, containerView].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        [titleLabel, countryLabel].forEach { $0.numberOfLines = 0 }
        titleLabel.font = UIFont(name: "Verdana-Bold", size: 16)
        countryLabel.font = UIFont(name: "Verdana", size: 14)
    }

    private func setupSubviews() {
        containerView.addSubview(titleLabel)
        containerView.addSubview(countryLabel)
        contentView.addSubview(flagImage)
        contentView.addSubview(containerView)
    }

    private func setupConstraints() {
        // Setup flagImage
        NSLayoutConstraint.activate(
            [
                flagImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
                flagImage.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
                flagImage.widthAnchor.constraint(equalToConstant: 50),
                flagImage.heightAnchor.constraint(equalToConstant: 50)
            ]
        )

        // Setup containerView
        NSLayoutConstraint.activate(
            [
                containerView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
                containerView.leadingAnchor.constraint(equalTo: flagImage.trailingAnchor, constant: 20),
                containerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
                containerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -5),
            ]
        )

        // Setup titleLabel
        NSLayoutConstraint.activate(
            [
                titleLabel.topAnchor.constraint(equalTo: containerView.topAnchor),
                titleLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
                titleLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor)
            ]
        )

        // Setup countryLabel
        NSLayoutConstraint.activate(
            [
                countryLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 5),
                countryLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
                countryLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor)
            ]
        )
    }

}
