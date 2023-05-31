//
//  SingletonClass.swift
//  ProtiensApp
//
//  Created by mehtab alam on 12/01/2021.
//

import Foundation

class singleton: NSObject {
    static let shared = singleton()
    
    private override init() {}
    
    var userId:String!
    var emailId:String!
    var mobileNo:String!
    var firstName:String!
    var lastName:String!
    
    //MARK: - Set and Get Logined user details
    func getUserInfo(key: String) -> Any {
        
        if let dictUserInfo:NSDictionary = UserDefaults.standard.dictionary(forKey: "") as NSDictionary? {
            print("Userdata : ",dictUserInfo)
            if let strValue = dictUserInfo.value(forKey: key) {
                return strValue
            }
        }
        return ""
    }
    func setUserInfo(dictData: Any) {
        UserDefaults.standard.set(dictData, forKey: "UserDataInfo")
        
        UserDefaults.standard.synchronize()
    }
    
    //MARK: - Save key to userdefault
    func saveToDefault(value: Any, Key: String){
        let defaults = UserDefaults.standard
        defaults.set(value, forKey: Key)
        UserDefaults.standard.synchronize()
    }
    
    //MARK: - Get value from userdefault
    func getFromDefault(Key: String) -> Any{
        let defaults = UserDefaults.standard
        if let strValue = defaults.value(forKey: Key){
            return strValue
        }
        return ""
    }
    
    //MARK: - Remove key from userdefault
    func removeFromDefault(Key: String) {
        
        let defaults = UserDefaults.standard
        defaults.removeObject(forKey: Key)
    }
}

//MARK:- Default keys
struct DefaultKeys {
    static let email = "emailID"
    static let mobile = "mobile"
    static let userId = "userId"
    static let firstName = "firstName"
    static let lastName = "lastName"
    static let cityName = "cityName"
    static let pincode = "pincode"
    static let razorPayLiveKey = "rzp_live_f5vBjAxFW2djTM"
    static let razorPayLiveSecretKey = "8UOT1Wh4Rh9cPnbiyq9FbNBv"
    static let razorPayTesteKey = "rzp_test_8HQfahN6Yne8ap"
    static let razorPayTestSecretKey = "ZC7rkLo1E1wFV28fYfcy3YKz"
}
