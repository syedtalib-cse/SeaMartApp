//
//  ChangePersonalDetailsViewController.swift
//  SeaMartApp
//
//  Created by mehtab alam on 04/02/2021.
//

import UIKit
import SCLAlertView
class ChangePersonalDetailsViewController: UIViewController {
    
    @IBOutlet weak var FNTF: UITextField!
    @IBOutlet weak var LNTF: UITextField!
    @IBOutlet weak var emailTF: UITextField!
    @IBOutlet weak var mobileTF: UITextField!
    
    private var serviceInstance = Service()
    private var userObject:Users?
    var userID:String?
    var emailID:String?
    var mobile:String?
    var callBackForUpdate:((String)->())?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        emailID = singleton.shared.getFromDefault(Key: DefaultKeys.email) as? String
        mobile = singleton.shared.getFromDefault(Key: DefaultKeys.mobile) as? String
        userID = singleton.shared.getFromDefault(Key: DefaultKeys.userId) as? String
        
        getPersonalUserPostData()
        
        emailTF.isUserInteractionEnabled = false
        mobileTF.isUserInteractionEnabled = false
        
    }
}
//MARK:- Event Handler
extension ChangePersonalDetailsViewController {
    
    @IBAction func tapToBackBtn(_ sender: Any) {
        self.callBackForUpdate!("\(self.FNTF.text!) \(self.LNTF.text!)")
        self.navigationController?.popViewController(animated: true)
        
    }
    
    @IBAction func clickSaveBtn(_ sender: Any) {
        updateUserProfilePostData()
        SCLAlertView().showSuccess("Done", subTitle: "Your Profile Successfully Updated.")
    }
    
    @IBAction func tapToHomeBtn(_ sender: Any) {
        self.navigationController?.popToRootViewController(animated: true)
    }
}
//MARK:- API Call
extension ChangePersonalDetailsViewController {
    func getPersonalUserPostData() {
        serviceInstance.postRequest(url: SeaMartURL.getUserProfileURL, dataDictionary: ["user_id":userID!], decodingType: PersonalUserModel.self) { [weak self] (result) in
            switch result {
            case .success(let data):
                let personalData = data
                self!.userObject = personalData.users
                DispatchQueue.main.async {
                    self!.FNTF.text = self?.userObject?.name
                    self!.LNTF.text = self?.userObject?.last_name
                    self!.emailTF.text = self?.userObject?.email
                    self!.mobileTF.text = self?.userObject?.mobile
                }
                print(self!.userObject!, "userObject")
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    func updateUserProfilePostData() {
        serviceInstance.postRequest(url: SeaMartURL.updateUserProfileURL, dataDictionary: ["user_id":userID!,"name":FNTF.text!,"last_name":LNTF.text!,"email":emailID!,"mobile":mobile!], decodingType: UpdateUserModel.self) { [weak self] (result) in
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
