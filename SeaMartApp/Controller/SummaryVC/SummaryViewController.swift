//
//  SummaryTableViewController.swift
//  ProtiensApp
//
//  Created by mehtab alam on 27/01/2021.
//

import UIKit

class SummaryViewController: UIViewController {
    
    @IBOutlet weak var deliveryAddLbl: UILabel!
    @IBOutlet weak var totalItemLbl: UILabel!
    @IBOutlet weak var couponDiscountLbl: UILabel!
    @IBOutlet weak var taxLbl: UILabel!
    @IBOutlet weak var dliveryChargeLbl: UILabel!
    @IBOutlet weak var addressLbl: UILabel!
    @IBOutlet weak var paidViaLbl: UILabel!
    @IBOutlet weak var mobileNoLbl: UILabel!
    @IBOutlet weak var grandTotalLbl: UILabel!
    @IBOutlet weak var orderIDLbl: UILabel!
    @IBOutlet weak var deliveredOrderStatus: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    //VAriable
    var dictDataItems : UserOrderModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.setDetail()
    }
    
    func setDetail() {
            
        self.orderIDLbl.text = dictDataItems.id
        self.deliveredOrderStatus.text = dictDataItems.orderStatus
        self.totalItemLbl.text = "\(dictDataItems.orderProducts!.count)"
        self.couponDiscountLbl.text = dictDataItems.couponAmount
        self.taxLbl.text = dictDataItems.tax
        self.deliveryAddLbl.text = dictDataItems.shippingCharges
        self.grandTotalLbl.text = dictDataItems.grandTotal
        self.paidViaLbl.text = dictDataItems.paymentMethod
        self.mobileNoLbl.text = dictDataItems.mobile
        self.addressLbl.text = dictDataItems.areaName ?? ""
        self.tableView.reloadData()
    }
    
    @IBAction func clickBackBtn(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
      //  self.dismiss(animated: true, completion: nil)
    }
}
//MARK: -
extension SummaryViewController:UITableViewDelegate, UITableViewDataSource {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dictDataItems.orderProducts!.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SummaryTableViewCell") as! SummaryTableViewCell
        
        let data = self.dictDataItems.orderProducts![indexPath.row]
        cell.itemNameLbl.text! = data.productName!
        cell.itemPriceLbl.text! = "₹\(data.productPrice!)"
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
}
