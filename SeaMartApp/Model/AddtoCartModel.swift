//
//  AddtoCartModel.swift
//  ProtiensApp
//
//  Created by mehtab alam on 13/01/2021.
//

import Foundation

struct AddToCartModel : Codable {
    let status : NewStatus?

    enum CodingKeys: String, CodingKey {
        case status = "status"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        status = try values.decodeIfPresent(NewStatus.self, forKey: .status)
    }
}

struct NewStatus : Codable {
    let status : String?
    let cartData : CartData?
    let cart_id : Int?
    
    enum CodingKeys: String, CodingKey {
        
        case status = "status"
        case cartData = "cartData"
        case cart_id = "cart_id"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        status = try values.decodeIfPresent(String.self, forKey: .status)
        cartData = try values.decodeIfPresent(CartData.self, forKey: .cartData)
        cart_id = try values.decodeIfPresent(Int.self, forKey: .cart_id)
    }
    
}

struct CartData : Codable {
    let product_id : String?
    let price : String?
    let product_attribute_id : String?
    let quantity : String?
    let mobile : String?
    let mobile_session_id : String?
    let weight : String?
    let product_name : String?
    let image : String?
    let user_email : String?

    enum CodingKeys: String, CodingKey {

        case product_id = "product_id"
        case price = "price"
        case product_attribute_id = "product_attribute_id"
        case quantity = "quantity"
        case mobile = "mobile"
        case mobile_session_id = "mobile_session_id"
        case weight = "weight"
        case product_name = "product_name"
        case image = "image"
        case user_email = "user_email"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        product_id = try values.decodeIfPresent(String.self, forKey: .product_id)
        price = try values.decodeIfPresent(String.self, forKey: .price)
        product_attribute_id = try values.decodeIfPresent(String.self, forKey: .product_attribute_id)
        quantity = try values.decodeIfPresent(String.self, forKey: .quantity)
        mobile = try values.decodeIfPresent(String.self, forKey: .mobile)
        mobile_session_id = try values.decodeIfPresent(String.self, forKey: .mobile_session_id)
        weight = try values.decodeIfPresent(String.self, forKey: .weight)
        product_name = try values.decodeIfPresent(String.self, forKey: .product_name)
        image = try values.decodeIfPresent(String.self, forKey: .image)
        user_email = try values.decodeIfPresent(String.self, forKey: .user_email)
    }

}
