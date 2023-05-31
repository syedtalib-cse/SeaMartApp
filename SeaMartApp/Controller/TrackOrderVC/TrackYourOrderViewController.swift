//
//  TrackYourOrderViewController.swift
//  ProtiensApp
//
//  Created by mehtab alam on 26/01/2021.
//

import UIKit

class TrackYourOrderViewController: UIViewController {
    
    @IBOutlet weak var trackTableView: UITableView!
    private var serviceInstance = Service()
    
    var userEmail:String!
    var arrNewItems = [UserOrderModel]()
    var arrOtherItems = [UserOrderModel]()
    var selection:Int!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.trackTableView.tableFooterView = UIView()
        userEmail = singleton.shared.getFromDefault(Key: DefaultKeys.email) as? String
        print(userEmail!,"userEmail")
        self.trackOrderPostData()
    }
    
    @IBAction func clickBackBtn(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
}

// MARK:- API Call
extension TrackYourOrderViewController {
    func trackOrderPostData(){
        let service = SeaMartURL.userOrderURL
        serviceInstance.postRequest(url: service, dataDictionary: ["user_email":"\(userEmail ?? "")"], decodingType: [UserOrderModel].self) { (result) in
            switch result {
            case .success(let data):
                let arrNewItem = data.filter {
                    $0.orderStatus?.lowercased() == "new"
                }
                let arrOtherItem = data.filter {
                    $0.orderStatus?.lowercased() != "new"
                }
                self.arrNewItems.removeAll()
                self.arrOtherItems.removeAll()
                for value in arrNewItem {
                    self.arrNewItems.append(value)
                }
                for value in arrOtherItem {
                    self.arrOtherItems.append(value)
                }
                
                DispatchQueue.main.async {
                    self.trackTableView.reloadData()
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}

// MARK:- Tableview delegate datasource
extension TrackYourOrderViewController: UITableViewDataSource,UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0 {
            return 0
        } else {
            return 60
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: tableView.frame.size.width, height: 60))
        
        let lbl = UILabel()
        lbl.frame = CGRect.init(x: 10, y: 10, width: headerView.frame.size.width-20, height: 40)
        lbl.backgroundColor = UIColor(hexString: "#C41210")
        lbl.textColor = .white
        lbl.textAlignment = .center
        lbl.text = "PREVIOUS ORDERS"
        headerView.addSubview(lbl)
        
        return headerView
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            if arrNewItems.count == 0 {
                trackTableView.isHidden = true
            } else {
                trackTableView.isHidden = false
                
                return self.arrNewItems.count
            }
            return self.arrNewItems.count
        } else {
            return self.arrOtherItems.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TrackTableViewCell", for: indexPath) as! TrackTableViewCell
        
        let data : UserOrderModel!
        if indexPath.section == 0 {
            data = self.arrNewItems[indexPath.row]
            cell.trackBtn.setTitle("Track", for: .normal)
        } else {
            data = self.arrOtherItems[indexPath.row]
            cell.trackBtn.setTitle("Reorder", for: .normal)
        }
        selection = indexPath.section
        cell.orderNoLbl.text! = "#\(data.id!)"
        cell.deliveryAddLbl.text! = data.areaName ?? ""
        cell.viewOne.isHidden = true
        cell.viewTwo.isHidden = true
        cell.itemNameLbl.text = ""
        cell.itemPriceLbl.text! = ""
        if data.orderProducts!.count == 1 {
            let value = data.orderProducts![0]
            cell.itemNameLbl.text = "\(value.productName ?? "") \(value.productWeight ?? "")Kg"
            cell.itemPriceLbl.text! = "₹\(value.productPrice ?? "")"
            cell.viewOne.isHidden = false
            cell.viewTwo.isHidden = true
        }
        if data.orderProducts!.count > 1 {
            cell.viewOne.isHidden = false
            cell.viewTwo.isHidden = false
            let value = data.orderProducts![0]
            cell.itemNameLbl.text = "₹\(value.productName ?? "") \(value.productWeight ?? "")Kg"
            cell.itemPriceLbl.text! = "\(value.productPrice ?? "")"
            
            let value1 = data.orderProducts![1]
            
            cell.itemNameOneLbl.text = "₹\(value1.productName ?? "") \(value1.productWeight ?? "")Kg"
            cell.itemPriceOneLbl.text! = "\(value1.productPrice ?? "")"
        }
        cell.trackBtn.addTarget(self, action: #selector(trackOrder), for: .touchUpInside)
        cell.trackBtn.tag = indexPath.row
        cell.trackBtn.superview?.tag = indexPath.section
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    @objc func trackOrder(_ sender:UIButton) {
        
        let section = sender.superview?.tag ?? 0
        
        let arr : UserOrderModel!
        if section == 0 {
            arr = self.arrNewItems[sender.tag]
        } else {
            arr = self.arrOtherItems[sender.tag]
        }
        let viewVC = self.storyboard?.instantiateViewController(withIdentifier: "SummaryViewController") as! SummaryViewController
        viewVC.dictDataItems = arr
        self.navigationController?.pushViewController(viewVC, animated: true)
    }
}
