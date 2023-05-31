//
//  SummaryTableViewCell.swift
//  ProtiensApp
//
//  Created by mehtab alam on 27/01/2021.
//

import UIKit

class SummaryTableViewCell: UITableViewCell {
    
    //MARK:- Outlet
    @IBOutlet weak var itemNameLbl: UILabel!
    @IBOutlet weak var itemPriceLbl: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
