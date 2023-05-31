//
//  LoginScreenViewController.swift
//  SeaMartApp
//
//  Created by mehtab alam on 21/01/2021.
//

import UIKit
import SCLAlertView
class LoginScreenViewController: UIViewController,UITextFieldDelegate {
    
    @IBOutlet weak var mobileEmailTF: UITextField!
    
    //MARK:- Property Declaration
    private var mobileNoObject:Status?
    private var serviceInstance = Service()
    var returnVal:Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mobileEmailTF.delegate = self
    }
}
//MARK:- Button Action
extension LoginScreenViewController {
    @IBAction func clickForwardBtn(_ sender: Any) {
        let mobileTF = mobileEmailTF.text
        print(mobileTF!)
        if mobileTF!.isEmpty {
          //  alertView(Title: "Alert", messg: "Plese enter your mobile number")
            SCLAlertView().showError("Alert", subTitle: "Plese enter your mobile number")
        }
        else if mobileTF!.count < 10 {
           // alertView(Title: "Alert", messg: "Mobile Number Must Be 10 Digit")
            SCLAlertView().showError("Alert", subTitle: "Mobile Number Must Be 10 Digit")
        } else {
            getMobileNoPostData()
        }
    }
}
//MARK:- API Call
extension LoginScreenViewController {
    func getMobileNoPostData() {
        serviceInstance.postRequest(url: SeaMartURL.loginByMobileURL, dataDictionary: ["mobile":mobileEmailTF.text!], decodingType: MobileNoModel.self) { [weak self] (result) in
            
            switch result {
    
            case .success(let data):
                guard let mobileData = data.status else {return}
                guard let user = mobileData.user_id else {return}
                guard let email = mobileData.user_email else {return}
                guard let mobile = mobileData.mobile else {return}
                print(user,email,"user detail")
                singleton.shared.saveToDefault(value: email, Key: DefaultKeys.email)
                singleton.shared.saveToDefault(value: user, Key: DefaultKeys.userId)
                singleton.shared.saveToDefault(value: mobile, Key: DefaultKeys.mobile)
                // self?.mobileNoObject = mobileData
                print(mobileData, "Sent OTP")
                self?.showSecondScreen(OTP: mobileData.otp!, mobile: mobileData.mobile!)
            case .failure(let error):
                print("Error : "+error.localizedDescription)
            }
        }
    }
    
    func showSecondScreen(OTP: Int, mobile: String) {
        DispatchQueue.main.sync {
            let loginPage2 = self.storyboard?.instantiateViewController(withIdentifier: "OTPScreenViewController") as! OTPScreenViewController
            loginPage2.otpStore = OTP
            self.navigationController?.pushViewController(loginPage2, animated: true)
        }
    }
}
//MARK:- TextField Delegate
extension LoginScreenViewController {
    //TextField Delegate Method
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if textField == mobileEmailTF {
            let allowedCharacters = "1234567890"
            let allowedCharacterSet = CharacterSet(charactersIn: allowedCharacters)
            let typedCharacterSet = CharacterSet(charactersIn: string)
            let alphabet = allowedCharacterSet.isSuperset(of: typedCharacterSet)
            let Range = range.length + range.location > (mobileEmailTF.text?.count)!
            
            if Range == false && alphabet == false {
                return false
            }
            let NewLength = (mobileEmailTF.text?.count)! + string.count - range.length
            return NewLength <= 10
        } else {
            return false
        }
    }
}

