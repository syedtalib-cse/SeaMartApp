//
//  DeliveryLocationViewController.swift
//  SeaMartApp
//
//  Created by mehtab alam on 13/02/2021.
//

import UIKit
import DLRadioButton
import SCLAlertView
class DeliveryLocationViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var buttonOutlet: UIButton!
    
    private var serviceInstance = Service()
    var changeAddressObj = [Delivery_address]()
    var userID:String?
    var addressID:String?
    var sendData:((String) ->())?
    public var selectedRadioButton: Int?
    var billDetail:BillDetailsModel!
    var couponCode:String!
    var selectedIndex:IndexPath?
    var selection:Int!
    var selectedType = Bool()
    var dataArray = ["1","2","3","4","5"]
    var arrayBooleans: [Bool] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        userID = singleton.shared.getFromDefault(Key: DefaultKeys.userId) as? String
        changeAddressPostData()
        
        //Remove empty cell
        self.tableView.tableFooterView = UIView()
        // After receiving data from server
        for _ in dataArray {
            arrayBooleans.append(false)
        }
    }
    override func viewDidAppear(_ animated: Bool) {
        if changeAddressObj.count == 0 {
            self.tableView.reloadData()
            buttonOutlet.setTitle("Add Address", for: .normal)
        } else {
            buttonOutlet.setTitle("Make Payment", for: .normal)
        }
    }
}
//MARK:- Action Event
extension DeliveryLocationViewController {
    
    @IBAction func clickMakePaymentBtn(_ sender: Any) {
        
        if changeAddressObj.count == 0 {
            buttonOutlet.setTitle("Add Address", for: .normal)
            let VC = self.storyboard?.instantiateViewController(withIdentifier: "AddNewAddressViewController") as! AddNewAddressViewController
            VC.callBackForAddAddress = { Void in
                self.changeAddressPostData()
            }
            self.navigationController?.pushViewController(VC, animated: true)
        }
        else {
            buttonOutlet.setTitle("Make Payment", for: .normal)
            let CVC = self.storyboard?.instantiateViewController(withIdentifier: "CheckoutViewController") as! CheckoutViewController
           // self.addressID = nil
            if addressID == nil {
                SCLAlertView().showError("Alert", subTitle: "Plese Select address.")
            } else {
                CVC.addressID = addressID
                CVC.billDetail = self.billDetail
                CVC.couponCode = "\(self.billDetail.coupon_discount!)"
                self.navigationController?.pushViewController(CVC, animated: true)
            }
            //            let indexPath = IndexPath.init(row: (sender as AnyObject).tag, section: 0)
            //            let cell = self.tableView.cellForRow(at: indexPath) as! DeliveryLocationTableViewCell
            //            if cell.radioBtn.backgroundColor == .white {
            //                self.alertView(Title: "Aleart", messg: "")
            //            }
            
        }
    }
    @IBAction func clickBackBtn(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
}

//MARK:- API Call
extension DeliveryLocationViewController {
    
    func changeAddressPostData() {
        serviceInstance.postRequest(url: SeaMartURL.getChangeAddressURL, dataDictionary: ["user_id": userID!], decodingType: GetChangeAddressModel.self) { [weak self] (result) in
            // print("\(result)")
            switch result {
            case .success(let data):
                let changeAddress = data.delivery_address
                self?.changeAddressObj = changeAddress!
                print("changeAddressObj\(String(describing: self?.changeAddressObj))")
                DispatchQueue.main.async {
                    self?.tableView.reloadData()
                }
                
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func getManageAddressPostData() {
        serviceInstance.postRequest(url: SeaMartURL.getChangeAddressURL, dataDictionary: ["user_id":userID!], decodingType: GetChangeAddressModel.self) { [weak self] (result) in
            switch result {
            case .success(let data):
                let changeAddress = data.delivery_address
                self?.changeAddressObj = changeAddress!
                print("changeAddressObj\(String(describing: self?.changeAddressObj))")
                DispatchQueue.main.async {
                    self?.tableView.reloadData()
                }
            //  print(self!.userObject!, "userObject")
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func deleteAddressPostData(id:String) {
        serviceInstance.postRequest(url: SeaMartURL.deleteAddressURL, dataDictionary: ["da_id":id], decodingType: GetChangeAddressModel.self) { [weak self] (result) in
            switch result {
            case .success(_):
                
                DispatchQueue.main.async {
                    self!.getManageAddressPostData()
                }
            //  print(self!.userObject!, "userObject")
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}

//MARK:- TableView delegate datasource method
extension DeliveryLocationViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if changeAddressObj.count == 0 {
            //  self.tableView.reloadData()
            buttonOutlet.setTitle("Add Address", for: .normal)
        }
        return changeAddressObj.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCell(withIdentifier: "DeliveryLocationTableViewCell") as! DeliveryLocationTableViewCell
        
        cell.addressLbl.text = "\(changeAddressObj[indexPath.row].name!),\(changeAddressObj[indexPath.row].address!), \(changeAddressObj[indexPath.row].flat_number!),\(changeAddressObj[indexPath.row].area_name ?? "no area"),\(changeAddressObj[indexPath.row].city_name ?? "no City"),\(changeAddressObj[indexPath.row].state_name ?? "no State"),\(changeAddressObj[indexPath.row].pincode!)"
        
        cell.removeOutlet.tag = indexPath.row
        cell.removeOutlet.addTarget(self, action: #selector(deleteaddress(_:))  , for: .touchUpInside)
        cell.editOutlet.tag = indexPath.row
        cell.editOutlet.addTarget(self, action: #selector(editaddress(_:))  , for: .touchUpInside)
        
        let data = changeAddressObj[indexPath.row]
        if data.type == "1" {
            cell.workLbl.text = "HOME"
        } else if data.type == "2" {
            cell.workLbl.text = "WORK"
        } else {
            cell.workLbl.text = "OTHERS"
        }
        cell.radioView.layer.cornerRadius = cell.radioView.frame.size.width/2
        cell.radioView.layer.borderWidth = 1.0
        cell.radioBtn.layer.cornerRadius = cell.radioBtn.frame.size.width/2
        if arrayBooleans[indexPath.row] == true {
            cell.radioBtn.backgroundColor = .red
        } else {
            cell.radioBtn.backgroundColor = .white
        }
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        addressID = changeAddressObj[indexPath.row].id
        print(addressID!,"addressID")
        
        // did select tableview cell
        if arrayBooleans[indexPath.row] == true {
            arrayBooleans.remove(at: indexPath.row)
            arrayBooleans.insert(false, at: indexPath.row) // 0 means at indexpath.row
        } else {
            arrayBooleans.remove(at: indexPath.row)
            arrayBooleans.insert(true, at: indexPath.row) // 0 means at indexpath.row
        }
        self.tableView.reloadData()
    }
    
    @objc func deleteaddress(_ sender:UIButton) {
        self.deleteAddressPostData(id: changeAddressObj[sender.tag].id!)
    }
    @objc func editaddress(_ sender:UIButton) {
        let viewVC = self.storyboard?.instantiateViewController(withIdentifier: "AddNewAddressViewController") as! AddNewAddressViewController
        viewVC.dictDataItems = self.changeAddressObj[sender.tag]
        viewVC.isFromEdit = true
        viewVC.callBackForEditAddress = { Void in
            DispatchQueue.main.async {
                self.getManageAddressPostData()
            }
        }
        self.navigationController?.pushViewController(viewVC, animated: true)
    }
}
