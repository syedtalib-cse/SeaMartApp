//
//  PersonalUserModel.swift
//  ProtiensApp
//
//  Created by mehtab alam on 16/01/2021.
//

import Foundation

struct PersonalUserModel : Codable {
    let users : Users?

    enum CodingKeys: String, CodingKey {

        case users = "users"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        users = try values.decodeIfPresent(Users.self, forKey: .users)
    }

}

struct Users : Codable {
    let id : String?
    let name : String?
    let last_name : String?
    let address : String?
    let city : String?
    let state : String?
    let country : String?
    let pincode : String?
    let mobile : String?
    let otp : String?
    let is_user : String?
    let session_id : String?
    let mobile_verfied : String?
    let email : String?
    let password : String?
    let admin : String?
    let status : String?
    let image : String?
    let terms : String?
    let created_at : String?
    let updated_at : String?

    enum CodingKeys: String, CodingKey {

        case id = "id"
        case name = "name"
        case last_name = "last_name"
        case address = "address"
        case city = "city"
        case state = "state"
        case country = "country"
        case pincode = "pincode"
        case mobile = "mobile"
        case otp = "otp"
        case is_user = "is_user"
        case session_id = "session_id"
        case mobile_verfied = "mobile_verfied"
        case email = "email"
        case password = "password"
        case admin = "admin"
        case status = "status"
        case image = "image"
        case terms = "terms"
        case created_at = "created_at"
        case updated_at = "updated_at"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(String.self, forKey: .id)
        name = try values.decodeIfPresent(String.self, forKey: .name)
        last_name = try values.decodeIfPresent(String.self, forKey: .last_name)
        address = try values.decodeIfPresent(String.self, forKey: .address)
        city = try values.decodeIfPresent(String.self, forKey: .city)
        state = try values.decodeIfPresent(String.self, forKey: .state)
        country = try values.decodeIfPresent(String.self, forKey: .country)
        pincode = try values.decodeIfPresent(String.self, forKey: .pincode)
        mobile = try values.decodeIfPresent(String.self, forKey: .mobile)
        otp = try values.decodeIfPresent(String.self, forKey: .otp)
        is_user = try values.decodeIfPresent(String.self, forKey: .is_user)
        session_id = try values.decodeIfPresent(String.self, forKey: .session_id)
        mobile_verfied = try values.decodeIfPresent(String.self, forKey: .mobile_verfied)
        email = try values.decodeIfPresent(String.self, forKey: .email)
        password = try values.decodeIfPresent(String.self, forKey: .password)
        admin = try values.decodeIfPresent(String.self, forKey: .admin)
        status = try values.decodeIfPresent(String.self, forKey: .status)
        image = try values.decodeIfPresent(String.self, forKey: .image)
        terms = try values.decodeIfPresent(String.self, forKey: .terms)
        created_at = try values.decodeIfPresent(String.self, forKey: .created_at)
        updated_at = try values.decodeIfPresent(String.self, forKey: .updated_at)
    }

}

