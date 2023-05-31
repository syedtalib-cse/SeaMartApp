//
//  SliderCollectionViewCell.swift
//  SeaMartApp
//
//  Created by mehtab alam on 06/02/2021.
//

import UIKit
import SDWebImage
class SliderCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var sliderImageView: UIImageView!
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    //function use to call in the cell
    func configCellForSlider(data: Slider_banners) {
        let link = SeaMartURL.bannerImageURL
        if data.image != nil {
        let completeLink = link + data.image!
        sliderImageView.sd_setImage(with: URL(string: completeLink), placeholderImage: UIImage(named: "placeholder"))
        }
    }
    
    // ovverride func for collection view layout fix
    override func preferredLayoutAttributesFitting(_ layoutAttributes: UICollectionViewLayoutAttributes) -> UICollectionViewLayoutAttributes {
        setNeedsLayout()
        layoutIfNeeded()
        return layoutAttributes
    }
}

