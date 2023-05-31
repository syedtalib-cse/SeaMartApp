//
//  CategoryCollectionViewCell.swift
//  ProtiensApp
//
//  Created by mehtab alam on 15/12/2020.
//

import UIKit

class CategoryCollectionViewCell: UICollectionViewCell {
    
    //MARK:- Outlet
    @IBOutlet weak var categoryImage: UIImageView!
    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var viewDetail3: UIButton!
    @IBOutlet weak var categoryPriceLbl: UILabel!
    @IBOutlet weak var discountLbl: UILabel!
    @IBOutlet weak var MRPPriceLbl: UILabel!
    
    override func layoutSubviews() {
        super.layoutSubviews()
        discountLbl.labelRoundCorners(corners: [.topLeft, .bottomLeft], radius: 8.0)
    }
    
    //function use to call in the cell
    func configCellUsingSubCategory(data: ProductsByChildCategory) {
        categoryLabel.text = data.product_name
        categoryPriceLbl.text = data.price
       // discountLbl.text = data.discount
        let link = SeaMartURL.productImageURL
        if data.image != nil {
        let completeLink = link + data.image!
        categoryImage.sd_setImage(with: URL(string: completeLink), placeholderImage: UIImage(named: "placeholder"))
        }
    }
    
    //function use to call in the cell
    func configCellForCategory(data: Productsbycategory) {
        categoryLabel.text = data.product_name
        MRPPriceLbl.text = "₹\(data.mrp_price!)"
        categoryPriceLbl.text = "₹\(data.price!)"
        if data.discount == "\(0)" {
            discountLbl.isHidden = true
        }else {
            discountLbl.isHidden = false
        discountLbl.text = "\(data.discount!)%"
        }
        let link = SeaMartURL.productImageURL
        if data.image != nil {
        let completeLink = link + data.image!
        categoryImage.sd_setImage(with: URL(string: completeLink), placeholderImage: UIImage(named: "placeholder"))
        }
    }
}
