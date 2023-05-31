//
//  SceneDelegate.swift
//  SeaMartApp
//
//  Created by mehtab alam on 19/01/2021.
//

import UIKit
@available(iOS 13.0, *)
class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?
    
    /// main navigaion controller
    var navigationController : UINavigationController?
    
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        // Use this method to optionally configure and attach the UIWindow `window` to the provided UIWindowScene `scene`.
        // If using a storyboard, the `window` property will automatically be initialized and attached to the scene.
        // This delegate does not imply the connecting scene or session are new (see `application:configurationForConnectingSceneSession` instead).
        guard let windowScene = (scene as? UIWindowScene) else { return }
        self.window = UIWindow(windowScene: windowScene)
        
        let mainStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let VC = mainStoryboard.instantiateViewController(withIdentifier: "SplashScreenViewController") as! SplashScreenViewController
        navigationController?.isNavigationBarHidden = true
        navigationController = UINavigationController(rootViewController: VC)
        navigationController?.isNavigationBarHidden = true // or not, your choice.
        
        self.window!.rootViewController = navigationController
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
            self.loadScreens()
        }
        
    }
    
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
    
    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
    }
    
    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }
    
    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }
    
    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }
    
    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
        
        // Save changes in the application's managed object context when the application transitions to the background.
        //  (UIApplication.shared.delegate as? AppDelegate)?.saveContext()
    }
    
    
}

