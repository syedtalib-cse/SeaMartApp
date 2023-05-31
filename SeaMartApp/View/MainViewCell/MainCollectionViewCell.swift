//
//  MainCollectionViewCell.swift
//  ProtiensApp
//
//  Created by mehtab alam on 14/12/2020.
//

import UIKit

class MainCollectionViewCell: UICollectionViewCell {
    
    //MARK:- Outlet
    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var categorySmallImage: UIImageView!
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    //function use to call in the cell
    func configCellForParentCategory(data: Parent_categories) {
        categoryLabel.text = data.description
      //  let link = "https://ebosapps.com/proteins/assets/images/categories/"
        // let completeLink = link + parentObject[indexPath.row].icon!
        let link = SeaMartURL.categoryImageURL
        if data.icon != nil {
        let completeLink = link + data.icon!
        categorySmallImage.sd_setImage(with: URL(string: completeLink), placeholderImage: UIImage(named: "placeholder"))
        }
    }
//    // ovverride func for collection view layout fix
//    override func preferredLayoutAttributesFitting(_ layoutAttributes: UICollectionViewLayoutAttributes) -> UICollectionViewLayoutAttributes {
//        setNeedsLayout()
//        layoutIfNeeded()
//        return layoutAttributes
//    }
}
