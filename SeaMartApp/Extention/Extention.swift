//
//  Extention.swift
//  ProtiensApp
//
//  Created by mehtab alam on 07/01/2021.
//

import Foundation
import UIKit
extension Double {
    func roundToDecimal(_ fractionDigits: Int) -> Double {
        let multiplier = pow(10, Double(fractionDigits))
        return Darwin.round(self * multiplier) / multiplier
    }
    
    func toString() -> String {
        let intValue = self
        let decimal = self.truncatingRemainder(dividingBy: 1)
        
        if decimal == 0 {
            return "\(intValue)"
        } else {
            return "\(self)"
        }
    }
    
    func format(f: String) -> String {
        return String(format: "%\(f)f", self)
    }
    
    func toLocalCurrencyFormat() -> String {
        let formatter = NumberFormatter()
        formatter.locale = Locale.current
        formatter.numberStyle = .decimal // .currency
        
        if let formattedString = formatter.string(from: self as NSNumber) {
            return "₹ \(formattedString)"
        } else {
            return "₹ \(self)"
        }
    }
    
    func toLocalNumberFormat() -> String {
        let formatter = NumberFormatter()
        formatter.locale = Locale.current
        formatter.numberStyle = .decimal
        
        if let formattedString = formatter.string(from: self as NSNumber) {
            return formattedString
        } else {
            return "\(self)"
        }
    }
    
    init?(_ bytes: [UInt8]) {
        guard bytes.count == MemoryLayout<Self>.size else { return nil }
        
        self = bytes.withUnsafeBytes {
            return $0.load(as: Self.self)
        }
    }
}

extension Array where Element == String {
//    func toDouble() -> [Double] {
//        var temp = [Double]()
//
//        for item in self {
//            if let dblValue = item.double() {
//                temp.append(dblValue)
//            } else {
//                temp.append(0.0)
//            }
//        }
//
//        return temp
//    }
    
    func toJsonString() -> String? {
        let jsonData = try? JSONSerialization.data(withJSONObject: self, options: [])
        
        if let data = jsonData {
            return String(data: data, encoding: .utf8)
        } else {
            return nil
        }
    }
}

extension Array where Element == Double {
    func toString() -> [String] {
        var temp = [String]()
        
        for item in self {
            temp.append(item.toString())
        }
        
        return temp
    }
}
//Get Top most view controller
extension UIApplication {

    class func getTopMostViewController() -> UIViewController? {
        let keyWindow = UIApplication.shared.windows.filter {$0.isKeyWindow}.first
        if var topController = keyWindow?.rootViewController {
            while let presentedViewController = topController.presentedViewController {
                topController = presentedViewController
            }
            return topController
        } else {
            return nil
        }
    }
}
