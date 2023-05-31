//
//  BestDealDetailViewController.swift
//  SeaMartApp
//
//  Created by mehtab alam on 10/02/2021.
//

import UIKit

class BestDealDetailViewController: UIViewController {
    
    // MARK:- IBOutlet
    @IBOutlet weak var bestDealDeatailImg: UIImageView!
    @IBOutlet weak var productNameLbl: UILabel!
    @IBOutlet weak var productDiscriptionLbl: UILabel!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var addItemLbl: UILabel!
    @IBOutlet weak var priceIncreaseLbl: UILabel!
    @IBOutlet weak var basketPriceLbl: UILabel!
    @IBOutlet weak var basketView: UIView!
    
    //MARK:- Variable creation
    private var serviceInstance = Service()
    var isAlreadyExist = Bool()
    var singleProductID:String!
    var attributeProductID:String!
    var pincode = String()
    var wightData:Double! = 0.0
    var newData: String!
    var modelWieghtData = [ModelSetWieghtData]()
    
    //MARK:- UI components for showing Messege view
    private let messageView: OSOMessageView = {
        let view = OSOMessageView(showCancelButton: false, addBlurBackground: true)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    var userCartObj:[UserCarts] = [UserCarts]()
    
    var userPhone:String!
    var userEmail:String!
    var userID:String!
    
    var cellHeights = [IndexPath: CGFloat]()
    
    
    //MARK:- Object created for model class
    private var singleObject:SingleProductDetail?
    private var AttributesObject:[ProductAttributeDetails] = [ProductAttributeDetails]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // tableView?.rowHeight = UITableView.automaticDimension
        
        //initially hidding basket view
        //  basketView.isHidden = true
        
        // Printing the ID from where getting the data
        print("AttributedID:--\(attributeProductID!)")
        print("singleProductID:--\(singleProductID!)")
        
        // Api Function Call
        self.getSingleProductDetailByPostData(id : singleProductID)
        getAttributedProductDetailByPostData()
        
        bestDealDeatailImg.addShadowInImageView()
        bestDealDeatailImg.layer.cornerRadius = 20
        
        showActivityIndicator(messageView:messageView)
        
        userEmail = singleton.shared.getFromDefault(Key: DefaultKeys.email) as? String
        userPhone = singleton.shared.getFromDefault(Key: DefaultKeys.mobile) as? String
        userID = singleton.shared.getFromDefault(Key: DefaultKeys.userId) as? String
        
        UpdateCartPostData()
        
    }
}
//MARK:- Event Handler
extension BestDealDetailViewController {
    
    @IBAction func tapProfileBtn(_ sender: Any) {
        let VC = self.storyboard?.instantiateViewController(withIdentifier: "MyProfileViewController") as! MyProfileViewController
        self.navigationController?.pushViewController(VC, animated: true)
    }
    @IBAction func tapBasketBtn(_ sender: Any) {
        let viewVC = self.storyboard?.instantiateViewController(withIdentifier: "TrackYourOrderViewController") as! TrackYourOrderViewController
      //  viewVC.userCartObj = self.userCartObj
        self.navigationController?.pushViewController(viewVC, animated: true)
    }
    @IBAction func tapNotificationBtn(_ sender: Any) {
    }
    // Action for back button
    @IBAction func clickBackButton(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    // Action for go to AddToCartViewController
    @IBAction func goToBasketBtn(_ sender: Any) {
        
        let next = self.storyboard?.instantiateViewController(withIdentifier: "AddToCartViewController") as! AddToCartViewController
        next.userCartObj = self.userCartObj
        next.callBackUpdateItem = { value in
            // Api Function Call
            
            self.getSingleProductDetailByPostData(id : self.singleProductID)
            self.UpdateCartPostData()
        }
        self.navigationController?.pushViewController(next, animated: true)
    }
    @objc func tappedOnPlus(sender:UIButton) {
        let indexPath = IndexPath.init(row: sender.tag, section: 0)
        let cell = self.tableView.cellForRow(at: indexPath) as! BestDealDetailTableViewCell
        let  data = AttributesObject[sender.tag]
        //        basketView!()
        
        //        if wightData != self.modelWieghtData[sender.tag].wieght {
        wightData = self.modelWieghtData[sender.tag].wieght
        //        }
        
        if data.price!.count <= 0 {
            //if price is not available in pincode show error message
            self.showAlert(str: "1")
            return
        }
        if self.wightData >= Double(data.stock!)! {
            //if wight value is more than stock do nothing
            return
        }
        //newData is default value from server it will increase on pluse button click as given from server
        //  print("\(self.wightData)")
        self.wightData +=  Double(data.weight!)!
        //  print("\(self.wightData)")
        cell.bestWightLbl.text = String(wightData)
        
        
        var cartID = ""
        
        if wightData > Double(data.weight!)! {
            if self.userCartObj.count > 0{
                let arr = self.userCartObj.filter{
                    $0.product_attribute_id == data.id
                }
                if let id = arr[0].id {
                    cartID = id
                }
            }
            //if wieght is more than one or selected wieght (update cart)
            self.UpdateCartPostDataItem(cartId: cartID, productAttributedID: data.id!, wight: "\(self.wightData ?? 0.0)")
        } else {
            if self.isAlreadyExist{
                //if wieght is more than ondatae or selected wieght (update cart)
                if self.userCartObj.count > 0{
                    let arr = self.userCartObj.filter{
                        $0.product_attribute_id == data.id
                    }
                    if let id = arr[0].id {
                        cartID = id
                    }
                }
                self.UpdateCartPostDataItem(cartId: cartID, productAttributedID: data.id!, wight: "\(self.wightData ?? 0.0)")
            } else {
                //if wieght is 0 than add to cart
                addToCartPostData(data: data ,cell: cell, index: sender.tag)
            }
        }
        self.modelWieghtData[sender.tag].wieght = wightData
    }
    @objc func tappedOnMinus(sender:UIButton) {
        let indexPath = IndexPath.init(row: sender.tag, section: 0)
        let cell = self.tableView.cellForRow(at: indexPath) as! BestDealDetailTableViewCell
        let  data = AttributesObject[sender.tag]
        wightData = self.modelWieghtData[sender.tag].wieght
        if data.price!.count <= 0 {
            //if price is not available in pincode show error message
            self.showAlert(str: "1")
            return
        }
        //newData is default value from server it will decrease on pluse button click as given from server
        wightData -=  Double(data.weight!)!
        
        var cartID = ""
        if self.userCartObj.count > 0 {
            let arr = self.userCartObj.filter{
                $0.product_attribute_id == data.id
            }
            if let id = arr[0].id {
                cartID = id
            }
        }
        if wightData < Double(data.weight!)! {
            //Make wight value 00 if decrease the value in minus
            wightData = 0.0
            
            //delete item if wight value is 0 than delete from cart
            if !cartID.isEmpty {
                deleteCartPostData(cartId: cartID)
            } else {
                return
            }
        } else {
            if wightData >= Double(data.weight!)! {
                //if wieght is more than one or selected wieght (update cart)
                self.UpdateCartPostDataItem(cartId: cartID, productAttributedID: data.id!, wight: "\(self.wightData ?? 0.0)")
            } else {
                //if wieght is equal to 0 than delete from cart
                deleteCartPostData(cartId: cartID)
            }
        }
        print("\(self.modelWieghtData[sender.tag].wieght ?? 0.0)")
        print("\(self.modelWieghtData.count)")
        self.modelWieghtData[sender.tag].wieght = wightData
        print("\(self.modelWieghtData[sender.tag].wieght ?? 0.0)")
        print("\(self.modelWieghtData.count)")
        
        
    }
}

//MARK:- API Call
extension BestDealDetailViewController {
    
    func getSingleProductDetailByPostData(id: String) {
        let service = SeaMartURL.GetSingleProductDetailsURL
        serviceInstance.postRequest(url: service, dataDictionary: ["id":id], decodingType: singleProductAllDetail.self) { [weak self] (result) in
            switch result {
            case .success(let data):
                guard let singleProduct = data.singleProductDetail else {return}
                self?.singleObject = singleProduct
                DispatchQueue.main.async {
                    self?.messageView.isHidden = true
                    self?.messageView.animateActivityIndicator(animate: false)
                    
                    self!.productNameLbl.text = self!.singleObject?.product_name
                    self!.productDiscriptionLbl.text = self!.singleObject?.description
                    self!.priceIncreaseLbl.text = "₹\(self!.singleObject!.price!)"
                    let link = SeaMartURL.productImageURL
                    if self!.singleObject?.image != nil {
                        let completeLink = link+(((self!.singleObject?.image)!))
                        self!.bestDealDeatailImg.sd_setImage(with: URL(string: completeLink), placeholderImage: UIImage(named: "placeholder"))
                    }
                }
            case .failure(let error):
                print(error.localizedDescription)
                DispatchQueue.main.async {
                    self?.messageView.isHidden = false
                    self?.messageView.animateActivityIndicator(animate: true)
                }
            }
        }
    }
    
    func getAttributedProductDetailByPostData(){
        let service = SeaMartURL.GetAllProductsAttributeDetailsURL
        serviceInstance.postRequest(url: service, dataDictionary: ["product_id":attributeProductID,"pincode":self.pincode], decodingType: ProductAttributeAllDetails.self) { [weak self] (result) in
            switch result {
            case .success(let data):
                guard let attributedDetails = data.productAttributeDetails else {return}
                // self?.AttributesObject.append(contentsOf: attributedDetails)
                self!.AttributesObject = attributedDetails
//                var array = [String]()
//                for i in self!.AttributesObject {
//                    array.append((i.price?[0].pincode)!)
//                }
//                if array[0] == self!.pincode {
//                    self?.tableView.isHidden = false
//                } else {
//                    self?.tableView.isHidden = true
//                }
                //  print("AttributesObject--\(self!.AttributesObject)")
                for _ in 0...self!.AttributesObject.count {
                    if self!.AttributesObject.count >= self!.modelWieghtData.count {
                        self!.modelWieghtData.append(ModelSetWieghtData.init(wieght: 0.0))
                    }
                }
                DispatchQueue.main.async {
                    self?.messageView.isHidden = true
                    self?.messageView.animateActivityIndicator(animate: false)
                    self!.tableView.reloadData()
                }
            case .failure(let error):
                print(error.localizedDescription)
                DispatchQueue.main.async {
                    self?.messageView.isHidden = false
                    self?.messageView.animateActivityIndicator(animate: true)
                }
            }
        }
    }
    
    func UpdateCartPostData(){
        let service = SeaMartURL.getCheckoutURL
        serviceInstance.postRequest(url: service, dataDictionary: ["coupon_code":"","phone":userPhone,"user_email":userEmail,"user_id":userID], decodingType: CheckoutModel.self) { [weak self] (result) in
            switch result {
            case .success(let data):
                guard let userCart = data.userCarts else {return}
                //self?.userCartObj.append(contentsOf: userCart)
                //print(self!.userCartObj,"userCartObj")
                self!.userCartObj = userCart
                
                DispatchQueue.main.async {
                    self?.messageView.isHidden = true
                    self?.messageView.animateActivityIndicator(animate: false)
                    if data.userCarts!.count > 0 {
                        self?.basketView.isHidden = false
                    } else {
                        self?.basketView.isHidden = true
                    }
                    self!.addItemLbl.text = "Items: \(data.userCarts!.count)"
                    self!.basketPriceLbl.text = "\(data.subtotal_amount!)"  
                }
                self!.getAttributedProductDetailByPostData()
            case .failure(let error):
                print(error.localizedDescription)
                DispatchQueue.main.async {
                    self?.messageView.isHidden = false
                    self?.messageView.animateActivityIndicator(animate: true)
                }
            }
        }
    }
    func addToCartPostData(data:ProductAttributeDetails, cell: BestDealDetailTableViewCell, index:Int) {
        let service = SeaMartURL.addToCartURL
        
        var param = [String:String]()
        param = [
            "product_id" : data.productId!,
            "product_attribute_id": data.id!,
            "product_name":data.productName!,
            "weight": data.weight! , //newData,
            "image":data.image!,
            "price": data.price![0].price!,// productPrice[0].price!,
            "quantity": "\(self.wightData!)",
            "phone": userPhone,
            "user_email":userEmail
        ]
        print("Param -> \(param)")
        serviceInstance.postRequest(url: service, dataDictionary: param , decodingType: AddToCartModel.self) { [weak self] (result) in
            switch result {
            case .success(let data):
                guard let addCartProduct = data.status else {return}
                if addCartProduct.status?.lowercased() == "true" {
                    DispatchQueue.main.async {
                        self?.messageView.isHidden = true
                        self?.messageView.animateActivityIndicator(animate: false)
                        self!.wightData = 0.0
                        cell.bestWightLbl.text = String(self!.wightData) //wightData - 1
                        self?.modelWieghtData[index].wieght = 0.0
                        self!.isAlreadyExist = true
                        self!.showAlert(str: "0")
                    }
                } else {
                    self!.isAlreadyExist = false
                }
                self!.UpdateCartPostData()
            case .failure(let error):
                print(error.localizedDescription)
                DispatchQueue.main.async {
                    self?.messageView.isHidden = false
                    self?.messageView.animateActivityIndicator(animate: true)
                }
                
            }
        }
    }
    func deleteCartPostData(cartId: String){
        let service = SeaMartURL.deleteToCartURL
        
        serviceInstance.postRequest(url: service, dataDictionary: ["cart_id":cartId], decodingType: [DeleteToCartModel].self) { (result) in
            switch result {
            case .success(let data):
                DispatchQueue.main.async {
                    self.messageView.isHidden = true
                    self.messageView.animateActivityIndicator(animate: false)
                    guard let deleteProduct = data[0].status else {return}
                    print(deleteProduct,"deleteProduct")
                    // self?.singleObject = singleProduct
                    self.UpdateCartPostData()
                }
            // self.delegate!.updateCheckOutList()
            case .failure(let error):
                print(error.localizedDescription)
                DispatchQueue.main.async {
                    self.messageView.isHidden = false
                    self.messageView.animateActivityIndicator(animate: true)
                }
            }
        }
    }
    
    func UpdateCartPostDataItem(cartId: String, productAttributedID:String, wight:String){
        let service = SeaMartURL.updateCartProductQuantityURL
        
        var param = [String:String]()
        param = ["cart_id":cartId,"product_attribute_id":productAttributedID,"qty": "\(wight)"]
        print("param -> \(param)")
        serviceInstance.postRequest(url: service, dataDictionary: param, decodingType: UpdateCartModel.self) { (result) in
            switch result {
            case .success(let data):
                DispatchQueue.main.async {
                    self.messageView.isHidden = true
                    self.messageView.animateActivityIndicator(animate: false)
                    guard let updateProduct = data.status else {return}
                    print(updateProduct,"updateProduct")
                    // self.delegate!.updateCheckOutList()
                    self.UpdateCartPostData()
                }
            case .failure(let error):
                print(error.localizedDescription)
                DispatchQueue.main.async {
                    self.messageView.isHidden = false
                    self.messageView.animateActivityIndicator(animate: true)
                }
            }
        }
    }
    
}

// MARK:- Extention for tableview delegate and datasource
extension BestDealDetailViewController: UITableViewDelegate, UITableViewDataSource, AlertDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return AttributesObject.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "BestDealDetailTableViewCell") as! BestDealDetailTableViewCell
        
        var bestAttributedData = AttributesObject[indexPath.row]
        cell.configCellForBestDealDetail(data: bestAttributedData)
        
        // cell.addBtn.isHidden = bestAttributedData.isAddtoCart
//        cell.callBackForAddBtn = {
//            bestAttributedData.isAddtoCart = true
//            cell.addBtn.isHidden = true
//        }
        cell.delegate = self
        cell.bestWightLbl.text! = "\(self.modelWieghtData[indexPath.row].wieght ?? 0.0)"
        cell.plusOutletBtn.tag = indexPath.row
        cell.minusOutletBtn.tag = indexPath.row
        cell.plusOutletBtn.addTarget(self, action: #selector(tappedOnPlus(sender:)), for: .touchUpInside)
        cell.minusOutletBtn.addTarget(self, action: #selector(tappedOnMinus(sender:)), for: .touchUpInside)
        // self.tableView.clipsToBounds = true
        
        
        //checking if price is zero that means product not avaliable in this pincode so hidding the cell
//        if bestAttributedData.price![0].pincode ?? "" == pincode {
//            cell.configCellForBestDealDetail(data: bestAttributedData)
////            cell.isHidden = false
////            self.tableView.isHidden = false
//            //Remove empty cell
//          //  self.tableView.tableFooterView = UIView()
//        } else {
////            cell.isHidden = true
////            self.tableView.isHidden = true
//            self.tableView.tableFooterView = UIView()
//        }
        if cell.kgChickenPrice == 0 {
            cell.isHidden = true
          //  self.tableView.removeFromSuperview()
            self.tableView.isHidden = true
            //Remove empty cell
            self.tableView.tableFooterView = UIView()
        } else {
            cell.isHidden = false
            self.tableView.isHidden = false
            self.tableView.tableFooterView = UIView()
        }
        
        //Show/Hide Outofstock View
        if Double(AttributesObject[indexPath.row].stock!)! > 0 {
            cell.viewOutOfStock.isHidden = true
        } else {
            cell.viewOutOfStock.isHidden = false
        }
        
        cell.addShadowInView()
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 140
    }
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cellHeights[indexPath] = cell.frame.size.height
    }

    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return cellHeights[indexPath] ?? 140
    }
    
    //Custom Delegate From Cell
    func showAlert(str: String) {
        if str == "1" {
            alertView(Title: "Alert", messg: "item not available in this pincode")
        } else {
            alertView(Title: "Alert", messg: "Item already exist")
        }
    }
    
    func updateCheckOutList() {
        self.UpdateCartPostData()
    }
}
class ModelSetWieghtData {
    var wieght : Double!
    
    init(wieght: Double?) {
        self.wieght = wieght
    }
}
