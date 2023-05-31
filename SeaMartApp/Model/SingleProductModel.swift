//
//  SingleProductModel.swift
//  ProtiensApp
//
//  Created by mehtab alam on 21/12/2020.
//
import Foundation
struct singleProductAllDetail : Codable {
    let singleProductDetail : SingleProductDetail?

    enum CodingKeys: String, CodingKey {

        case singleProductDetail = "singleProductDetail"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        singleProductDetail = try values.decodeIfPresent(SingleProductDetail.self, forKey: .singleProductDetail)
    }

}
struct SingleProductDetail : Codable {
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
    let image : String?
    let dealof_day : String?
    let dealof_date : String?
    let trending_product : String?
    let status : String?
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
        case image = "image"
        case dealof_day = "dealof_day"
        case dealof_date = "dealof_date"
        case trending_product = "trending_product"
        case status = "status"
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
        image = try values.decodeIfPresent(String.self, forKey: .image)
        dealof_day = try values.decodeIfPresent(String.self, forKey: .dealof_day)
        dealof_date = try values.decodeIfPresent(String.self, forKey: .dealof_date)
        trending_product = try values.decodeIfPresent(String.self, forKey: .trending_product)
        status = try values.decodeIfPresent(String.self, forKey: .status)
        created_at = try values.decodeIfPresent(String.self, forKey: .created_at)
        updated_at = try values.decodeIfPresent(String.self, forKey: .updated_at)
    }
}


//struct singleProductAllDetail : Codable {
//
//    let singleProductAttributeDetail : SingleProductAttributeDetail?
//
//
//    enum CodingKeys: String, CodingKey {
//        case singleProductAttributeDetail
//    }
//    init(from decoder: Decoder) throws {
//        let values = try decoder.container(keyedBy: CodingKeys.self)
//        singleProductAttributeDetail = try SingleProductAttributeDetail(from: decoder)
//    }
//
//
//}
//
//
//struct SingleProductAttributeDetail : Codable {
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
//    }
//}
