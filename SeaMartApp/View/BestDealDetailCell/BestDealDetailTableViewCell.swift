//
//  BestDealDetailTableViewCell.swift
//  SeaMartApp
//
//  Created by mehtab alam on 10/02/2021.
//

import UIKit

//MARK:- Protocol
protocol AlertDelegate {
    func showAlert(str:String)
    func updateCheckOutList()
}

class BestDealDetailTableViewCell: UITableViewCell {
    
    //MARK:- OUTLET
    @IBOutlet weak var bestAttributeImg: UIImageView!
    @IBOutlet weak var bestDiscriptionLbl: UILabel!
    @IBOutlet weak var bestWightLbl: UILabel!
    @IBOutlet weak var bestPriceLbl: UILabel!
    @IBOutlet weak var addBtn: UIButton!
    @IBOutlet weak var stackViewPlusMinus: UIStackView!
    @IBOutlet weak var minusOutletBtn: UIButton!
    @IBOutlet weak var plusOutletBtn: UIButton!
    @IBOutlet weak var viewOutOfStock: UIView!
    @IBOutlet weak var MRPLbl: UILabel!
    @IBOutlet weak var viewForhide: UIView!
    
    //MARK:- Variable
    var delegate: AlertDelegate?
    var kgChickenPrice:Double!
    
    // MARK:- Variable add cart
    var userPhone:String!
    var userEmail:String!
    var pincode:String!
    
    var callBackForAddBtn:(() ->())?
    
    //MARK:- Instance created for service API
    private var serviceInstance = Service()

    override func awakeFromNib() {
        super.awakeFromNib()
        userEmail = singleton.shared.getFromDefault(Key: DefaultKeys.email) as? String
        userPhone = singleton.shared.getFromDefault(Key: DefaultKeys.mobile) as? String
        pincode = singleton.shared.getFromDefault(Key: DefaultKeys.pincode) as? String
        print(pincode!,"pin")
      //  userId = singleton.shared.getFromDefault(Key: DefaultKeys.userId)
    }
    @IBAction func OnClickAddButton(_ sender: UIButton) {
        self.callBackForAddBtn?()
//        if sender.tag == 0 {
//            self.addBtn.isHidden = true
//        } else {
//            self.addBtn.isHidden = false
//        }
    }
    
    //function use to call in the cell
    func configCellForBestDealDetail(data: ProductAttributeDetails) {
        kgChickenPrice = data.price!.count > 0 ? Double(data.price![0].price!) : 0.0
        bestDiscriptionLbl.text = data.productName
        if bestWightLbl.text == data.weight {
            bestWightLbl.text = "0.0"
        }
        
        bestPriceLbl.text = data.price!.count > 0 ? "₹\(data.price![0].price!)" : "0"
        if data.mrpPrice!.count > 0 {
            MRPLbl.text = "₹\(data.mrpPrice!)"
        } else {
            MRPLbl.text = "0.0"
        }
        let link = SeaMartURL.productImageURL
        if data.image != nil {
            let completeLink = link + data.image!
            bestAttributeImg.sd_setImage(with: URL(string: completeLink), placeholderImage: UIImage(named: "placeholder"))
        }
    }
}
