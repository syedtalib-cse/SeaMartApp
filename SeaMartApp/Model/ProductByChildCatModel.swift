//
//  ProductByChildCatModel.swift
//  ProtiensApp
//
//  Created by mehtab alam on 24/12/2020.
//

import Foundation

struct ProductsByChildModel : Codable {
    let productsByChildCategory : [ProductsByChildCategory]?

    enum CodingKeys: String, CodingKey {

        case productsByChildCategory = "productsByChildCategory"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        productsByChildCategory = try values.decodeIfPresent([ProductsByChildCategory].self, forKey: .productsByChildCategory)
    }
}

struct ProductsByChildCategory : Codable {
    let id : String?
    let category_id : String?
    let parent_category_id : String?
    let child_category_id : String?
    let parent_category_name : String?
    let child_category_name : String?
    let product_name : String?
    let product_slug : String?
    let product_code : String?
    let description : String?
    let mrp_price : String?
    let discount : String?
    let price : String?
    let weight : String?
    let gross_weight : String?
    let net_weight : String?
    let image : String?
    let deal_product : String?
    let dealof_day : String?
    let dealof_date : String?
    let trending_product : String?
    let status : String?
    let city_id : String?
    let area_id : String?
    let pincode : String?
    let stock : String?
    let created_at : String?
    let updated_at : String?

    enum CodingKeys: String, CodingKey {

        case id = "id"
        case category_id = "category_id"
        case parent_category_id = "parent_category_id"
        case child_category_id = "child_category_id"
        case parent_category_name = "parent_category_name"
        case child_category_name = "child_category_name"
        case product_name = "product_name"
        case product_slug = "product_slug"
        case product_code = "product_code"
        case description = "description"
        case mrp_price = "mrp_price"
        case discount = "discount"
        case price = "price"
        case weight = "weight"
        case gross_weight = "gross_weight"
        case net_weight = "net_weight"
        case image = "image"
        case deal_product = "deal_product"
        case dealof_day = "dealof_day"
        case dealof_date = "dealof_date"
        case trending_product = "trending_product"
        case status = "status"
        case city_id = "city_id"
        case area_id = "area_id"
        case pincode = "pincode"
        case stock = "stock"
        case created_at = "created_at"
        case updated_at = "updated_at"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(String.self, forKey: .id)
        category_id = try values.decodeIfPresent(String.self, forKey: .category_id)
        parent_category_id = try values.decodeIfPresent(String.self, forKey: .parent_category_id)
        child_category_id = try values.decodeIfPresent(String.self, forKey: .child_category_id)
        parent_category_name = try values.decodeIfPresent(String.self, forKey: .parent_category_name)
        child_category_name = try values.decodeIfPresent(String.self, forKey: .child_category_name)
        product_name = try values.decodeIfPresent(String.self, forKey: .product_name)
        product_slug = try values.decodeIfPresent(String.self, forKey: .product_slug)
        product_code = try values.decodeIfPresent(String.self, forKey: .product_code)
        description = try values.decodeIfPresent(String.self, forKey: .description)
        mrp_price = try values.decodeIfPresent(String.self, forKey: .mrp_price)
        discount = try values.decodeIfPresent(String.self, forKey: .discount)
        price = try values.decodeIfPresent(String.self, forKey: .price)
        weight = try values.decodeIfPresent(String.self, forKey: .weight)
        gross_weight = try values.decodeIfPresent(String.self, forKey: .gross_weight)
        net_weight = try values.decodeIfPresent(String.self, forKey: .net_weight)
        image = try values.decodeIfPresent(String.self, forKey: .image)
        deal_product = try values.decodeIfPresent(String.self, forKey: .deal_product)
        dealof_day = try values.decodeIfPresent(String.self, forKey: .dealof_day)
        dealof_date = try values.decodeIfPresent(String.self, forKey: .dealof_date)
        trending_product = try values.decodeIfPresent(String.self, forKey: .trending_product)
        status = try values.decodeIfPresent(String.self, forKey: .status)
        city_id = try values.decodeIfPresent(String.self, forKey: .city_id)
        area_id = try values.decodeIfPresent(String.self, forKey: .area_id)
        pincode = try values.decodeIfPresent(String.self, forKey: .pincode)
        stock = try values.decodeIfPresent(String.self, forKey: .stock)
        created_at = try values.decodeIfPresent(String.self, forKey: .created_at)
        updated_at = try values.decodeIfPresent(String.self, forKey: .updated_at)
    }

}

