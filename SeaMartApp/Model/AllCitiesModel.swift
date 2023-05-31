//
//  AllCitiesModel.swift
//  ProtiensApp
//
//  Created by mehtab alam on 25/01/2021.
//

import Foundation

struct FetchCityModel : Codable {

    let cities : [Citys]?


    enum CodingKeys: String, CodingKey {
        case cities = "cities"
    }
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        cities = try values.decodeIfPresent([Citys].self, forKey: .cities)
    }
}
struct Citys : Codable {

    let cityName : String?
    let id : String?


    enum CodingKeys: String, CodingKey {
        case cityName = "city_name"
        case id = "id"
    }
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        cityName = try values.decodeIfPresent(String.self, forKey: .cityName)
        id = try values.decodeIfPresent(String.self, forKey: .id)
    }
}
