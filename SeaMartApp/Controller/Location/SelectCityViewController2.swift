//
//  SelectCityViewController2.swift
//  SeaMartApp
//
//  Created by mehtab alam on 19/02/2021.
//

import UIKit
import CoreLocation
class SelectCityViewController2: UIViewController,CLLocationManagerDelegate {
    var pincode:String!
    var city:String!
    var login:Bool?
    var status1:String!
    var isFromHome = Bool()
    override func viewDidLoad() {
        super.viewDidLoad()
        //        print(status1!,"fff")
    }
}
//MARK:- Action event
extension SelectCityViewController2 {
    
    @IBAction func clickHyderabadBtn(_ sender: Any) {
        let viewVC = self.storyboard?.instantiateViewController(withIdentifier: "SelectYourLocationViewController") as! SelectYourLocationViewController
        viewVC.status2 = status1
        viewVC.isFromHome = self.isFromHome
        self.navigationController?.pushViewController(viewVC, animated: true)
    }
    
    @IBAction func clickVijyewadaBtn(_ sender: Any) {
        let viewVC = self.storyboard?.instantiateViewController(withIdentifier: "SelectYourLocationViewController") as! SelectYourLocationViewController
        //        viewVC.isFromLocation = true
        //        viewVC.pincode = self.pincode
        viewVC.isFromHome = self.isFromHome
        self.navigationController?.pushViewController(viewVC, animated: true)
    }
    
    @IBAction func clickOnBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
}
