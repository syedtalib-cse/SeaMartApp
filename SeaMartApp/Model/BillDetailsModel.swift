//
//  BillDetailsModel.swift
//  ProtiensApp
//
//  Created by mehtab alam on 23/01/2021.
//

import Foundation

struct BillDetailsModel : Codable {
    let subtotal_amount : Int?
    let shippingCharges : String?
    let coupon_discount : Int?
    let tax : Int?
    let grand_total : Int?
    let defaultAddress : DefaultsAddress?

    enum CodingKeys: String, CodingKey {

        case subtotal_amount = "subtotal_amount"
        case shippingCharges = "shippingCharges"
        case coupon_discount = "coupon_discount"
        case tax = "tax"
        case grand_total = "grand_total"
        case defaultAddress = "defaultAddress"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        subtotal_amount = try values.decodeIfPresent(Int.self, forKey: .subtotal_amount)
        do {
            shippingCharges = try values.decodeIfPresent(String.self, forKey: .shippingCharges)
        } catch {
            do {
                shippingCharges = String(try values.decodeIfPresent(Int.self, forKey: .shippingCharges)!)
            }catch {
                shippingCharges = String(try values.decodeIfPresent(Double.self, forKey: .shippingCharges)!)
            }
        }
        coupon_discount = try values.decodeIfPresent(Int.self, forKey: .coupon_discount)
        tax = try values.decodeIfPresent(Int.self, forKey: .tax)
        grand_total = try values.decodeIfPresent(Int.self, forKey: .grand_total)
        defaultAddress = try values.decodeIfPresent(DefaultsAddress.self, forKey: .defaultAddress)
    }

}


struct DefaultsAddress : Codable {
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
