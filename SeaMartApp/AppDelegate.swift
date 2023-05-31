//
//  AppDelegate.swift
//  SeaMartApp
//
//  Created by mehtab alam on 19/01/2021.
//

import UIKit
import GoogleMaps
import GooglePlaces
import IQKeyboardManagerSwift
@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    var navigationController : UINavigationController?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        IQKeyboardManager.shared.enable = true
        IQKeyboardManager.shared.shouldResignOnTouchOutside = true
        IQKeyboardManager.shared.toolbarDoneBarButtonItemText = "Done"
        
        GMSServices.provideAPIKey("AIzaSyCb7DSl9CzVTona7B7di7ugGAbE5Y_F92c")
        GMSPlacesClient.provideAPIKey("AIzaSyCb7DSl9CzVTona7B7di7ugGAbE5Y_F92c")
        
        let mainStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let VC = mainStoryboard.instantiateViewController(withIdentifier: "SplashScreenViewController") as! SplashScreenViewController
        navigationController = UINavigationController(rootViewController: VC)
        navigationController?.isNavigationBarHidden = true // or not, your choice.
        self.window = UIWindow(frame: UIScreen.main.bounds)
        self.window!.rootViewController = navigationController
        
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
            self.loadScreens()
        }
        return true
    }
    
    //MARK: - Set screens
    func loadScreens() {
        let storyboard = UIStoryboard.init(name: "Main", bundle: nil)
        
        if let loginStatus =  UserDefaults.standard.value(forKey: "isUserLoggedIn") as? Bool {
            if loginStatus == true {
                
                let frontVC = storyboard.instantiateViewController(withIdentifier: "MainViewController") as! MainViewController
                navigationController = UINavigationController(rootViewController: frontVC)
                window?.rootViewController = navigationController
                //make window key and visible
                window?.makeKeyAndVisible()
                
            } else {
                print("Show Sign In Screen Screen 1")
                
                let VC = storyboard.instantiateViewController(withIdentifier: "LoginScreenViewController") as! LoginScreenViewController
                navigationController = UINavigationController(rootViewController: VC)
                navigationController?.isNavigationBarHidden = true // or not, your choice.
                
                self.window!.rootViewController = navigationController
                
            }
        } else {
            let VC = storyboard.instantiateViewController(withIdentifier: "OnboardingViewController") as! OnboardingViewController
            navigationController?.isNavigationBarHidden = true
            navigationController = UINavigationController(rootViewController: VC)
            navigationController?.isNavigationBarHidden = true // or not, your choice.
            
            self.window!.rootViewController = navigationController
            
        }
    }
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Error \(error)")
    }
    
    // MARK: UISceneSession Lifecycle
    
//    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
//        // Called when a new scene session is being created.
//        // Use this method to select a configuration to create the new scene with.
//        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
//    }
//    
//    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
//        // Called when the user discards a scene session.
//        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
//        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
//    }
    
    
}

