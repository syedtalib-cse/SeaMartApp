//
//  AddNewAddressModel.swift
//  ProtiensApp
//
//  Created by mehtab alam on 08/01/2021.
//

import Foundation
struct AddNewAddressModel : Codable {
    let status : String?
    
    enum CodingKeys: String, CodingKey {
        case status = "status"
    }
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        status = try values.decodeIfPresent(String.self, forKey: .status)
    }
    
}

//struct AddNewAddressModel : Codable {
//    let user_id : String?
//    let user_email : String?
//    let name : String?
//    let address : String?
//    let city : String?
//    let area_id : String?
//    let state : String?
//    let country : String?
//    let pincode : String?
//    let mobile : String?
//    let type : String?
//    let flat_number : String?
//
//    enum CodingKeys: String, CodingKey {
//
//        case user_id = "user_id"
//        case user_email = "user_email"
//        case name = "name"
//        case address = "address"
//        case city = "city"
//        case area_id = "area_id"
//        case state = "state"
//        case country = "country"
//        case pincode = "pincode"
//        case mobile = "mobile"
//        case type = "type"
//        case flat_number = "flat_number"
//    }
//
//    init(from decoder: Decoder) throws {
//        let values = try decoder.container(keyedBy: CodingKeys.self)
//        user_id = try values.decodeIfPresent(String.self, forKey: .user_id)
//        user_email = try values.decodeIfPresent(String.self, forKey: .user_email)
//        name = try values.decodeIfPresent(String.self, forKey: .name)
//        address = try values.decodeIfPresent(String.self, forKey: .address)
//        city = try values.decodeIfPresent(String.self, forKey: .city)
//        area_id = try values.decodeIfPresent(String.self, forKey: .area_id)
//        state = try values.decodeIfPresent(String.self, forKey: .state)
//        country = try values.decodeIfPresent(String.self, forKey: .country)
//        pincode = try values.decodeIfPresent(String.self, forKey: .pincode)
//        mobile = try values.decodeIfPresent(String.self, forKey: .mobile)
//        type = try values.decodeIfPresent(String.self, forKey: .type)
//        flat_number = try values.decodeIfPresent(String.self, forKey: .flat_number)
//    }
//
//}
