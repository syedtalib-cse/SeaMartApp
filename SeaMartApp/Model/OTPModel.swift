//
//  OTPModel.swift
//  ProtiensApp
//
//  Created by mehtab alam on 22/12/2020.
//

import Foundation
struct OTPModel : Codable {
    let status : String?

    enum CodingKeys: String, CodingKey {

        case status = "status"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        status = try values.decodeIfPresent(String.self, forKey: .status)
    }

}
