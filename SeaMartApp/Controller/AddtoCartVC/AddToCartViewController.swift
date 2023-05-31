//
//  AddToCartViewController.swift
//  SeaMartApp
//
//  Created by mehtab alam on 13/02/2021.
//

import UIKit

class AddToCartViewController: UIViewController, AlertDelegate {
    
    @IBOutlet weak var lblTotalPrice: UILabel!
    @IBOutlet weak var lblCoupanDiscount: UILabel!
    @IBOutlet weak var lblDeliveryCharge: UILabel!
    @IBOutlet weak var lblTax: UILabel!
    @IBOutlet weak var lblTotalToPay: UILabel!
    @IBOutlet weak var deliveryLbl: UILabel!
    @IBOutlet weak var txtApplyCoupan: UITextField!
    @IBOutlet weak var numberOfItemLbl: UILabel!
    @IBOutlet weak var placeOrderBtn: UIButton!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var applyCouponBtn: UIButton!
    
    //MARK:- Instance created for service API
    private var serviceInstance = Service()
    var userCartObj:[UserCarts] = [UserCarts]()
    var callBackUpdateItem:((String) ->())?
    var userPhone:String!
    var userEmail:String!
    var userID:String!
    var billDetail:BillDetailsModel!
    //  var changeAddressObj:Delivery_address?
    var changeAddressObj = [Delivery_address]()
    
    //MARK:- UI components for showing Messege view
    private let messageView: OSOMessageView = {
        let view = OSOMessageView(showCancelButton: false, addBlurBackground: true)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.getBillDetail()

        showActivityIndicator(messageView:messageView)
        
        //Remove empty cell
        self.tableView.tableFooterView = UIView()
        
        userEmail = singleton.shared.getFromDefault(Key: DefaultKeys.email) as? String
        userPhone = singleton.shared.getFromDefault(Key: DefaultKeys.mobile) as? String
        userID = singleton.shared.getFromDefault(Key: DefaultKeys.userId) as? String
        print(userEmail!,"email")
        print(userPhone!,"phone")
        print(userID!,"id")
        self.applyCouponBtn.setTitle("Apply", for: .normal)
        self.txtApplyCoupan.isUserInteractionEnabled = true
    }
}
//MARK:- Event Handler
extension AddToCartViewController {
    @IBAction func clickPlaceApplyCoupan(_ sender: Any) {
        if !self.txtApplyCoupan.text!.isEmpty {
            if self.applyCouponBtn.titleLabel?.text! == "Apply" {
                self.applyCoupan()
            } else {
                self.txtApplyCoupan.text! = ""
                self.getBillDetail()
                if self.applyCouponBtn.titleLabel?.text! == "Remove" {
                    self.applyCouponBtn.setTitle("Apply", for: .normal)
                    self.txtApplyCoupan.isUserInteractionEnabled = true
                }
            }
        } else {
            //Show alert
        }
    }
    
    @IBAction func clickPlaceOrderBtn(_ sender: Any) {
        let VC = self.storyboard?.instantiateViewController(withIdentifier: "DeliveryLocationViewController") as! DeliveryLocationViewController
        VC.billDetail = self.billDetail
        VC.couponCode = self.txtApplyCoupan.text!
        self.navigationController?.pushViewController(VC, animated: true)
    }
    
    @IBAction func clickBackBtn(_ sender: UIButton) {
        let VC = self.storyboard?.instantiateViewController(withIdentifier: "MainViewController") as! MainViewController
        self.navigationController?.pushViewController(VC, animated: true)
    }
}
//MARK:- API Call
extension AddToCartViewController {
    
    func UpdateCartPostData(){
        let service = SeaMartURL.getCheckoutURL
        serviceInstance.postRequest(url: service, dataDictionary: ["coupon_code":"test15","phone":userPhone,"user_email":userEmail,"user_id":userID], decodingType: CheckoutModel.self) { [weak self] (result) in
            switch result {
            case .success(let data):
                guard let userCart = data.userCarts else {return}
                //self?.userCartObj.append(contentsOf: userCart)
                print(self!.userCartObj,"userCartObj")
                self!.userCartObj = userCart
                
                DispatchQueue.main.async {
                    self?.messageView.isHidden = true
                    self?.messageView.animateActivityIndicator(animate: false)
                    self?.tableView.reloadData()
                }
            case .failure(let error):
                print(error.localizedDescription)
                self?.messageView.isHidden = false
                self?.messageView.animateActivityIndicator(animate: true)
            }
        }
    }
    
    func getBillDetail(){
        DispatchQueue.main.async {
            
            let service = SeaMartURL.getBillDetailsURL
            self.serviceInstance.postRequest(url: service, dataDictionary: ["coupon_code":self.txtApplyCoupan.text!,"phone":self.userPhone,"user_email":self.userEmail,"user_id":self.userID], decodingType: BillDetailsModel.self) { [weak self] (result) in
                switch result {
                case .success(let data):
                    self?.billDetail = data
                    // guard let addressData = data.defaultAddress?.address else {return}
                    DispatchQueue.main.async {
                        self?.messageView.isHidden = true
                        self?.messageView.animateActivityIndicator(animate: false)
                        self?.numberOfItemLbl.text! = "No of items : \(self!.userCartObj.count)"
                        self?.lblTotalPrice.text! = "\(data.subtotal_amount!)"
                        self?.lblCoupanDiscount.text! = "\(data.coupon_discount!)"
                        self?.lblDeliveryCharge.text! = "\(data.shippingCharges!)"
                        self?.lblTax.text! = "\(data.tax!)"
                        self?.lblTotalToPay.text! = "\(data.grand_total!)"
                        //  self?.deliveryLbl.text! = "\(addressData)"
                    }
                case .failure(let error):
                    print(error.localizedDescription)
                    self?.messageView.isHidden = false
                    self?.messageView.animateActivityIndicator(animate: true)
                }
            }
        }
    }
    
    func applyCoupan(){
        DispatchQueue.main.async { [self] in
            
            let service = SeaMartURL.getApplyCouponURL
            serviceInstance.postRequest(url: service, dataDictionary: ["coupon_code":self.txtApplyCoupan.text!,"phone":self.userPhone,"user_email":self.userEmail,"user_id":self.userID], decodingType: ApplyCouponModel.self) { [weak self] (result) in
                switch result {
                case .success(let data):
                    
                    if data.status!.lowercased() == "This coupon does not exists!".lowercased() {
                        DispatchQueue.main.async {
                            self?.alertView(Title: "Alert", messg: data.status!)
                        }
                        return
                    }
                    if data.status!.lowercased() == "Coupon code successfully applied. You are availing discount!".lowercased() {
                        DispatchQueue.main.async {
                            self!.txtApplyCoupan.text! = data.couponCode!
                            self!.applyCouponBtn.setTitle("Remove", for: .normal)
                            self!.txtApplyCoupan.isUserInteractionEnabled = false
                            self?.getBillDetail()
                        }
                    }
                case .failure(let error):
                    print(error.localizedDescription)
                    self!.txtApplyCoupan.isUserInteractionEnabled = true
                }
            }
        }
    }
    
    //Custom Delegate methods
    func showAlert(str: String) {
        
    }
    
    func updateCheckOutList() {
        self.UpdateCartPostData()
        self.getBillDetail()
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            self.callBackUpdateItem!("1")
        }
    }
}
//MARK:- Tableview delegate method
extension AddToCartViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // if table cell is empty then move to the privious controller
        if userCartObj.count == 0 {
            self.navigationController?.popToRootViewController(animated: true)
        } else {
            return userCartObj.count
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCell(withIdentifier: "AddToCartTableViewCell") as! AddToCartTableViewCell
        cell.delegate = self
        cell.productNameLbl.text = userCartObj[indexPath.row].product_name
        cell.wightLbl.text = userCartObj[indexPath.row].quantity
        cell.priceLbl.text = userCartObj[indexPath.row].price
        cell.quantity = userCartObj[indexPath.row].quantity
        cell.newData = userCartObj[indexPath.row].weight
        cell.wightData = Double(userCartObj[indexPath.row].quantity!)
        cell.cartID = userCartObj[indexPath.row].id
        cell.productAttributedID = userCartObj[indexPath.row].product_attribute_id
        cell.totoalStock = userCartObj[indexPath.row].stock
        let link = SeaMartURL.productImageURL
        let completeLink = link + userCartObj[indexPath.row].image!
        cell.cartImage.sd_setImage(with: URL(string: completeLink), placeholderImage: UIImage(named: "placeholder"))
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90
    }
}
