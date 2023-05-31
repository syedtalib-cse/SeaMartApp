//
//  AllStatesModel.swift
//  ProtiensApp
//
//  Created by mehtab alam on 08/02/2021.
//

import Foundation

struct AllStatesModel : Codable {

    let states : [State]?


    enum CodingKeys: String, CodingKey {
        case states = "states"
    }
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        states = try values.decodeIfPresent([State].self, forKey: .states)
    }
}
struct State : Codable {

    let id : String?
    let stateName : String?


    enum CodingKeys: String, CodingKey {
        case id = "id"
        case stateName = "state_name"
    }
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(String.self, forKey: .id)
        stateName = try values.decodeIfPresent(String.self, forKey: .stateName)
    }
}
