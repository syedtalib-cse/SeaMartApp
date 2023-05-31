//
//  OTPScreenViewController.swift
//  SeaMartApp
//
//  Created by mehtab alam on 21/01/2021.
//

import UIKit

class OTPScreenViewController: UIViewController,UITextFieldDelegate {
    
    //MARK:- Outlet
    @IBOutlet var TFCollection: [UITextField]!
    @IBOutlet var otpLbl: UILabel!
    
    //MARK:- Property Declaration
    var otpStore: Int!
    private var OTPObject:OTPModel?
    private var serviceInstance = Service()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
      //  changeCharacterTarget()
        TFCollection.forEach {
                configureDigitField($0)
            }
        
//        for textfield in TFCollection {
//            textfield.delegate = self
//        }
        print("Received OTP", otpStore as Any)
        otpLbl.text = "\(otpStore!)"
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        TFCollection[0].becomeFirstResponder()
    }
    fileprivate func configureDigitField(_ digitField: UITextField) {
        digitField.delegate = (self as UITextFieldDelegate)
        digitField.addTarget(self, action: #selector(self.textFieldDidChange(textField:)), for: UIControl.Event.editingChanged)
    }
    @objc fileprivate func textFieldDidChange(textField: UITextField) {
        if textField.text?.count == 1 {
            let remaining = TFCollection.filter { $0.text?.count == 0 }
            if remaining.count > 0 {
                remaining[0].becomeFirstResponder()
            } else {
                TFCollection.forEach { $0.resignFirstResponder() }
               // getOTPPostData()
                movetoNextScreen()
            }
        }
    }
    func movetoNextScreen() {
        let otpArray = otpStore.digits // [1, 2, 3]
        print("otpArray:--\(otpArray)")
        
        
        if TFCollection[0].text!.isEmpty || TFCollection[1].text!.isEmpty || TFCollection[2].text!.isEmpty || TFCollection[3].text!.isEmpty || TFCollection[4].text!.isEmpty || TFCollection[5].text!.isEmpty {
            
            alertView(Title: "Alert", messg: "Please Fill all OTP box")
            
        } else if TFCollection[0].text! != String(otpArray[0]) || TFCollection[1].text! != String(otpArray[1]) || TFCollection[2].text! != String(otpArray[2]) || TFCollection[3].text! != String(otpArray[3]) || TFCollection[4].text! != String(otpArray[4]) || TFCollection[5].text! != String(otpArray[5]) {
            
            alertView(Title: "Alert", messg: "Invalid OTP")
            
        } else {
            getOTPPostData()
        }
    }
}

//MARK:- Button Action
extension OTPScreenViewController {
    
    @IBAction func tapRegenOTPBtn(_ sender: Any) {
    }
}
//MARK:- API Call
extension OTPScreenViewController {
    func showSignUpORHome() {
        DispatchQueue.main.async {
            let VC = self.storyboard?.instantiateViewController(withIdentifier: "SelectCityViewController2") as! SelectCityViewController2
            VC.status1 = self.OTPObject?.status
            self.navigationController?.pushViewController(VC, animated: true)
        }
    }
    func getOTPPostData() {
        serviceInstance.postRequest(url: SeaMartURL.verifyOTPURL, dataDictionary: ["otp": String(otpStore)], decodingType: OTPModel.self) { [weak self] (result) in
            switch result {
            case .success(let data):
                let otpData = data
                print(otpData, "Sent OTP")
                self?.OTPObject = otpData
                self?.showSignUpORHome()
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
//MARK:- TextField Delegate
extension OTPScreenViewController {
    func changeCharacterTarget() {
        self.TFCollection[0].addTarget(self, action: #selector(self.changeCharacter), for: .editingChanged)
        self.TFCollection[1].addTarget(self, action: #selector(self.changeCharacter), for: .editingChanged)
        self.TFCollection[2].addTarget(self, action: #selector(self.changeCharacter), for: .editingChanged)
        self.TFCollection[3].addTarget(self, action: #selector(self.changeCharacter), for: .editingChanged)
        self.TFCollection[4].addTarget(self, action: #selector(self.changeCharacter), for: .editingChanged)
        self.TFCollection[5].addTarget(self, action: #selector(self.changeCharacter), for: .editingChanged)
    }
    
    @objc func changeCharacter(textField : UITextField){
        if textField.text?.utf8.count == 1 {
            switch textField {
            case TFCollection[0]:
                TFCollection[1].becomeFirstResponder()
            case TFCollection[1]:
                TFCollection[2].becomeFirstResponder()
            case TFCollection[2]:
                TFCollection[3].becomeFirstResponder()
            case TFCollection[3]:
                TFCollection[4].becomeFirstResponder()
            case TFCollection[4]:
                TFCollection[5].becomeFirstResponder()
            case TFCollection[5]:
                print("OTP = \(TFCollection[0].text!)\(TFCollection[1].text!)\(TFCollection[2].text!)\(TFCollection[3].text!)\(TFCollection[4])\(TFCollection[5])")
            default:
                break
            }
        }else if textField.text!.isEmpty {
            switch textField {
            case TFCollection[5]:
                TFCollection[4].becomeFirstResponder()
            case TFCollection[4]:
                TFCollection[3].becomeFirstResponder()
            case TFCollection[3]:
                TFCollection[2].becomeFirstResponder()
            case TFCollection[2]:
                TFCollection[1].becomeFirstResponder()
            case TFCollection[1]:
                TFCollection[0].becomeFirstResponder()
            default:
                break
            }
        }
    }
    
    // Function For CharacterSet to the TextField
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {

        let alowedNumbers = CharacterSet.decimalDigits
        let alowedNumbers1 = CharacterSet.whitespaces
        let number = CharacterSet(charactersIn: string)

        var returnValue = true
        if(textField == TFCollection[0] || textField == TFCollection[1] || textField == TFCollection[2] || textField == TFCollection[3] || textField == TFCollection[4] || textField == TFCollection[5]) {
            returnValue = alowedNumbers.isSuperset(of: number) || alowedNumbers1.isSuperset(of: number)
        } else if textField.text?.utf16.count == 1 && !string.isEmpty {
            return false
        } else {
            return true
        }
        return returnValue
    }
}

// UserDefaults.setValue(true, forKey: "isUserLoggedIn") SIGN3 (Fill Details) after submit click
// UserDefaults.setValue(false, forKey: "isUserLoggedIn") After LogOut click

/* Put this code in APP Delegate in didFinishLaunchWithOptions
 
 let loginStatus =  UserDefaults.value(forKey: "isUserLoggedIn") as! Bool
 if loginStatus == true {
 print("Show Home Screen")
 } else {
 print("Show Sign In Screen Screen 1")
 }
 */
