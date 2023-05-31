//
//  UserOrderModel.swift
//  ProtiensApp
//
//  Created by mehtab alam on 27/01/2021.
//

import Foundation

struct UserOrderModel : Codable {

    let orderProducts : [OrderProduct]?
    let address : String?
    let area : String?
    let areaName : String?
    let city : String?
    let cityName : String?
    let country : String?
    let couponAmount : String?
    let couponCode : String?
    let createdAt : String?
    let deliveryTime : String?
    let grandTotal : String?
    let id : String?
    let mobile : String?
    let name : String?
    let orderDate : String?
    let orderStatus : String?
    let paymentDate : String?
    let paymentId : String?
    let paymentMethod : String?
    let paymentStatus : String?
    let pincode : String?
    let productId : String?
    let productImage : String?
    let productName : String?
    let razorpayOrderId : String?
    let razorpayPaymentId : String?
    let shippingCharges : String?
    let state : String?
    let stateName : String?
    let suggestion : String?
    let type : String?
    let updatedAt : String?
    let userEmail : String?
    let userId : String?
    let tax : String?


    enum CodingKeys: String, CodingKey {
        case orderProducts = "OrderProducts"
        case address = "address"
        case area = "area"
        case areaName = "area_name"
        case city = "city"
        case cityName = "city_name"
        case country = "country"
        case couponAmount = "coupon_amount"
        case couponCode = "coupon_code"
        case createdAt = "created_at"
        case deliveryTime = "delivery_time"
        case grandTotal = "grand_total"
        case id = "id"
        case mobile = "mobile"
        case name = "name"
        case orderDate = "order_date"
        case orderStatus = "order_status"
        case paymentDate = "payment_date"
        case paymentId = "payment_id"
        case paymentMethod = "payment_method"
        case paymentStatus = "payment_status"
        case pincode = "pincode"
        case productId = "product_id"
        case productImage = "product_image"
        case productName = "product_name"
        case razorpayOrderId = "razorpay_order_id"
        case razorpayPaymentId = "razorpay_payment_id"
        case shippingCharges = "shipping_charges"
        case state = "state"
        case stateName = "state_name"
        case suggestion = "suggestion"
        case type = "type"
        case updatedAt = "updated_at"
        case userEmail = "user_email"
        case userId = "user_id"
        case tax = "tax"
    }
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        orderProducts = try values.decodeIfPresent([OrderProduct].self, forKey: .orderProducts)
        address = try values.decodeIfPresent(String.self, forKey: .address)
        area = try values.decodeIfPresent(String.self, forKey: .area)
        areaName = try values.decodeIfPresent(String.self, forKey: .areaName)
        city = try values.decodeIfPresent(String.self, forKey: .city)
        cityName = try values.decodeIfPresent(String.self, forKey: .cityName)
        country = try values.decodeIfPresent(String.self, forKey: .country)
        couponAmount = try values.decodeIfPresent(String.self, forKey: .couponAmount)
        couponCode = try values.decodeIfPresent(String.self, forKey: .couponCode)
        createdAt = try values.decodeIfPresent(String.self, forKey: .createdAt)
        deliveryTime = try values.decodeIfPresent(String.self, forKey: .deliveryTime)
        grandTotal = try values.decodeIfPresent(String.self, forKey: .grandTotal)
        id = try values.decodeIfPresent(String.self, forKey: .id)
        mobile = try values.decodeIfPresent(String.self, forKey: .mobile)
        name = try values.decodeIfPresent(String.self, forKey: .name)
        orderDate = try values.decodeIfPresent(String.self, forKey: .orderDate)
        orderStatus = try values.decodeIfPresent(String.self, forKey: .orderStatus)
        paymentDate = try values.decodeIfPresent(String.self, forKey: .paymentDate)
        paymentId = try values.decodeIfPresent(String.self, forKey: .paymentId)
        paymentMethod = try values.decodeIfPresent(String.self, forKey: .paymentMethod)
        paymentStatus = try values.decodeIfPresent(String.self, forKey: .paymentStatus)
        pincode = try values.decodeIfPresent(String.self, forKey: .pincode)
        productId = try values.decodeIfPresent(String.self, forKey: .productId)
        productImage = try values.decodeIfPresent(String.self, forKey: .productImage)
        productName = try values.decodeIfPresent(String.self, forKey: .productName)
        razorpayOrderId = try values.decodeIfPresent(String.self, forKey: .razorpayOrderId)
        razorpayPaymentId = try values.decodeIfPresent(String.self, forKey: .razorpayPaymentId)
        shippingCharges = try values.decodeIfPresent(String.self, forKey: .shippingCharges)
        state = try values.decodeIfPresent(String.self, forKey: .state)
        stateName = try values.decodeIfPresent(String.self, forKey: .stateName)
        suggestion = try values.decodeIfPresent(String.self, forKey: .suggestion)
        type = try values.decodeIfPresent(String.self, forKey: .type)
        updatedAt = try values.decodeIfPresent(String.self, forKey: .updatedAt)
        userEmail = try values.decodeIfPresent(String.self, forKey: .userEmail)
        userId = try values.decodeIfPresent(String.self, forKey: .userId)
        tax = try values.decodeIfPresent(String.self, forKey: .tax)
    }


}

struct OrderProduct : Codable {

    let createdAt : String?
    let id : String?
    let image : String?
    let orderId : String?
    let orderStatus : String?
    let productAttributeId : String?
    let productCode : String?
    let productId : String?
    let productName : String?
    let productPrice : String?
    let productQty : String?
    let productWeight : String?
    let updatedAt : String?
    let userId : String?


    enum CodingKeys: String, CodingKey {
        case createdAt = "created_at"
        case id = "id"
        case image = "image"
        case orderId = "order_id"
        case orderStatus = "order_status"
        case productAttributeId = "product_attribute_id"
        case productCode = "product_code"
        case productId = "product_id"
        case productName = "product_name"
        case productPrice = "product_price"
        case productQty = "product_qty"
        case productWeight = "product_weight"
        case updatedAt = "updated_at"
        case userId = "user_id"
    }
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        createdAt = try values.decodeIfPresent(String.self, forKey: .createdAt)
        id = try values.decodeIfPresent(String.self, forKey: .id)
        image = try values.decodeIfPresent(String.self, forKey: .image)
        orderId = try values.decodeIfPresent(String.self, forKey: .orderId)
        orderStatus = try values.decodeIfPresent(String.self, forKey: .orderStatus)
        productAttributeId = try values.decodeIfPresent(String.self, forKey: .productAttributeId)
        productCode = try values.decodeIfPresent(String.self, forKey: .productCode)
        productId = try values.decodeIfPresent(String.self, forKey: .productId)
        productName = try values.decodeIfPresent(String.self, forKey: .productName)
        productPrice = try values.decodeIfPresent(String.self, forKey: .productPrice)
        productQty = try values.decodeIfPresent(String.self, forKey: .productQty)
        productWeight = try values.decodeIfPresent(String.self, forKey: .productWeight)
        updatedAt = try values.decodeIfPresent(String.self, forKey: .updatedAt)
        userId = try values.decodeIfPresent(String.self, forKey: .userId)
    }

}
