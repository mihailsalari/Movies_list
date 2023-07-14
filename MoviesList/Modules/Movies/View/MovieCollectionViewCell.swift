//
//  MovieCollectionViewCell.swift
//  CntRecipeTest
//
//  Created by Mihail Salari on 7/15/23.
//

import UIKit

final class MovieCollectionViewCell: UICollectionViewCell {
    static let reuseIdentifier = String(describing: MovieCollectionViewCell.self)
    
    // https://developer.apple.com/forums/thread/133576
    override func preferredLayoutAttributesFitting(_ layoutAttributes: UICollectionViewLayoutAttributes) -> UICollectionViewLayoutAttributes {
        
        setNeedsLayout()
        layoutIfNeeded()
        
        let size = contentView.systemLayoutSizeFitting(layoutAttributes.size)
        
        var frame = layoutAttributes.frame
        frame.size.height = ceil(size.height)
        layoutAttributes.frame = frame
        
        return layoutAttributes
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        shadowDecorate()
    }
    
    @IBOutlet private weak var yearLabel: UILabel!
    @IBOutlet private weak var imdbLabel: UILabel!
    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet private weak var imgView: UIImageView!
    
    @IBOutlet private weak var spinner: UIActivityIndicatorView!
    
    func configure(with movieSearch: MovieSearch) {
        yearLabel.text = movieSearch.year
        imdbLabel.text = movieSearch.type.rawValue.capitalized
        nameLabel.text = movieSearch.title
        if let posterImage = movieSearch.posterImage {
            imgView.image = UIImage(data: posterImage)
            spinner.stopAnimating()
        } else {
            spinner.startAnimating()
        }
    }
}

extension UICollectionViewCell {
    func shadowDecorate() {
        self.layer.cornerRadius = 10
        self.layer.borderWidth = 0.0
        self.layer.borderColor = UIColor.lightGray.cgColor

        self.layer.backgroundColor = UIColor.white.cgColor
        self.layer.shadowColor = UIColor.gray.cgColor
        self.layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
        self.layer.shadowRadius = 3.0
        self.layer.shadowOpacity = 0.5
        self.layer.masksToBounds = false
    }
}
