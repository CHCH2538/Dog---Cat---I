//
//  CatBreedHeaderCell.swift
//  Dog + Cat & I
//
//  Created by Pongpubate Charoensinputthakhun on 23/7/2568 BE.
//

import UIKit

final class CatBreedHeaderCell: UITableViewCell {
    
    // MARK: IBOutlets
    @IBOutlet weak var breedNameLabel: UILabel!
    @IBOutlet weak var expandCollapseImageView: UIImageView!
    
    // MARK: Properties
    static let identifier = "CatBreedHeaderCell"
    static let nibName = "CatBreedHeaderCell"
    
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
    func configure(with breed: CatBreed, isExpanded: Bool) {
        breedNameLabel.text = breed.breed
        
        let imageName = isExpanded ? "chevron.up" : "chevron.down"
        expandCollapseImageView.image = UIImage(systemName: imageName)
        expandCollapseImageView.tintColor = .systemBlue
    }
    
    // MARK: Private Methods
    private func setupCell() {
        backgroundColor = .systemBackground
        selectionStyle = .none
        
        breedNameLabel.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        breedNameLabel.textColor = .label
        breedNameLabel.numberOfLines = 0
        
        expandCollapseImageView.contentMode = .scaleAspectFit
        expandCollapseImageView.tintColor = .systemBlue
    }
    
    private func resetCell() {
        breedNameLabel.text = nil
        expandCollapseImageView.image = nil
    }
    
}

// MARK: - Nib Registration Helper
extension CatBreedHeaderCell {
    
    static func register(for tableView: UITableView) {
        let nib = UINib(nibName: nibName, bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: identifier)
    }
    
} 
