//
//  AddToCartTableViewCell.swift
//  ProtiensApp
//
//  Created by mehtab alam on 07/01/2021.
//

import UIKit

class AddToCartTableViewCell: UITableViewCell {
    
    //MARK:- OUTLET
    @IBOutlet weak var productNameLbl: UILabel!
    @IBOutlet weak var wightLbl: UILabel!
    @IBOutlet weak var priceLbl: UILabel!
    @IBOutlet weak var stackViewPlusMinus: UIStackView!
    @IBOutlet weak var cartImage: UIImageView!
    
    //MARK:- Variable
    var delegate: AlertDelegate?
    var quantity:String! = ""
    var wightData:Double! = 0.0
    var countData: Int = 0
    var kgChickenPrice:Double!
    var cartChickenPrice:((Double) ->())?
    var itemCount:((Int) ->())?
    var clickedButton:((Double) ->())?
    var currentSelection: Int!
    var previousSelection: Int!
    var noOfItems: Int = 0
    var newData: String!
    var totoalStock : String!
    var addCartObj: NewStatus!
    
    //MARK:- Variable
    var productID:String!
    var productAttributedID:String!
    var productName:String!
    var productWight:String!
    var productImage:String!
    var productPrice:String!
    var productQuantity:String!
    var userPhone:String!
    var userEmail:String!
    var isAlreadyExist = Bool()
    var cartID:String!
    private var serviceInstance = Service()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        userEmail = singleton.shared.getFromDefault(Key: DefaultKeys.email) as? String
        userPhone = singleton.shared.getFromDefault(Key: DefaultKeys.mobile) as? String
       // userID = singleton.shared.getFromDefault(Key: DefaultKeys.userId) as? String
    }
    @IBAction func clickMinusBtn(_ sender: Any) {
        
        wightData -=  Double(newData)!
        if wightData < Double(newData)! {
            //Make wight value 00 if decrease the value in minus
            wightData = 0.0
            //delete item if wight value is 0 than delete from cart
            deleteCartPostData()
        } else {
            if wightData >= Double(newData)! {
                //if wieght is more than one or selected wieght (update cart)
                UpdateCartPostData()
            } else {
                //if wieght is equal to 0 than delete from cart
                deleteCartPostData()
            }
        }
        wightLbl.text = String(wightData)
    }
}
//MARK: Action Events
extension AddToCartTableViewCell {
    @IBAction func clickPlusBtn(_ sender: Any) {
        
        //remove this line when stock will add into the checkout API
        if self.totoalStock == nil {
            return
        }
        if wightData >= Double(self.totoalStock)! {
            //if wight value is more than stock do nothing
            return
        }
        //newData is default value from server it will increase on pluse button click as given from server
        wightData +=  Double(newData)!
        if wightData > Double(newData)! {
            //if wieght is more than one or selected wieght (update cart)
            UpdateCartPostData()
        } else {
            if self.isAlreadyExist{
                //if wieght is more than one or selected wieght (update cart)
                UpdateCartPostData()
            } else {
                //if wieght is 0 than add to cart
                addToCartPostData()
            }
        }
        wightLbl.text = String(wightData) //wightData - 1
        
    }
}

//MARK: API CALL
extension AddToCartTableViewCell {
    
    func addToCartPostData(){
        let service = SeaMartURL.addToCartURL
        serviceInstance.postRequest(url: service, dataDictionary: [
            "product_id" : productID,
            "product_attribute_id": productAttributedID,
            "product_name":productName,
            "weight":newData,
            "image":productImage,
            "price":productPrice,
            "quantity": "\(wightData!)",
            "phone":userPhone,
            "user_email":userEmail
        ], decodingType: AddToCartModel.self) { [weak self] (result) in
            switch result {
            case .success(let data):
                guard let addCartProduct = data.status else {return}
                self?.addCartObj = addCartProduct
                self?.cartID = "\(self!.addCartObj.cart_id!)"
                print(self!.addCartObj!,"addCartObj")
                print(self!.cartID!,"CartId")
                if self?.addCartObj.status?.lowercased() == "true" {
                    DispatchQueue.main.async {
                        self!.wightData = 0.0
                        self!.wightLbl.text = String(self!.wightData) //wightData - 1
                        self!.cartChickenPrice!((self!.wightData*self!.kgChickenPrice)) //wightData - 1
                        self!.isAlreadyExist = true
                        //   self!.delegate!.showAlert()
                    }
                } else {
                    self!.isAlreadyExist = false
                }
                self!.delegate!.updateCheckOutList()
            case .failure(let error):
                print(error.localizedDescription)
                
            }
        }
    }
    func deleteCartPostData(){
        let service = SeaMartURL.deleteToCartURL
        guard let cartid = cartID else {return}
        print(cartid,"cartid")
        serviceInstance.postRequest(url: service, dataDictionary: ["cart_id":cartid], decodingType: [DeleteToCartModel].self) { (result) in
            switch result {
            case .success(let data):
                guard let deleteProduct = data[0].status else {return}
                print(deleteProduct,"deleteProduct")
                // self?.singleObject = singleProduct
                self.delegate!.updateCheckOutList()
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func UpdateCartPostData(){
        let service = SeaMartURL.updateCartProductQuantityURL
        guard let cartid = cartID else {return}
        print(cartid,"cartid")
        serviceInstance.postRequest(url: service, dataDictionary: ["cart_id":cartid,"product_attribute_id":productAttributedID,"qty": "\(wightData!)","phone":userPhone], decodingType: UpdateCartModel.self) { (result) in
            switch result {
            case .success(let data):
                guard let updateProduct = data.status else {return}
                print(updateProduct,"updateProduct")
                self.delegate!.updateCheckOutList()
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
