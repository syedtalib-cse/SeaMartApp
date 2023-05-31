//
//  UpdateUserModel.swift
//  SeaMartApp
//
//  Created by mehtab alam on 11/02/2021.
//

import Foundation

struct UpdateUserModel : Codable {
    let status : String?
    
    enum CodingKeys: String, CodingKey {
        case status = "status"
    }
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        status = try values.decodeIfPresent(String.self, forKey: .status)
    }
}
