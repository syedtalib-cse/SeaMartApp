//
//  MessegeView.swift
//  ProtiensApp
//
//  Created by mehtab alam on 31/12/2020.
//

import UIKit

protocol OSOMessageViewDelegate: class {
    func cancel()
}

extension OSOMessageViewDelegate {
    func cancel() {}
}

class OSOMessageView: UIView {
    
    weak var delegate: OSOMessageViewDelegate?
    
    private var showCancelButton: Bool = false
    public var addBlurBackground: Bool = false

    private let lblMessage: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 12)
        label.textColor = UIColor(white: 1.0, alpha: 0.5)
        label.lineBreakMode = .byWordWrapping
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let btnCancel: UIButton = {
        let button = UIButton()
        button.setTitle("Cancel", for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 12)
        button.setTitleColor(UIColor(white: 1.0, alpha: 0.3), for: .normal)
        button.setTitleColor(UIColor.white, for: .highlighted)
        button.backgroundColor = UIColor(white: 1.0, alpha: 0.05)
       // button.layer.cornerRadius = Constants.UIConstants.buttonCornerRadius
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let activityIndicator: UIActivityIndicatorView = {
        if #available(iOS 13.0, *) {
            let aiv = UIActivityIndicatorView(style: .large)
            aiv.translatesAutoresizingMaskIntoConstraints = false
            aiv.hidesWhenStopped = true
            return aiv
        } else {
            // Fallback on earlier versions
            let aiv = UIActivityIndicatorView()
            aiv.translatesAutoresizingMaskIntoConstraints = false
            aiv.hidesWhenStopped = true
            return aiv
        }
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupView()
    }
    
    init(showCancelButton: Bool = false, addBlurBackground: Bool = false) {
        super.init(frame: CGRect.zero)
        self.showCancelButton = showCancelButton
        self.addBlurBackground = addBlurBackground
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        setupView()
    }
    
    private func setupView() {
        
        backgroundColor = UIColor.clear
        clipsToBounds = true
        
        if addBlurBackground {
            addBlur()
        }
        
        addSubview(lblMessage)
        lblMessage.leftAnchor.constraint(equalTo: leftAnchor, constant: 20).isActive = true
        lblMessage.rightAnchor.constraint(equalTo: rightAnchor, constant: -20).isActive = true
        lblMessage.topAnchor.constraint(equalTo: topAnchor, constant: 20).isActive = true
        lblMessage.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -20).isActive = true
        
        // activityIndicator
        addSubview(activityIndicator)
        activityIndicator.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        activityIndicator.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        activityIndicator.stopAnimating()
        
        // btnCancel
        if showCancelButton {
            addSubview(btnCancel)
            btnCancel.isHidden = true
            btnCancel.addTarget(self, action: #selector(actionCancel(_:)), for: .touchUpInside)
            btnCancel.topAnchor.constraint(equalTo: activityIndicator.bottomAnchor, constant: 20).isActive = true
            btnCancel.heightAnchor.constraint(equalToConstant: 40).isActive = true
            btnCancel.centerXAnchor.constraint(equalTo: centerXAnchor, constant: 0).isActive = true
          //  btnCancel.widthAnchor.constraint(equalToConstant: (btnCancel.titleLabel?.text?.sizeOfString(usingFont: btnCancel.titleLabel!.font).width)! * 1.5).isActive = true
        }
    }
    
    public func addBlur() {
        if !UIAccessibility.isReduceTransparencyEnabled {
            backgroundColor = UIColor.clear
            let blurEffect = UIBlurEffect(style: .dark)
            let blurEffectView = UIVisualEffectView(effect: blurEffect)
            blurEffectView.frame = bounds
            blurEffectView.alpha = 0.9
            blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
            addSubview(blurEffectView)
        } else {
            let blurEffect = UIBlurEffect(style: .dark)
            let blurEffectView = UIVisualEffectView(effect: blurEffect)
            blurEffectView.frame = bounds
            blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
            addSubview(blurEffectView)
        }
    }
    
    public func showMessage(message: String) {
        DispatchQueue.main.async {
            self.lblMessage.text = message.uppercased()
        }
    }
    
    public func animateActivityIndicator(animate: Bool) {
        if animate {
            DispatchQueue.main.async {
                if self.activityIndicator.isHidden {
                    self.activityIndicator.isHidden = false
                    
                    if self.showCancelButton {
                        self.btnCancel.isHidden = false
                    }
                }
                
                self.showMessage(message: "")
                
                self.activityIndicator.startAnimating()
            }
            
        } else {
            if showCancelButton {
                btnCancel.isHidden = true
            }
            
            activityIndicator.stopAnimating()
        }
    }
    
    @objc private func actionCancel(_ sender: UIButton) {
        delegate?.cancel()
    }

}

