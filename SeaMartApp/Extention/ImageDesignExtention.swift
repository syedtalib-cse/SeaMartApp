//
//  ImageDesignExtention.swift
//  ProtiensApp
//
//  Created by mehtab alam on 15/12/2020.
//

import Foundation
import UIKit

extension UIView {
    func addShadowInView() {
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOffset = CGSize(width: 0, height: 0)
        layer.shadowOpacity = 0.5
        layer.shadowRadius = 5
        clipsToBounds = false
    }
}

extension UIImageView {
    func addShadowInImageView() {
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOffset = CGSize(width: 0, height: 0)
        layer.shadowOpacity = 0.5
        layer.shadowRadius = 5
        clipsToBounds = false
    }
}
