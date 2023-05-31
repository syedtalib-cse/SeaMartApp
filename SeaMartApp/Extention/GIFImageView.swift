//
//  GIFImageView.swift
//  ProtiensApp
//
//  Created by mehtab alam on 04/01/2021.
//

import UIKit
import SwiftyGif

class LogoAnimationView: UIView {
    
    let logoGifImageView: UIImageView = {
        guard let gifImage = try? UIImage(gifName: "seamart.gif") else {
            return UIImageView()
        }
        return UIImageView(gifImage: gifImage, loopCount: 1)
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    private func commonInit() {
        backgroundColor = UIColor(hexString: "#C41210")
        let screenSize: CGRect = UIScreen.main.bounds
        addSubview(logoGifImageView)
        logoGifImageView.contentMode = .scaleAspectFill
        logoGifImageView.translatesAutoresizingMaskIntoConstraints = false
        logoGifImageView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        logoGifImageView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        logoGifImageView.widthAnchor.constraint(equalToConstant: screenSize.width).isActive = true
        logoGifImageView.heightAnchor.constraint(equalToConstant: screenSize.height).isActive = true
    }
}


