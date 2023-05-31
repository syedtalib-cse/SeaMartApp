//
//  SplashScreenViewController.swift
//  SeaMartApp
//
//  Created by mehtab alam on 11/02/2021.
//

import UIKit
import SwiftyGif
class SplashScreenViewController: UIViewController {
    
    let logoAnimationView = LogoAnimationView()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(logoAnimationView)
        logoAnimationView.pinEdgesToSuperView()
        logoAnimationView.logoGifImageView.delegate = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        logoAnimationView.logoGifImageView.startAnimatingGif()
    }
    
    //MARK:- viewWillAppear for hidding navigation Bar in next viewcontroller
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // Hide the navigation bar on the this view controller
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    //MARK:- viewWillDisappear for showing navigation Bar in main viewcontroller
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        // Show the navigation bar on other view controllers
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
    }
}

extension SplashScreenViewController: SwiftyGifDelegate {
    func gifDidStop(sender: UIImageView) {
        logoAnimationView.isHidden = true
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "LoginScreenViewController") as! LoginScreenViewController
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
