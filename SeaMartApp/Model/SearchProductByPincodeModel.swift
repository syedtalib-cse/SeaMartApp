//
//  SearchProductByPincodeModel.swift
//  ProtiensApp
//
//  Created by mehtab alam on 25/01/2021.
//

import Foundation

struct ModelSearchPincode : Codable {

    let areaName : String?
    let cityName : String?
    let pincode : String?
    let productsbypincode : [Productsbypincode]?


    enum CodingKeys: String, CodingKey {
        case areaName = "area_name"
        case cityName = "city_name"
        case pincode = "pincode"
        case productsbypincode = "productsbypincode"
    }
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        areaName = try values.decodeIfPresent(String.self, forKey: .areaName)
        cityName = try values.decodeIfPresent(String.self, forKey: .cityName)
        pincode = try values.decodeIfPresent(String.self, forKey: .pincode)
        productsbypincode = try values.decodeIfPresent([Productsbypincode].self, forKey: .productsbypincode)
    }
}
struct Productsbypincode : Codable {

    let areaId : String?
    let categoryId : String?
    let childCategoryId : String?
    let childCategoryName : String?
    let cityId : String?
    let createdAt : String?
    let dealProduct : String?
    let dealofDate : String?
    let dealofDay : String?
    let descriptionField : String?
    let discount : String?
    let grossWeight : String?
    let id : String?
    let image : String?
    let mrpPrice : String?
    let netWeight : String?
    let parentCategoryId : String?
    let parentCategoryName : String?
    let pincode : String?
    let price : String?
    let productCode : String?
    let productName : String?
    let productSlug : String?
    let status : String?
    let stock : String?
    let trendingProduct : String?
    let updatedAt : String?
    let weight : String?


    enum CodingKeys: String, CodingKey {
        case areaId = "area_id"
        case categoryId = "category_id"
        case childCategoryId = "child_category_id"
        case childCategoryName = "child_category_name"
        case cityId = "city_id"
        case createdAt = "created_at"
        case dealProduct = "deal_product"
        case dealofDate = "dealof_date"
        case dealofDay = "dealof_day"
        case descriptionField = "description"
        case discount = "discount"
        case grossWeight = "gross_weight"
        case id = "id"
        case image = "image"
        case mrpPrice = "mrp_price"
        case netWeight = "net_weight"
        case parentCategoryId = "parent_category_id"
        case parentCategoryName = "parent_category_name"
        case pincode = "pincode"
        case price = "price"
        case productCode = "product_code"
        case productName = "product_name"
        case productSlug = "product_slug"
        case status = "status"
        case stock = "stock"
        case trendingProduct = "trending_product"
        case updatedAt = "updated_at"
        case weight = "weight"
    }
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        areaId = try values.decodeIfPresent(String.self, forKey: .areaId)
        categoryId = try values.decodeIfPresent(String.self, forKey: .categoryId)
        childCategoryId = try values.decodeIfPresent(String.self, forKey: .childCategoryId)
        childCategoryName = try values.decodeIfPresent(String.self, forKey: .childCategoryName)
        cityId = try values.decodeIfPresent(String.self, forKey: .cityId)
        createdAt = try values.decodeIfPresent(String.self, forKey: .createdAt)
        dealProduct = try values.decodeIfPresent(String.self, forKey: .dealProduct)
        dealofDate = try values.decodeIfPresent(String.self, forKey: .dealofDate)
        dealofDay = try values.decodeIfPresent(String.self, forKey: .dealofDay)
        descriptionField = try values.decodeIfPresent(String.self, forKey: .descriptionField)
        discount = try values.decodeIfPresent(String.self, forKey: .discount)
        grossWeight = try values.decodeIfPresent(String.self, forKey: .grossWeight)
        id = try values.decodeIfPresent(String.self, forKey: .id)
        image = try values.decodeIfPresent(String.self, forKey: .image)
        mrpPrice = try values.decodeIfPresent(String.self, forKey: .mrpPrice)
        netWeight = try values.decodeIfPresent(String.self, forKey: .netWeight)
        parentCategoryId = try values.decodeIfPresent(String.self, forKey: .parentCategoryId)
        parentCategoryName = try values.decodeIfPresent(String.self, forKey: .parentCategoryName)
        pincode = try values.decodeIfPresent(String.self, forKey: .pincode)
        price = try values.decodeIfPresent(String.self, forKey: .price)
        productCode = try values.decodeIfPresent(String.self, forKey: .productCode)
        productName = try values.decodeIfPresent(String.self, forKey: .productName)
        productSlug = try values.decodeIfPresent(String.self, forKey: .productSlug)
        status = try values.decodeIfPresent(String.self, forKey: .status)
        stock = try values.decodeIfPresent(String.self, forKey: .stock)
        trendingProduct = try values.decodeIfPresent(String.self, forKey: .trendingProduct)
        updatedAt = try values.decodeIfPresent(String.self, forKey: .updatedAt)
        weight = try values.decodeIfPresent(String.self, forKey: .weight)
    }


}

