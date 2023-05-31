//
//  ProductBySubCatModel.swift
//  ProtiensApp
//
//  Created by mehtab alam on 24/12/2020.
//

import Foundation

struct SubCatModel : Codable {
    let subcat_names : [Subcat_names]?

    enum CodingKeys: String, CodingKey {

        case subcat_names = "subcat_names"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        subcat_names = try values.decodeIfPresent([Subcat_names].self, forKey: .subcat_names)
    }

}

struct Subcat_names : Codable {
    var isSelected : Bool
    let name : String?
    var id : String?
    enum CodingKeys: String, CodingKey {
        case isSelected = "isSelected"
        case name = "name"
        case id = "id"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        name = try values.decodeIfPresent(String.self, forKey: .name)
        id = try values.decodeIfPresent(String.self, forKey: .id)
        isSelected = try values.decodeIfPresent(Bool.self, forKey: .isSelected) ?? false
    }
}
