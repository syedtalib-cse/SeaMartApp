//
//  SelectCityViewController.swift
//  SeaMartApp
//
//  Created by mehtab alam on 04/02/2021.
//

import UIKit

class SelectCityViewController: UIViewController {
    
    private var serviceInstance = Service()
    var pincode = String()
    var status1:String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func clickHyderabadBtn(_ sender: Any) {
        let viewVC = self.storyboard?.instantiateViewController(withIdentifier: "SelectYourLocationViewController") as! SelectYourLocationViewController
//        viewVC.isFromLocation = true
//        viewVC.pincode = self.pincode
        self.navigationController?.pushViewController(viewVC, animated: true)
    }
    
    @IBAction func clickVijyewadaBtn(_ sender: Any) {
        let viewVC = self.storyboard?.instantiateViewController(withIdentifier: "SelectYourLocationViewController") as! SelectYourLocationViewController
//        viewVC.isFromLocation = true
//        viewVC.pincode = self.pincode
        self.navigationController?.pushViewController(viewVC, animated: true)
    }

    @IBAction func clickOnBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
}
