//
//  BestDealCollectionViewCell.swift
//  ProtiensApp
//
//  Created by mehtab alam on 17/12/2020.
//

import UIKit

class BestDealCollectionViewCell: UICollectionViewCell {
    
    //MARK:- Outlet
    @IBOutlet weak var bestDealImageView: UIImageView!
    @IBOutlet weak var bestDealLabel: UILabel!
    @IBOutlet weak var backgroundImage: UIImageView!
    @IBOutlet weak var bestDealPriceLabel: UILabel!
    @IBOutlet weak var viewDetail: UIButton!
    @IBOutlet weak var discountLbl: UILabel!
    @IBOutlet weak var MRPPriceLbl: UILabel!
    
    override func layoutSubviews() {
        super.layoutSubviews()
        viewDetail.layer.cornerRadius = 8
        discountLbl.labelRoundCorners(corners: [.topLeft, .bottomLeft], radius: 8.0)
//        bestDealImageView.layer.cornerRadius = 30
//        bestDealImageView.clipsToBounds = true
    }
    
    //function use to call in the cell
    func configCellForBestDeal(data: Best_deal_products) {
        bestDealLabel.text = data.product_name
        bestDealPriceLabel.text = "₹\(data.price!)"
        MRPPriceLbl.text = "₹\(data.mrp_price!)"
        if data.discount == "\(0)" {
            discountLbl.isHidden = true
        }else {
        discountLbl.text = "\(data.discount!)%"
        }
        let link = SeaMartURL.productImageURL
        if data.image != nil {
        let completeLink = link + data.image!
        bestDealImageView.sd_setImage(with: URL(string: completeLink), placeholderImage: UIImage(named: "placeholder"))
        }
    }
    
    // ovverride func for collection view layout fix
    override func preferredLayoutAttributesFitting(_ layoutAttributes: UICollectionViewLayoutAttributes) -> UICollectionViewLayoutAttributes {
        setNeedsLayout()
        layoutIfNeeded()
        return layoutAttributes
    }
}
