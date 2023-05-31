//
//  ApplyCouponModel.swift
//  ProtiensApp
//
//  Created by mehtab alam on 23/01/2021.
//

import Foundation
struct ApplyCouponModel : Codable {
    let status : String?
    let totalAmount : Int?
    let couponAmount : String?
    let couponCode : String?
    let couponDiscount : Int?

    enum CodingKeys: String, CodingKey {

        case status = "status"
        case totalAmount = "totalAmount"
        case couponAmount = "CouponAmount"
        case couponCode = "CouponCode"
        case couponDiscount = "CouponDiscount"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        status = try values.decodeIfPresent(String.self, forKey: .status)
        totalAmount = try values.decodeIfPresent(Int.self, forKey: .totalAmount)
        couponAmount = try values.decodeIfPresent(String.self, forKey: .couponAmount)
        couponCode = try values.decodeIfPresent(String.self, forKey: .couponCode)
        couponDiscount = try values.decodeIfPresent(Int.self, forKey: .couponDiscount)
    }

}
