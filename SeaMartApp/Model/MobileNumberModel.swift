//
//  MobileNumberModel.swift
//  ProtiensApp
//
//  Created by mehtab alam on 22/12/2020.
//

import Foundation

struct MobileNoModel: Codable {
    let status: Status?

    enum CodingKeys: String, CodingKey {
        case status = "status"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        status = try values.decodeIfPresent(Status.self, forKey: .status)
    }
}

struct Status: Codable {
    let mobile: String?
    let otp: Int?
    let session_id: String?
    let status: String?
    let user_id: String?
    let user_email: String?

    enum CodingKeys: String, CodingKey {

        case mobile = "mobile"
        case otp = "otp"
        case session_id = "session_id"
        case status = "status"
        case user_id = "user_id"
        case user_email = "user_email"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        mobile = try values.decodeIfPresent(String.self, forKey: .mobile)
        otp = try values.decodeIfPresent(Int.self, forKey: .otp)
        session_id = try values.decodeIfPresent(String.self, forKey: .session_id)
        status = try values.decodeIfPresent(String.self, forKey: .status)
        user_id = try values.decodeIfPresent(String.self, forKey: .user_id)
        user_email = try values.decodeIfPresent(String.self, forKey: .user_email)
    }

}

