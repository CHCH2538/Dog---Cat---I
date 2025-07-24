//
//  CatBreedContentCell.swift
//  Dog + Cat & I
//
//  Created by Pongpubate Charoensinputthakhun on 23/7/2568 BE.
//

import UIKit

final class CatBreedContentCell: UITableViewCell {
    
    // MARK: IBOutlets
    @IBOutlet weak var countryLabel: UILabel!
    @IBOutlet weak var originLabel: UILabel!
    @IBOutlet weak var coatLabel: UILabel!
    @IBOutlet weak var patternLabel: UILabel!
    
    // MARK: Properties
    static let identifier = "CatBreedContentCell"
    static let nibName = "CatBreedContentCell"
    
    // MARK: Lifecycle
    override func awakeFromNib() {
        super.awakeFromNib()
        setupCell()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        resetCell()
    }
    
    // MARK: Configuration
    func configure(with breed: CatBreed) {
        countryLabel.text = "Country: \(breed.country)"
        originLabel.text = "Origin: \(breed.origin)"
        coatLabel.text = "Coat: \(breed.coat)"
        patternLabel.text = "Pattern: \(breed.pattern)"
    }
    
    // MARK: Private Methods
    private func setupCell() {
        selectionStyle = .none
        backgroundColor = .systemGray6
    }
    
    private func resetCell() {
        countryLabel.text = nil
        originLabel.text = nil
        coatLabel.text = nil
        patternLabel.text = nil
    }
}

// MARK: - Nib Registration Helper

extension CatBreedContentCell {
    
    static func register(for tableView: UITableView) {
        let nib = UINib(nibName: nibName, bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: identifier)
    }
} 
