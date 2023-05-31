//
//  GetAllAreaModel.swift
//  ProtiensApp
//
//  Created by mehtab alam on 31/01/2021.
//

import Foundation

struct FetchAreaModel : Codable {

    let areaNames : [AreaName]?


    enum CodingKeys: String, CodingKey {
        case areaNames = "area_names"
    }
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        areaNames = try values.decodeIfPresent([AreaName].self, forKey: .areaNames)
    }


}
struct AreaName : Codable {

    let areaName : String?
    let id : String?


    enum CodingKeys: String, CodingKey {
        case areaName = "area_name"
        case id = "id"
    }
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        areaName = try values.decodeIfPresent(String.self, forKey: .areaName)
        id = try values.decodeIfPresent(String.self, forKey: .id)
    }


}
