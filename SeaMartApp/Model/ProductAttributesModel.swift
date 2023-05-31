//
//  ProductAttributesModel.swift
//  ProtiensApp
//
//  Created by mehtab alam on 21/12/2020.
//

import Foundation

//struct ProductAttributeAllDetails : Codable {
//    let productAttributeDetails : [ProductAttributeDetail]?
//
//
//        enum CodingKeys: String, CodingKey {
//            case productAttributeDetails = "productAttributeDetails"
//        }
//        init(from decoder: Decoder) throws {
//            let values = try decoder.container(keyedBy: CodingKeys.self)
//            productAttributeDetails = try values.decodeIfPresent([ProductAttributeDetail].self, forKey: .productAttributeDetails)
//        }
//}
//
//struct ProductAttributeDetail : Codable {
//
//    let areaId : String?
//    let cityId : String?
//    let createdAt : String?
//    let discount : String?
//    let grossWeight : String?
//    let id : String?
//    let image : String?
//    let mrpPrice : String?
//    let netWeight : String?
//    let pincode : String?
//    let price : String?
//    let productId : String?
//    let productName : String?
//    let productSlug : String?
//    let stock : String?
//    let storeLocationId : String?
//    let updatedAt : String?
//    let weight : String?
//    var isAddtoCart: Bool
//
//
//    enum CodingKeys: String, CodingKey {
//        case areaId = "area_id"
//        case cityId = "city_id"
//        case createdAt = "created_at"
//        case discount = "discount"
//        case grossWeight = "gross_weight"
//        case id = "id"
//        case image = "image"
//        case mrpPrice = "mrp_price"
//        case netWeight = "net_weight"
//        case pincode = "pincode"
//        case price = "price"
//        case productId = "product_id"
//        case productName = "product_name"
//        case productSlug = "product_slug"
//        case stock = "stock"
//        case storeLocationId = "store_location_id"
//        case updatedAt = "updated_at"
//        case weight = "weight"
//        case isAddtoCart = "isAddtoCart"
//    }
//    init(from decoder: Decoder) throws {
//        let values = try decoder.container(keyedBy: CodingKeys.self)
//        areaId = try values.decodeIfPresent(String.self, forKey: .areaId)
//        cityId = try values.decodeIfPresent(String.self, forKey: .cityId)
//        createdAt = try values.decodeIfPresent(String.self, forKey: .createdAt)
//        discount = try values.decodeIfPresent(String.self, forKey: .discount)
//        grossWeight = try values.decodeIfPresent(String.self, forKey: .grossWeight)
//        id = try values.decodeIfPresent(String.self, forKey: .id)
//        image = try values.decodeIfPresent(String.self, forKey: .image)
//        mrpPrice = try values.decodeIfPresent(String.self, forKey: .mrpPrice)
//        netWeight = try values.decodeIfPresent(String.self, forKey: .netWeight)
//        pincode = try values.decodeIfPresent(String.self, forKey: .pincode)
//        price = try values.decodeIfPresent(String.self, forKey: .price)
//        productId = try values.decodeIfPresent(String.self, forKey: .productId)
//        productName = try values.decodeIfPresent(String.self, forKey: .productName)
//        productSlug = try values.decodeIfPresent(String.self, forKey: .productSlug)
//        stock = try values.decodeIfPresent(String.self, forKey: .stock)
//        storeLocationId = try values.decodeIfPresent(String.self, forKey: .storeLocationId)
//        updatedAt = try values.decodeIfPresent(String.self, forKey: .updatedAt)
//        weight = try values.decodeIfPresent(String.self, forKey: .weight)
//        isAddtoCart = try values.decodeIfPresent(Bool.self, forKey: .isAddtoCart) ?? false
//    }
//
//
//}
//

struct ProductAttributeAllDetails : Codable {

    let productAttributeDetails : [ProductAttributeDetails]?


    enum CodingKeys: String, CodingKey {
        case productAttributeDetails = "productAttributeDetails"
    }
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        productAttributeDetails = try values.decodeIfPresent([ProductAttributeDetails].self, forKey: .productAttributeDetails)
    }


}

struct ProductAttributeDetails : Codable {

    let areaId : String?
    let cityId : String?
    let createdAt : String?
    let discount : String?
    let grossWeight : String?
    let id : String?
    let image : String?
    let mrpPrice : String?
    let netWeight : String?
    let pincode : String?
    let price : [Price]?
    let productId : String?
    let productName : String?
    let productSlug : String?
    let stock : String?
    let storeLocationId : String?
    let updatedAt : String?
    let weight : String?
    var isAddtoCart: Bool?
    let productAttributeId : String?
//    var productCount: Int


    enum CodingKeys: String, CodingKey {
        case areaId = "area_id"
        case cityId = "city_id"
        case createdAt = "created_at"
        case discount = "discount"
        case grossWeight = "gross_weight"
        case id = "id"
        case image = "image"
        case mrpPrice = "mrp_price"
        case netWeight = "net_weight"
        case pincode = "pincode"
        case price = "price"
        case productId = "product_id"
        case productName = "product_name"
        case productSlug = "product_slug"
        case stock = "stock"
        case storeLocationId = "store_location_id"
        case updatedAt = "updated_at"
        case weight = "weight"
        case isAddtoCart = "isAddtoCart"
        case productAttributeId = "product_attribute_id"
//        case productCount = "productCount"
    }
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        areaId = try values.decodeIfPresent(String.self, forKey: .areaId)
        cityId = try values.decodeIfPresent(String.self, forKey: .cityId)
        createdAt = try values.decodeIfPresent(String.self, forKey: .createdAt)
        discount = try values.decodeIfPresent(String.self, forKey: .discount)
        grossWeight = try values.decodeIfPresent(String.self, forKey: .grossWeight)
        id = try values.decodeIfPresent(String.self, forKey: .id)
        image = try values.decodeIfPresent(String.self, forKey: .image)
        mrpPrice = try values.decodeIfPresent(String.self, forKey: .mrpPrice)
        netWeight = try values.decodeIfPresent(String.self, forKey: .netWeight)
        pincode = try values.decodeIfPresent(String.self, forKey: .pincode)
        price = try values.decodeIfPresent([Price].self, forKey: .price)
        productId = try values.decodeIfPresent(String.self, forKey: .productId)
        productName = try values.decodeIfPresent(String.self, forKey: .productName)
        productSlug = try values.decodeIfPresent(String.self, forKey: .productSlug)
        stock = try values.decodeIfPresent(String.self, forKey: .stock)
        storeLocationId = try values.decodeIfPresent(String.self, forKey: .storeLocationId)
        updatedAt = try values.decodeIfPresent(String.self, forKey: .updatedAt)
        weight = try values.decodeIfPresent(String.self, forKey: .weight)
        isAddtoCart = try values.decodeIfPresent(Bool.self, forKey: .isAddtoCart)
        productAttributeId = try values.decodeIfPresent(String.self, forKey: .productAttributeId)
//        productCount = try values.decodeIfPresent(Int.self, forKey: .productCount) ?? 0
    }


}
struct Price : Codable {

    let mrpPrice : String?
    let pincode : String?
    let price : String?


    enum CodingKeys: String, CodingKey {
        case mrpPrice = "mrp_price"
        case pincode = "pincode"
        case price = "price"
    }
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        mrpPrice = try values.decodeIfPresent(String.self, forKey: .mrpPrice)
        pincode = try values.decodeIfPresent(String.self, forKey: .pincode)
        price = try values.decodeIfPresent(String.self, forKey: .price)
    }

}
