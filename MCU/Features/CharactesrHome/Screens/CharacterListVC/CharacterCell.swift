//
//  CharacterCell.swift
//  MCU
//
//  Created by Naman Vaishnav on 21/08/22.
//


import UIKit

class CharacterCell: UICollectionViewCell {
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var btnName: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setupView()
    }
    
    /// setup view for character cell
    fileprivate func setupView() {
        imgView.layer.cornerRadius = 12.0
        imgView.clipsToBounds = true
        btnName.setTitleColor(.black, for: .normal)
        btnName.titleLabel?.adjustsFontSizeToFitWidth = true
        btnName.titleLabel?.autoresizesSubviews = true
        btnName.autoresizingMask = [UIView.AutoresizingMask.flexibleRightMargin, UIView.AutoresizingMask.flexibleTopMargin]
        btnName.backgroundColor = .clear
        btnName.titleLabel?.font = UIFont.boldSystemFont(ofSize: UIFont.systemFontSize)
        btnName.accessibilityIdentifier = "name"
        btnName.titleLabel?.lineBreakMode = .byWordWrapping
        btnName.titleLabel?.numberOfLines = 0
        btnName.setBackgroundImage(UIImage(named: "ic_title_background"), for: .normal)
        btnName.titleEdgeInsets = UIEdgeInsets(top: 4, left: 4, bottom: 4, right: 4)
    }
}
