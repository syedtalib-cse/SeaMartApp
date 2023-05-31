//
//  MyProfileViewController.swift
//  SeaMartApp
//
//  Created by mehtab alam on 04/02/2021.
//

import UIKit

class MyProfileViewController: UIViewController {
    // MARK:- IBOutlet
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var emailLbl: UILabel!
    
    //MARK:- Variable declaration
    private var serviceInstance = Service()
    private var userObject:Users?
    var userID:String?
    var emailID:String?
    var mobile:String?
    var firstName:String?
    var lastName:String?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.isUserInteractionEnabled = true
        userID = singleton.shared.getFromDefault(Key: DefaultKeys.userId) as? String
        emailID = singleton.shared.getFromDefault(Key: DefaultKeys.email) as? String
        mobile = singleton.shared.getFromDefault(Key: DefaultKeys.mobile) as? String
        firstName = singleton.shared.getFromDefault(Key: DefaultKeys.firstName) as? String
        lastName = singleton.shared.getFromDefault(Key: DefaultKeys.lastName) as? String
        getPersonalUserPostData()
    }
}

//MARK:- Event Handler
extension MyProfileViewController {
    
    @IBAction func clickPersonalDetails(_ sender: Any) {
        let PDVC = self.storyboard?.instantiateViewController(withIdentifier: "ChangePersonalDetailsViewController") as! ChangePersonalDetailsViewController
        PDVC.callBackForUpdate = { data in
            self.nameLbl.text = data
    }
        self.navigationController?.pushViewController(PDVC, animated: true)
    }
    @IBAction func clickAddNewAddress(_ sender: Any) {
        let ANAVC = self.storyboard?.instantiateViewController(withIdentifier: "AddNewAddressViewController") as! AddNewAddressViewController
        ANAVC.isFromNewAdd = true
        self.navigationController?.pushViewController(ANAVC, animated: true)
    }
    @IBAction func clickManageAddress(_ sender: Any) {
        let MAVC = self.storyboard?.instantiateViewController(withIdentifier: "ManageAddressViewController") as! ManageAddressViewController
        self.navigationController?.pushViewController(MAVC, animated: true)
    }
    @IBAction func clickMyOrder(_ sender: Any) {
        let TRVC = self.storyboard?.instantiateViewController(withIdentifier: "TrackYourOrderViewController") as! TrackYourOrderViewController
        self.navigationController?.pushViewController(TRVC, animated: true)
    }
    
    @IBAction func clickLogout(_ sender: Any) {
        
        let VC = self.storyboard!.instantiateViewController(withIdentifier: "LoginScreenViewController") as! LoginScreenViewController
        
        let navigationController = UINavigationController(rootViewController: VC)
        navigationController.isNavigationBarHidden = true // or not, your choice.
        let appDel:AppDelegate = UIApplication.shared.delegate as! AppDelegate
        UserDefaults.standard.setValue(false, forKey: "isUserLoggedIn")
       // UserDefaults.standard.setValue(true, forKey: "isUserLoggedIn")
        UserDefaults.standard.synchronize()
        if #available(iOS 13.0, *) {
            
            MyProfileViewController().window?.rootViewController = navigationController
            MyProfileViewController().window?.makeKeyAndVisible()
        } else {
            // Fallback on earlier versions
            appDel.loadScreens()
        }
        
    }
    @IBAction func tapToBackBtn(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
}

//MARK:- API Call
extension MyProfileViewController {
        func getPersonalUserPostData() {
            serviceInstance.postRequest(url: SeaMartURL.getUserProfileURL, dataDictionary: ["user_id":userID!], decodingType: PersonalUserModel.self) { [weak self] (result) in
                switch result {
                case .success(let data):
                    let personalData = data
                    self!.userObject = personalData.users
                    DispatchQueue.main.async {
                        self!.nameLbl.text = "\(self!.userObject!.name ?? "") \(self!.userObject!.last_name ?? "")"
                        self!.emailLbl.text = self?.userObject?.email
                    }
                    print(self!.userObject!, "userObject")
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        }
    func updateUserProfilePostData(name:String,lastName:String) {
        serviceInstance.postRequest(url: SeaMartURL.updateUserProfileURL, dataDictionary: ["user_id":userID!,"name":name,"last_name":lastName,"email":emailID!,"mobile":mobile!], decodingType: UpdateUserModel.self) { [weak self] (result) in
            switch result {
            case .success(let data):
                let personalData = data
                print(personalData.status!)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}

extension UIViewController {
    var window: UIWindow? {
        if #available(iOS 13, *) {
            guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
                let delegate = windowScene.delegate as? SceneDelegate, let window = delegate.window else { return nil }
                   return window
        }
        
        guard let delegate = UIApplication.shared.delegate as? AppDelegate, let window = delegate.window else { return nil }
        return window
    }
}
