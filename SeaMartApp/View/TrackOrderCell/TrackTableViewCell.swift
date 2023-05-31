//
//  TrackTableViewCell.swift
//  ProtiensApp
//
//  Created by mehtab alam on 26/01/2021.
//

import UIKit

class TrackTableViewCell: UITableViewCell {

    //MARK:- Outlet
    @IBOutlet weak var deliveryAddLbl: UILabel!
    @IBOutlet weak var orderNoLbl: UILabel!
    @IBOutlet weak var itemNameLbl: UILabel!
    @IBOutlet weak var itemPriceLbl: UILabel!
    @IBOutlet weak var itemNameOneLbl: UILabel!
    @IBOutlet weak var itemPriceOneLbl: UILabel!
    @IBOutlet weak var viewOne: UIView!
    @IBOutlet weak var viewTwo: UIView!
    @IBOutlet weak var trackBtn: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
