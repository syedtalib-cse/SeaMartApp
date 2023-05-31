//
//  DeliveryLocationTableViewCell.swift
//  SeaMartApp
//
//  Created by mehtab alam on 17/02/2021.
//

import UIKit
import DLRadioButton
class DeliveryLocationTableViewCell: UITableViewCell {
    //MARK:- Outlet
    @IBOutlet weak var addressLbl: UILabel!
    @IBOutlet weak var workLbl: UILabel!
    @IBOutlet weak var editOutlet: UIButton!
    @IBOutlet weak var removeOutlet: UIButton!
    @IBOutlet weak var radioBtn: UIButton!
    @IBOutlet weak var radioView: UIView!

    override func awakeFromNib() {
        super.awakeFromNib()
//        self.radioBtn.setTitleColor(.red, for: .selected)
//        self.radioBtn.setTitleColor(.black, for: .normal)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
