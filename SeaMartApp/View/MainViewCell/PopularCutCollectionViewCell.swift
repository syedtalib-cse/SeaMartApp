//
//  PopularCutCollectionViewCell.swift
//  ProtiensApp
//
//  Created by mehtab alam on 17/12/2020.
//

import UIKit
import SDWebImage

class PopularCutCollectionViewCell: UICollectionViewCell {
    
    //MARK:- Outlet
    @IBOutlet weak var popularcutImageView: UIImageView!
    @IBOutlet weak var popularCutLabel: UILabel!
    @IBOutlet weak var backgroundLbl: UILabel!
    @IBOutlet weak var viewDetail2: UIButton!
    @IBOutlet weak var popularCutPriceLabel: UILabel!
    @IBOutlet weak var discountLbl: UILabel!
    @IBOutlet weak var MRPPriceLbl: UILabel!
    
    override func layoutSubviews() {
        super.layoutSubviews()
        viewDetail2.layer.cornerRadius = 8
        discountLbl.labelRoundCorners(corners: [.topLeft, .bottomLeft], radius: 8.0)
    }
    
    //function use to call in the cell
    func configCellForPopularCut(data: Trending_products) {
        popularCutLabel.text = data.product_name
        popularCutPriceLabel.text = "₹\(data.price!)"
        MRPPriceLbl.text = "₹\(data.mrp_price!)"
        if data.discount == "\(0)" {
            discountLbl.isHidden = true
        }else {
        discountLbl.text = "\(data.discount!)%"
        }
        let link = SeaMartURL.productImageURL
        if data.image != nil {
        let completeLink = link + data.image!
        popularcutImageView.sd_setImage(with: URL(string: completeLink), placeholderImage: UIImage(named: "placeholder"))
        }
    }
    // ovverride func for collection view layout fix
    override func preferredLayoutAttributesFitting(_ layoutAttributes: UICollectionViewLayoutAttributes) -> UICollectionViewLayoutAttributes {
        setNeedsLayout()
        layoutIfNeeded()
        return layoutAttributes
    }
}
