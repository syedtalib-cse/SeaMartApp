//
//  PersonalDetailModel.swift
//  ProtiensApp
//
//  Created by mehtab alam on 09/01/2021.
//

import Foundation
struct PersonalDetailsModel : Codable {
    let status : String?
    
    enum CodingKeys: String, CodingKey {
        case status = "status"
    }
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        status = try values.decodeIfPresent(String.self, forKey: .status)
    }
    
}
