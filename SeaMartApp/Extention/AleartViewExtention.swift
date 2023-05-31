//
//  AleartViewExtention.swift
//  ProtiensApp
//
//  Created by mehtab alam on 27/12/2020.
//

import Foundation
import UIKit
extension UIViewController {
    // Function for aleartview messege
    func alertView(Title:String,messg:String) {
        let alert = UIAlertController(title: "\(Title)", message: "\(messg)", preferredStyle: UIAlertController.Style.alert)
        
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (action) in
        }))
        self.present(alert, animated: true, completion: nil)
    }
    
    func showActivityIndicator(messageView:OSOMessageView) {
        // adding constraint to messageView
        view.addSubview(messageView)
        messageView.isHidden = false
        messageView.animateActivityIndicator(animate: true)
        messageView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 0).isActive = true
        messageView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 0).isActive = true
        messageView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0).isActive = true
        messageView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0).isActive = true
    }
    func showToast(message : String) {
        
        DispatchQueue.main.async {
            let toastLabel = UILabel(frame: CGRect(x: self.view.frame.size.width/2 - 75, y: self.view.frame.size.height/2, width: 150, height: 35))
            toastLabel.backgroundColor = UIColor.black.withAlphaComponent(0.6)
            toastLabel.textColor = UIColor.white
            toastLabel.textAlignment = .center
            toastLabel.font = UIFont(name: "Montserrat-Light", size: 12.0)
            toastLabel.text = message
            toastLabel.alpha = 1.0
            toastLabel.layer.cornerRadius = 10
            toastLabel.clipsToBounds  =  true
            self.view.addSubview(toastLabel)
            UIView.animate(withDuration: 4.0, delay: 0.1, options: .curveEaseOut, animations: {
                toastLabel.alpha = 0.0
            }, completion: {(isCompleted) in
                toastLabel.removeFromSuperview()
            })
        }
    }
}



extension UIView {
    func pinEdgesToSuperView() {
        guard let superView = superview else { return }
        translatesAutoresizingMaskIntoConstraints = false
        topAnchor.constraint(equalTo: superView.topAnchor).isActive = true
        leftAnchor.constraint(equalTo: superView.leftAnchor).isActive = true
        bottomAnchor.constraint(equalTo: superView.bottomAnchor).isActive = true
        rightAnchor.constraint(equalTo: superView.rightAnchor).isActive = true
    }
}

extension UIImageView {
    func imageFromServerURL(_ URLString: String, placeHolder: UIImage?) {
        let imageCache = NSCache<AnyObject, AnyObject>()
        self.image = nil
        if let cachedImage = imageCache.object(forKey: NSString(string: URLString)) as? UIImage {
            self.image = cachedImage
            return
        }
        self.image = placeHolder
        
        if let url = URL(string: URLString) {
            URLSession.shared.dataTask(with: url, completionHandler: { (data, response, error) in
                if error != nil {
                    print("ERROR LOADING IMAGES FROM URL: \(String(describing: error))")
                    return
                }
                DispatchQueue.main.async {
                    if let data = data {
                        if let downloadedImage = UIImage(data: data) {
                            imageCache.setObject(downloadedImage, forKey: NSString(string: URLString))
                            self.image = downloadedImage
                        }
                    }
                }
            }).resume()
        }
    }
}

