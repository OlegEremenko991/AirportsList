//
//  DataCell.swift
//  AlarStudios_TestTask
//
//  Created by Олег Еременко on 02.10.2020.
//

// на 4:53 показывает настройки ячейки https://youtu.be/Axe4SoUigLU?t=293

import UIKit

class DataCell: UITableViewCell {

    // MARK: Public properties
    
    static let identifier = "DataCell"
    
    // MARK: IBOutlets
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var countryLabel: UILabel!
    @IBOutlet weak var countryImageView: CustomImageView!
    
    // MARK: Lifecycle
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupView()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    private func setupView() {
        titleLabel.setupLabel(text: titleLabel.text ?? "", font: UIFont.systemFont(ofSize: 16, weight: .semibold), textColor: .black)
        titleLabel.numberOfLines = 0
        
        countryLabel.setupLabel(text: countryLabel.text ?? "", font: UIFont.systemFont(ofSize: 14, weight: .regular), textColor: .systemGray)
        countryLabel.numberOfLines = 0
    }
    
}
