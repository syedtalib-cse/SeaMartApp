//
//  ViewController.swift
//  SeaMartApp
//
//  Created by mehtab alam on 19/01/2021.
//

import UIKit
import paper_onboarding
class OnboardingViewController: UIViewController {

    @IBOutlet weak var onbordingView: PaperOnboarding!
    @IBOutlet weak var btnOutlet: UIButton!
    let itemArray = [
        OnboardingItemInfo(informationImage: UIImage(named: "splashScreen1")!, title: "Fresh Sea Food", description: "Get delicious fresh seafood chicken and meats quickly delivered\n.Exotic meat antibiotic free world class meat 0% chemicals.", pageIcon: UIImage(named: "splashScreen1")!, color: .clear, titleColor: .black, descriptionColor: .black, titleFont: UIFont(name: "AvenirNext-Bold", size: 30)!, descriptionFont: UIFont(name: "AvenirNext-Medium", size: 17)!),
        OnboardingItemInfo(informationImage: UIImage(named: "splashScreen2")!, title: "Well Processed", description: "Get your favourite meats and seafood home,vaccume packed,with safety measurements.", pageIcon: UIImage(named: "splashScreen2")!, color: .clear, titleColor: .black, descriptionColor: .black, titleFont: UIFont(name: "AvenirNext-Bold", size: 30)!, descriptionFont: UIFont(name: "AvenirNext-Medium", size: 17)!),
        OnboardingItemInfo(informationImage: UIImage(named: "splashScreen3")!, title: "Fast Delivery", description: "Get your favourite meats and seafood home,vaccume packed,with safety measurements.", pageIcon: UIImage(named: "splashScreen3")!, color: .clear, titleColor: .black, descriptionColor: .black, titleFont: UIFont(name: "AvenirNext-Bold", size: 30)!, descriptionFont: UIFont(name: "AvenirNext-Medium", size: 17)!)
    ]
   
    override func viewDidLoad() {
        super.viewDidLoad()
        onbordingView.dataSource = self
        onbordingView.delegate = self
        onbordingView.currentIndex(0, animated: true)
    }
    @IBAction func clickForwardBtn(_ sender: Any) {
        let LSVC = self.storyboard?.instantiateViewController(withIdentifier: "LoginScreenViewController") as! LoginScreenViewController
        self.navigationController?.pushViewController(LSVC, animated: true)
    }
    
    //MARK:- viewWillAppear for hidding navigation Bar in next viewcontroller
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // Hide the navigation bar on the this view controller
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
//    //MARK:- viewWillDisappear for showing navigation Bar in main viewcontroller
//    override func viewWillDisappear(_ animated: Bool) {
//        super.viewWillDisappear(animated)
//        // Show the navigation bar on other view controllers
//        self.navigationController?.setNavigationBarHidden(true, animated: animated)
//    }
}
extension OnboardingViewController: PaperOnboardingDataSource,PaperOnboardingDelegate {
    func onboardingItemsCount() -> Int {
        itemArray.count
    }
    
    func onboardingItem(at index: Int) -> OnboardingItemInfo {
        itemArray[index]
    }
    
    func onboardingPageItemColor(at index: Int) -> UIColor {
        return .systemRed
    }
    
    func onboardingConfigurationItem(_ item: OnboardingContentViewItem, index: Int) {
        // config labels
        item.titleLabel?.numberOfLines = 0
        item.titleLabel?.lineBreakMode = .byWordWrapping
        item.descriptionLabel?.textAlignment = .center
        
        if index == 0 {
            if let imageSize = item.imageView?.image?.size {
                //  if #available(iOS 11.0, *) {
                item.informationImageWidthConstraint?.constant = imageSize.width/5.5
                item.informationImageHeightConstraint?.constant = imageSize.height/5
                item.setNeedsUpdateConstraints()
            }
        } else if index == 1 {
            if let imageSize = item.imageView?.image?.size {
                //  if #available(iOS 11.0, *) {
                item.informationImageWidthConstraint?.constant = imageSize.width/3
                item.informationImageHeightConstraint?.constant = imageSize.height/4.5
                item.setNeedsUpdateConstraints()
            }
        } else {
            if let imageSize = item.imageView?.image?.size {
                // if #available(iOS 11.0, *) {
                item.informationImageWidthConstraint?.constant = imageSize.width/5.5
                item.informationImageHeightConstraint?.constant = imageSize.height/4
                item.setNeedsUpdateConstraints()
            }
        }
    }
    
    func onboardingDidTransitonToIndex(_ index: Int) {
        if index == 2 {
            UIView.animate(withDuration: 0.4) {
                self.btnOutlet.alpha = 1
            }
        }
    }

    func onboardingWillTransitonToIndex(_ index: Int) {
        if index != 2, self.btnOutlet.alpha != 0 {
            UIView.animate(withDuration: 0.4) {
                self.btnOutlet.alpha = 0
            }
        }
    }
}

