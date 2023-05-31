//
//  Service.swift
//  ProtiensApp
//
//  Created by mehtab alam on 15/12/2020.
//

import Foundation
import UIKit

//MARK:- Class for Service API Calling
class Service {
    
    func getRequest<T: Decodable>(url: String, decodingType: T.Type, _ completion: @escaping (Result<T, Error>) -> Void) {
        
        guard let url = URL(string: url) else { return }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        let dataTask = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            if let data = data {
                do {
                    let jsonData = try JSONDecoder().decode(decodingType, from: data)
                    completion(.success(jsonData))
                } catch let error {
                    completion(.failure(error))
                    print(completion(.failure(error)))
                }
            }
        }
        dataTask.resume()
    }
    
    func postRequest<T: Decodable>(url: String,dataDictionary: [String:String], decodingType: T.Type, _ completion: @escaping (Result<T, Error>) -> Void) {
        
        guard let url = URL(string: url) else { return }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        
        do {
            let requestBody = try JSONSerialization.data(withJSONObject: dataDictionary, options: .prettyPrinted)
            request.httpBody = requestBody
            request.addValue("application/json", forHTTPHeaderField: "content-type")
        } catch let error {
            debugPrint(error.localizedDescription)
        }
        
        let dataTask = URLSession.shared.dataTask(with: request) { (data, response, error) in
            
            print("Status Code", +statuscode)
        
            if let error = error {
                completion(.failure(error))
                return
            }
            
            if let data = data {
                do {
                    let jsonData = try JSONDecoder().decode(decodingType, from: data)
                    completion(.success(jsonData))
                } catch let error {
                    completion(.failure(error))
                    print(completion(.failure(error)))
                }
            }
        }
        dataTask.resume()
    }
}


//MARK:- struct for Service URL
struct SeaMartURL {
    static let baseURL = "https://ebosapps.com/seamartAPI/Api/"
    static let homeURL = "\(baseURL)getSeamartHomedetails"
    static let GetProductsbyCatURL = "\(baseURL)getSeamartProductsbycat"
    static let GetSingleProductDetailsURL = "\(baseURL)getSeamartSingleProductDetails"
 //   static let GetTrendingProductURL = "\(baseURL)getTrendingProducts"
    static let GetSubCategoryNameByParentIDURL = "\(baseURL)semartGetSubcatNameByParentId"
    static let GetAllProductsAttributeDetailsURL = "\(baseURL)getSeamartProductAttributeDetails"//getSeamartProductAttributeDetailsWithoutPincode"
    static let GetProductBySubCategoryURL = "\(baseURL)getSeamartProductsBySubCategory"
    static let loginByMobileURL = "\(baseURL)semartloginUser"
    static let verifyOTPURL = "\(baseURL)seamartVerifyOTP"
    static let userUpdateURL = "\(baseURL)semartUpdateUser"
    static let addToCartURL = "\(baseURL)seamartAddToCart"
    static let deleteToCartURL = "\(baseURL)semartDeleteCart"
    static let getAllCartURL = "\(baseURL)semartGetAllcarts"
    static let updateCartProductQuantityURL = "\(baseURL)semartUpdateCartProductQuantity"
    static let getCheckoutURL = "\(baseURL)semartGetCheckout"
    static let getChangeAddressURL = "\(baseURL)semartGetChangeAddress"
    static let getAllStatesURL = "\(baseURL)seamartGetAllStates"
    static let getAllCitiesURL = "\(baseURL)getAllCities"
    static let getAllAreasURL = "\(baseURL)getAllAreas"
    static let storeDeliveryAddressURL = "\(baseURL)seamartStoreDeliveryAddresses"
    static let getUserProfileURL = "\(baseURL)seamartGetUserProfile"
    static let getBillDetailsURL = "\(baseURL)semartGetBillDetails"
    static let getApplyCouponURL = "\(baseURL)semartApplyCoupon"
    static let serachProductByPincodeURL = "\(baseURL)seamartSearchProductsByPincode"
    static let serachProductByName = "\(baseURL)seamartSearchProductsByProductName"
    static let userOrderURL = "\(baseURL)semartGetUserOrders"
    static let placeOrderURL = "\(baseURL)seamartPlaceOrder"
    static let deleteAddressURL = "\(baseURL)semartDeleteDeliveryaddress"
    static let updateDeliveryAddress = "\(baseURL)seamartUpdateDeliveryAddresses"
    static let updateUserProfileURL = "\(baseURL)seamartUpdateUserProfile"
    static let fetchAreaURL = "\(baseURL)seamartFetchAreas"
    static let fetchCityURL = "\(baseURL)seamartFetchCities"
    static let createOrderID = "https://api.razorpay.com/v1/orders"
    static let bannerImageURL = "https://ebosapps.com/seamart-test/assets/images/banners/"
    static let iconImageURL = "https://ebosapps.com/seamart-test/assets/images/icons/"
    static let categoryImageURL = "https://ebosapps.com/seamart-test/assets/images/categories/"
    static let productImageURL = "https://ebosapps.com/seamart-test/assets/images/products/"
}
