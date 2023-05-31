//
//  ExtentionForSplittingDigit.swift
//  ProtiensApp
//
//  Created by mehtab alam on 12/01/2021.
//

import Foundation

extension StringProtocol  {
    var digits: [Int] { compactMap{ $0.wholeNumberValue } }
}
extension LosslessStringConvertible {
    var string: String { .init(self) }
}
extension Numeric where Self: LosslessStringConvertible {
    var digits: [Int] { string.digits }
}
