//
//  CheckoutModel.swift
//  ProtiensApp
//
//  Created by mehtab alam on 18/01/2021.
//

import Foundation

struct CheckoutModel : Codable {
    let userCarts : [UserCarts]?
    let paymentNames : [PaymentNames]?
    let subtotal_amount : Int?
    let coupon_discount : Int?
    let shippingCharges : String?
    let tax : Int?
    let grand_total : Int
    let defaultAddress : DefaultAddress?
    let timeslots : [Timeslot]?

    enum CodingKeys: String, CodingKey {

        case userCarts = "userCarts"
        case paymentNames = "paymentNames"
        case subtotal_amount = "subtotal_amount"
        case coupon_discount = "coupon_discount"
        case shippingCharges = "shippingCharges"
        case tax = "tax"
        case grand_total = "grand_total"
        case defaultAddress = "defaultAddress"
        case timeslots = "timeslots"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        userCarts = try values.decodeIfPresent([UserCarts].self, forKey: .userCarts)
        paymentNames = try values.decodeIfPresent([PaymentNames].self, forKey: .paymentNames)
        subtotal_amount = try values.decodeIfPresent(Int.self, forKey: .subtotal_amount)
        coupon_discount = try values.decodeIfPresent(Int.self, forKey: .coupon_discount)
        do {
            shippingCharges = try values.decodeIfPresent(String.self, forKey: .shippingCharges)
        } catch {
            do {
                shippingCharges = String(try values.decodeIfPresent(Int.self, forKey: .shippingCharges)!)
            } catch {
                shippingCharges = String(try values.decodeIfPresent(Double.self, forKey: .shippingCharges)!)
            }
        }
        
        tax = try values.decodeIfPresent(Int.self, forKey: .tax)
        grand_total = try values.decodeIfPresent(Int.self, forKey: .grand_total) ?? 0
        defaultAddress = try values.decodeIfPresent(DefaultAddress.self, forKey: .defaultAddress)
        timeslots = try values.decodeIfPresent([Timeslot].self, forKey: .timeslots)
    }

}


struct UserCarts : Codable {
    let id : String?
    let product_id : String?
    let product_attribute_id : String?
    let product_name : String?
    let product_code : String?
    let weight : String?
    let price : String?
    let quantity : String?
    let qty1 : String?
    let user_email : String?
    let mobile_session_id : String?
    let session_id : String?
    let image : String?
    let total_amount : String?
    let mobile : String?
    let created_at : String?
    let updated_at : String?
    let stock : String!
    enum CodingKeys: String, CodingKey {

        case id = "id"
        case product_id = "product_id"
        case product_attribute_id = "product_attribute_id"
        case product_name = "product_name"
        case product_code = "product_code"
        case weight = "weight"
        case price = "price"
        case quantity = "quantity"
        case qty1 = "qty1"
        case user_email = "user_email"
        case mobile_session_id = "mobile_session_id"
        case session_id = "session_id"
        case image = "image"
        case total_amount = "total_amount"
        case mobile = "mobile"
        case created_at = "created_at"
        case updated_at = "updated_at"
        case stock = "stock"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(String.self, forKey: .id)
        product_id = try values.decodeIfPresent(String.self, forKey: .product_id)
        product_attribute_id = try values.decodeIfPresent(String.self, forKey: .product_attribute_id)
        product_name = try values.decodeIfPresent(String.self, forKey: .product_name)
        product_code = try values.decodeIfPresent(String.self, forKey: .product_code)
        weight = try values.decodeIfPresent(String.self, forKey: .weight)
        price = try values.decodeIfPresent(String.self, forKey: .price)
        quantity = try values.decodeIfPresent(String.self, forKey: .quantity)
        qty1 = try values.decodeIfPresent(String.self, forKey: .qty1)
        user_email = try values.decodeIfPresent(String.self, forKey: .user_email)
        mobile_session_id = try values.decodeIfPresent(String.self, forKey: .mobile_session_id)
        session_id = try values.decodeIfPresent(String.self, forKey: .session_id)
        image = try values.decodeIfPresent(String.self, forKey: .image)
        total_amount = try values.decodeIfPresent(String.self, forKey: .total_amount)
        mobile = try values.decodeIfPresent(String.self, forKey: .mobile)
        created_at = try values.decodeIfPresent(String.self, forKey: .created_at)
        updated_at = try values.decodeIfPresent(String.self, forKey: .updated_at)
        stock = try values.decodeIfPresent(String.self, forKey: .stock)
    }

}
struct DefaultAddress : Codable {
    let id : String?
    let user_id : String?
    let user_email : String?
    let name : String?
    let address : String?
    let city : String?
    let area_id : String?
    let state : String?
    let country : String?
    let pincode : String?
    let mobile : String?
    let type : String?
    let flat_number : String?
    let state_name : String?
    let city_name : String?
    let area_name : String?
    let created_at : String?
    let updated_at : String?

    enum CodingKeys: String, CodingKey {

        case id = "id"
        case user_id = "user_id"
        case user_email = "user_email"
        case name = "name"
        case address = "address"
        case city = "city"
        case area_id = "area_id"
        case state = "state"
        case country = "country"
        case pincode = "pincode"
        case mobile = "mobile"
        case type = "type"
        case flat_number = "flat_number"
        case state_name = "state_name"
        case city_name = "city_name"
        case area_name = "area_name"
        case created_at = "created_at"
        case updated_at = "updated_at"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(String.self, forKey: .id)
        user_id = try values.decodeIfPresent(String.self, forKey: .user_id)
        user_email = try values.decodeIfPresent(String.self, forKey: .user_email)
        name = try values.decodeIfPresent(String.self, forKey: .name)
        address = try values.decodeIfPresent(String.self, forKey: .address)
        city = try values.decodeIfPresent(String.self, forKey: .city)
        area_id = try values.decodeIfPresent(String.self, forKey: .area_id)
        state = try values.decodeIfPresent(String.self, forKey: .state)
        country = try values.decodeIfPresent(String.self, forKey: .country)
        pincode = try values.decodeIfPresent(String.self, forKey: .pincode)
        mobile = try values.decodeIfPresent(String.self, forKey: .mobile)
        type = try values.decodeIfPresent(String.self, forKey: .type)
        flat_number = try values.decodeIfPresent(String.self, forKey: .flat_number)
        state_name = try values.decodeIfPresent(String.self, forKey: .state_name)
        city_name = try values.decodeIfPresent(String.self, forKey: .city_name)
        area_name = try values.decodeIfPresent(String.self, forKey: .area_name)
        created_at = try values.decodeIfPresent(String.self, forKey: .created_at)
        updated_at = try values.decodeIfPresent(String.self, forKey: .updated_at)
    }

}
struct PaymentNames : Codable {
    let id : String?
    let name : String?
    let status : String?
    let created_at : String?
    let updated_at : String?

    enum CodingKeys: String, CodingKey {

        case id = "id"
        case name = "name"
        case status = "status"
        case created_at = "created_at"
        case updated_at = "updated_at"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(String.self, forKey: .id)
        name = try values.decodeIfPresent(String.self, forKey: .name)
        status = try values.decodeIfPresent(String.self, forKey: .status)
        created_at = try values.decodeIfPresent(String.self, forKey: .created_at)
        updated_at = try values.decodeIfPresent(String.self, forKey: .updated_at)
    }
}
struct Timeslot : Codable {

    let dayName : String?
    let endTime : String?
    let slotName : String?
    let startTime : String?


    enum CodingKeys: String, CodingKey {
        case dayName = "day_name"
        case endTime = "end_time"
        case slotName = "slot_name"
        case startTime = "start_time"
    }
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        dayName = try values.decodeIfPresent(String.self, forKey: .dayName)
        endTime = try values.decodeIfPresent(String.self, forKey: .endTime)
        slotName = try values.decodeIfPresent(String.self, forKey: .slotName)
        startTime = try values.decodeIfPresent(String.self, forKey: .startTime)
    }
}
