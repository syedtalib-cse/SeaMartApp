//
//  PersonalDetailsViewController.swift
//  SeaMartApp
//
//  Created by mehtab alam on 04/02/2021.
//

import UIKit
import SCLAlertView
class PersonalDetailsViewController: UIViewController, UITextFieldDelegate {
    
    //MARK:- OUTLET
    @IBOutlet weak var firstNameTF: UITextField!
    @IBOutlet weak var lastNameTF: UITextField!
    @IBOutlet weak var emailTF: UITextField!
    @IBOutlet weak var signUpBtn: UIButton!
    
    //MARK:- Variable declaration
    var mobileNoStore: String!
    private var serviceInstance = Service()
    private var personalDetailsObj:PersonalDetailsModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        design()
        
        mobileNoStore = singleton.shared.getFromDefault(Key: DefaultKeys.mobile) as? String
        print(mobileNoStore!,"mobileNoStore")
       // singleton.shared.saveToDefault(value: firstNameTF.text!, Key: DefaultKeys.firstName)
    }
}
//MARK:- Button Action
extension PersonalDetailsViewController {
    @IBAction func tapSignUpBtn(_ sender: Any) {
        
        if firstNameTF.text!.isEmpty || lastNameTF.text!.isEmpty || emailTF.text!.isEmpty {
            alertView(Title: "Alert", messg: "Plese fill all textfield")
        } else if !emailTF.text!.isValidEmail {
            alertView(Title: "Alert", messg: "Plese enter valid email ID")
        } else {
            getPersonalDetailsPostData()
        }
    }
}
//MARK:- API Call
extension PersonalDetailsViewController {
    
    func getPersonalDetailsPostData() {
        serviceInstance.postRequest(url: SeaMartURL.userUpdateURL, dataDictionary: ["name":firstNameTF.text!,"last_name":lastNameTF.text!,"email":emailTF.text!,"phone": mobileNoStore], decodingType: PersonalDetailsModel.self) { [weak self] (result) in
            switch result {
            case .success(let data):
                let personalData = data
                print(personalData, "personalData")
                self?.personalDetailsObj = personalData
                DispatchQueue.main.async {
                    guard let FN = self!.firstNameTF.text else {return}
                    guard let LN = self!.lastNameTF.text else {return}
                    guard let emailID = self!.emailTF.text else {return}
                    singleton.shared.saveToDefault(value: FN, Key: DefaultKeys.firstName)
                    singleton.shared.saveToDefault(value: LN, Key: DefaultKeys.lastName)
                    singleton.shared.saveToDefault(value: emailID, Key: DefaultKeys.email)
                    UserDefaults.standard.setValue(true, forKey: "isUserLoggedIn")
                    UserDefaults.standard.synchronize()
//                    let loginStatus = UserDefaults.standard.value(forKey: "isUserLoggedIn") as! Bool
//                   print(loginStatus,"loginstutus")
                    let MVC = self!.storyboard?.instantiateViewController(withIdentifier: "MainViewController") as! MainViewController
                    if personalData.status == "email already existed" {
                        SCLAlertView().showError("Alert", subTitle: "This email is already existed.")
                    } else {
                    self!.navigationController?.pushViewController(MVC, animated: true)
                    }
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
//MARK:- TextField Delegate
extension PersonalDetailsViewController {
    // Function For TextField For Character and Number
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        let allowedCharecters = CharacterSet.letters
        let allowedCharecters1 = CharacterSet.whitespaces
        let character = CharacterSet(charactersIn: string)
        
        var returnValue = true
        if(textField == firstNameTF || textField == lastNameTF) {
            returnValue = allowedCharecters.isSuperset(of: character) || allowedCharecters1.isSuperset(of: character)
        }
        return returnValue
    }
    
    func design() {
        firstNameTF.layer.borderWidth = 0.6
        firstNameTF.layer.cornerRadius = 6
        firstNameTF.layer.borderColor = UIColor.lightGray.cgColor
        lastNameTF.layer.borderWidth = 0.6
        lastNameTF.layer.cornerRadius = 6
        lastNameTF.layer.borderColor = UIColor.lightGray.cgColor
        emailTF.layer.borderWidth = 0.6
        emailTF.layer.cornerRadius = 6
        emailTF.layer.borderColor = UIColor.lightGray.cgColor
        firstNameTF.delegate = self
        lastNameTF.delegate = self
        emailTF.delegate = self
    }
}

