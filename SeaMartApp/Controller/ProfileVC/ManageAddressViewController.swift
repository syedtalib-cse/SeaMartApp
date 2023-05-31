//
//  ManageAddressViewController.swift
//  ProtiensApp
//
//  Created by mehtab alam on 18/01/2021.
//

import UIKit

class ManageAddressViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    
    private var serviceInstance = Service()
    var changeAddressObj = [Delivery_address]()
    // private var userObject:Users?
    var userID:String?
    var buttonTitleCallBack:((_ buttonTitle: String) -> ())?
    public var selectedButton: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        userID = singleton.shared.getFromDefault(Key: DefaultKeys.userId) as? String
        
        //Remove empty cell
        self.tableView.tableFooterView = UIView()
        
    }
    override func viewDidAppear(_ animated: Bool) {
        print("viewDidAppear")
        getManageAddressPostData()
    }
}
//MARK:- Event Handler
extension ManageAddressViewController {
    @IBAction func clickBackBtn(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func tapToHomeBtn(_ sender: Any) {
        self.navigationController?.popToRootViewController(animated: true)
    }
}
//MARK:- API Call
extension ManageAddressViewController {
    
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

//MARK:- Tableview Delegate and datasource
extension ManageAddressViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return changeAddressObj.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCell(withIdentifier: "ManageAddressTableViewCell") as! ManageAddressTableViewCell
        
        cell.addressLbl.text = "\(changeAddressObj[indexPath.row].name!),\(changeAddressObj[indexPath.row].address!), \(changeAddressObj[indexPath.row].flat_number!),\(changeAddressObj[indexPath.row].area_name ?? "no area"),\(changeAddressObj[indexPath.row].city_name ?? "no City"),\(changeAddressObj[indexPath.row].state_name ?? "no State"),\(changeAddressObj[indexPath.row].pincode!)"
        
        cell.removeOutlet.tag = indexPath.row
        cell.removeOutlet.addTarget(self, action: #selector(deleteaddress(_:))  , for: .touchUpInside)
        cell.editOutlet.tag = indexPath.row
        cell.editOutlet.addTarget(self, action: #selector(editaddress(_:))  , for: .touchUpInside)
        let data = changeAddressObj[indexPath.row]
        if data.type == "1" {
            cell.homeLbl.text = "HOME"
        } else if data.type == "2" {
            cell.homeLbl.text = "WORK"
        } else {
            cell.homeLbl.text = "OTHERS"
        }
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
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
