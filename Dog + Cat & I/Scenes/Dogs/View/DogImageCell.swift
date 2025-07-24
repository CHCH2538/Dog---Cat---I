//
//  DogImageCell.swift
//  Dog + Cat & I
//
//  Created by Pongpubate Charoensinputthakhun on 23/7/2568 BE.
//

import UIKit
import SDWebImage

final class DogImageCell: UICollectionViewCell {
    
    // MARK: IBOutlets
    @IBOutlet weak var contentStackView: UIStackView!
    @IBOutlet weak var dogImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    
    // MARK: Properties
    static let identifier = "DogImageCell"
    static let nibName = "DogImageCell"
    
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
    func configure(with imageData: DogImageDisplayData) {
        titleLabel.text = "\(imageData.title) @ \(imageData.timestamp)"
        
        let options: SDWebImageOptions = [
            .retryFailed,
            .refreshCached,
            .progressiveLoad
        ]
        
        dogImageView.sd_setImage(
            with: URL(string: imageData.imageURL),
            placeholderImage: UIImage(named: "image-placeholder"),
            options: options
        )
    }
    
    // MARK: Private Methods
    private func setupCell() {
        contentStackView.spacing = 4
        dogImageView.contentMode = .scaleAspectFit
        dogImageView.clipsToBounds = true
        dogImageView.layer.cornerRadius = 8
        dogImageView.backgroundColor = .systemGray6
        
        titleLabel.textColor = .label
        titleLabel.numberOfLines = 0
    }
    
    private func resetCell() {
        dogImageView.image = nil
        titleLabel.text = nil
        dogImageView.sd_cancelCurrentImageLoad()
    }
}

// MARK: - Nib Registration Helper
extension DogImageCell {
    
    static func register(for collectionView: UICollectionView) {
        let nib = UINib(nibName: nibName, bundle: nil)
        collectionView.register(nib, forCellWithReuseIdentifier: identifier)
    }
} 
