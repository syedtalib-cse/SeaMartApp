//
//  OrderSuccessFullCODViewController.swift
//  SeaMartApp
//
//  Created by mehtab alam on 13/02/2021.
//

import UIKit

class OrderSuccessFullCODViewController: UIViewController {

    @IBOutlet weak var orderLbl: UILabel!
    @IBOutlet weak var amountLbl: UILabel!
    
    //VAriable
    var orderID = String()
    var totalAmount = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.orderLbl.text! = "#\(orderID)"
        self.amountLbl.text! = totalAmount
    }
    

    @IBAction func homeBtn(_ sender: Any) {
      //  self.navigationController?.popToRootViewController(animated: true)
        let VC = self.storyboard?.instantiateViewController(withIdentifier: "MainViewController") as! MainViewController
        self.navigationController?.pushViewController(VC, animated: true)
    }

}
