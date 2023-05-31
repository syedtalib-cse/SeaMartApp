//
//  AddNewAddressViewController.swift
//  SeaMartApp
//
//  Created by mehtab alam on 05/02/2021.
//

import UIKit
import iOSDropDown
import DLRadioButton
import SCLAlertView
class AddNewAddressViewController: UIViewController, UITextFieldDelegate {
    
    // MARK:- IBOutlet
    @IBOutlet weak var nameTF: UITextField!
    @IBOutlet weak var mobileTF: UITextField!
    @IBOutlet weak var streetTF: UITextField!
    @IBOutlet weak var landmarkTF: UITextField!
    @IBOutlet weak var cityTF: DropDown!
    @IBOutlet weak var pincodeTF: UITextField!
    @IBOutlet weak var stateTF: DropDown!
    @IBOutlet weak var areaDropdown: DropDown!
    @IBOutlet var borderLabel: [UILabel]!
    @IBOutlet weak var homeBtn: UIButton!
    @IBOutlet weak var workBtn: UIButton!
    @IBOutlet weak var othersBtn: UIButton!
    @IBOutlet weak var changeName: UIButton!
    @IBOutlet var topTitleLbl: UILabel!
    
    //MARK:- Variable declaration
    private var serviceInstance = Service()
    var userID:String?
    var emailID:String?
    var mobileNo:String?
    var returnVal:Bool = false
    var dictDataItems: Delivery_address!
    var callBackForEditAddress:((String) ->())?
    var callBackForAddAddress:((String) ->())?
    var isFromEdit = Bool()
    var isFromNewAdd = Bool()
    public var selectedButton: Int?
    private var addnewAddressObject:AddNewAddressModel?
    // private var allAreaObject:[Area]!
    private var fetchAreaObject:[AreaName]!
    private var fetchCityObject:[Citys]!
    private var allStateObject:[State]!
    var selectedStateId:String?
    var selectedCityId:String?
    var selectedAreaId:String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        emailID = singleton.shared.getFromDefault(Key: DefaultKeys.email) as? String
        mobileNo = singleton.shared.getFromDefault(Key: DefaultKeys.mobile) as? String
        userID = singleton.shared.getFromDefault(Key: DefaultKeys.userId) as? String
        
        nameTF.delegate = self
        mobileTF.delegate = self
        streetTF.delegate = self
        landmarkTF.delegate = self
        cityTF.delegate = self
        pincodeTF.delegate = self
        stateTF.delegate = self
        areaDropdown.delegate = self
        
        if isFromEdit == true {
            nameTF.text = dictDataItems.name 
            mobileTF.text = dictDataItems.mobile
            streetTF.text = dictDataItems.address
            landmarkTF.text = dictDataItems.flat_number
            cityTF.text = dictDataItems.city_name
            pincodeTF.text = dictDataItems.pincode
            stateTF.text = dictDataItems.state_name
            areaDropdown.text = dictDataItems.area_name
            self.changeName.setTitle("Save Address", for: .normal)
            self.topTitleLbl.text = "Manage Address"
            
            if dictDataItems.type == "1" {
                homeBtn.backgroundColor = UIColor(hexString: "#C41210")
                workBtn.backgroundColor = .lightGray
                othersBtn.backgroundColor = .lightGray
            } else if dictDataItems.type == "2" {
                homeBtn.backgroundColor = .lightGray
                workBtn.backgroundColor = UIColor(hexString: "#C41210")
                othersBtn.backgroundColor = .lightGray
            } else if dictDataItems.type == "3" {
                homeBtn.backgroundColor = .lightGray
                workBtn.backgroundColor = .lightGray
                othersBtn.backgroundColor = UIColor(hexString: "#C41210")
            }
        }
        
        
        areaDropdown.isSearchEnable = false
        stateTF.isSearchEnable = false
        cityTF.isSearchEnable = false
        
        getAllStatesdata()
        
        //Button
       // homeBtn.sendActions(for: .touchUpInside)
//        homeBtn.backgroundColor = .lightGray
//        workBtn.backgroundColor = .lightGray
//        othersBtn.backgroundColor = .lightGray
        self.homeBtn.ViewRoundCorners(corners: [.allCorners], radius: 6)
        self.workBtn.ViewRoundCorners(corners: [.allCorners], radius: 6)
        self.othersBtn.ViewRoundCorners(corners: [.allCorners], radius: 6)
        self.homeBtn.tag = 1
        self.workBtn.tag = 2
        self.othersBtn.tag = 3
        homeBtn.addTarget(self, action: #selector(buttonSelected(_:)), for: UIControl.Event.touchUpInside)
        workBtn.addTarget(self, action: #selector(buttonSelected(_:)), for: UIControl.Event.touchUpInside)
        othersBtn.addTarget(self, action: #selector(buttonSelected(_:)), for: UIControl.Event.touchUpInside)
        
        
    }
}
//MARK:- Event Handler
extension AddNewAddressViewController {
    @IBAction func tapToBackBtn(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func tapToHomeBtn(_ sender: Any) {
        self.navigationController?.popToRootViewController(animated: true)
    }
    
    @IBAction func clickSaveNewAddressBtn(_ sender: Any) {
        print(areaDropdown.text!,"area name")
        if areaDropdown.text!.isEmpty {
            alertView(Title: "Aleart", messg: "Area Field Must be fill")
            areaDropdown.shake()
            borderLabel[7].backgroundColor = #colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1)
        } else {
            if self.isFromEdit {
                DispatchQueue.main.async {
                    self.updateDeliveryAddressPostData()
                }
            } else {
                DispatchQueue.main.async {
                    self.addNewAddressPostData()
                }
            }
            
        }
    }
    
    @objc private func buttonSelected(_ button: UIButton) {
        // guard let tag = radioButton.selected()?.tag else { return }
        
        if button.tag == homeBtn.tag {
            print("homeRadioBtn")
            self.selectedButton = 1
            homeBtn.backgroundColor = UIColor(hexString: "#C41210")
            workBtn.backgroundColor = .lightGray
            othersBtn.backgroundColor = .lightGray
            workBtn.isSelected = false
            othersBtn.isSelected = false
        } else if button.tag == workBtn.tag {
            print("workRadioBtn")
            self.selectedButton = 2
            homeBtn.backgroundColor = .lightGray
            workBtn.backgroundColor = UIColor(hexString: "#C41210")
            othersBtn.backgroundColor = .lightGray
            homeBtn.isSelected = false
            othersBtn.isSelected = false
        } else {
            print("othersRadioBtn")
            self.selectedButton = 3
            homeBtn.backgroundColor = .lightGray
            workBtn.backgroundColor = .lightGray
            othersBtn.backgroundColor = UIColor(hexString: "#C41210")
            homeBtn.isSelected = false
            workBtn.isSelected = false
        }
    }
}

//MARK:- TextField Delegate
extension AddNewAddressViewController {
    //MARK - UITextField Delegates
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        //For mobile numer validation
        if textField == mobileTF || textField == pincodeTF {
            let allowedCharacters = CharacterSet(charactersIn:"0123456789 ")//Here change this characters based on your requirement
            let characterSet = CharacterSet(charactersIn: string)
            return allowedCharacters.isSuperset(of: characterSet)
        }
        return true
    }
    
    // Function For textField Should Begin Editing
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        if(textField == nameTF){
            returnVal = true
        } else if(textField == mobileTF){
            if(nameTF.text!.count > 0){
                returnVal = true
                borderLabel[0].backgroundColor = #colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1)
            } else {
                alertView(Title: "Alert", messg: "First Name Text Field Must be fill")
                nameTF.shake()
                borderLabel[0].backgroundColor = #colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1)
                returnVal = false
            }
        } else if(textField == streetTF) {
            if(nameTF.text!.count > 0 && mobileTF.text!.count == 10){
                returnVal = true
                borderLabel[1].backgroundColor = #colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1)
            }else {
                alertView(Title: "Alert", messg: "Mobile no must be 10 digit")
                mobileTF.shake()
                borderLabel[1].backgroundColor = #colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1)
                returnVal = false
            }
        } else if(textField == landmarkTF) {
            
            if(nameTF.text!.count > 0 && mobileTF.text!.count == 10 && streetTF.text!.count > 0){
                returnVal = true
                borderLabel[2].backgroundColor = #colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1)
            }
            else{
                alertView(Title: "Alert", messg: "Street Field Must be fill")
                streetTF.shake()
                borderLabel[2].backgroundColor = #colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1)
                returnVal = false
            }
        } else if(textField == pincodeTF) {
            
            if(nameTF.text!.count > 0 && mobileTF.text!.count == 10 && streetTF.text!.count > 0 && landmarkTF.text!.count > 0){
                returnVal = true
                borderLabel[3].backgroundColor = #colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1)
            }else {
                alertView(Title: "Alert", messg: "Flat Number Field Must be fill")
                landmarkTF.shake()
                borderLabel[3].backgroundColor = #colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1)
                returnVal = false
            }
        } else if(textField == stateTF){
            
            if(nameTF.text!.count > 0 && mobileTF.text!.count == 10 && streetTF.text!.count > 0 && landmarkTF.text!.count > 0 && pincodeTF.text!.count > 0){
                returnVal = true
                borderLabel[4].backgroundColor = #colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1)
            }else {
                alertView(Title: "Alert", messg: "Pincode Field Must be fill")
                pincodeTF.shake()
                borderLabel[4].backgroundColor = #colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1)
                returnVal = false
            }
        } else if(textField == cityTF) {
            
            if(nameTF.text!.count > 0 && mobileTF.text!.count == 10 && streetTF.text!.count > 0 && landmarkTF.text!.count > 0 && pincodeTF.text!.count > 0 && stateTF.text!.count > 0){
                returnVal = true
                borderLabel[5].backgroundColor = #colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1)
            } else {
                alertView(Title: "Alert", messg: "State Field Must be fill")
                stateTF.shake()
                borderLabel[5].backgroundColor = #colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1)
                returnVal = false
            }
        } else if(textField == areaDropdown) {
            
            if(nameTF.text!.count > 0 && mobileTF.text!.count == 10 && streetTF.text!.count > 0 && landmarkTF.text!.count > 0 && pincodeTF.text!.count > 0 && stateTF.text!.count > 0 && cityTF.text!.count > 0){
                returnVal = true
                borderLabel[6].backgroundColor = #colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1)
            } else {
                alertView(Title: "Alert", messg: "City Field Must be fill")
                stateTF.shake()
                borderLabel[6].backgroundColor = #colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1)
                returnVal = false
            }
        }
        return returnVal
    }
    
    
    // Function For To Clear All
    func removeAll(){
        borderLabel[0].backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        borderLabel[1].backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        borderLabel[2].backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        borderLabel[3].backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        borderLabel[4].backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        borderLabel[5].backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        borderLabel[6].backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        borderLabel[7].backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
    }
}
//MARK:- API Call
extension AddNewAddressViewController {
    func addNewAddressPostData() {
        
        serviceInstance.postRequest(url: SeaMartURL.storeDeliveryAddressURL, dataDictionary: [
            "user_id": userID!,
            "user_email": emailID!,
            "name": nameTF.text!,
            "address": streetTF.text!,
            "city": "\(selectedCityId ?? "1")",
            "area_id": "\(selectedAreaId ?? "1")",
            "state": "\(selectedStateId ?? "1")",
            "country": "10",
            "pincode": pincodeTF.text!,
            "mobile": mobileTF.text!,
            "type": "\(selectedButton!)",
            "flat_number": landmarkTF.text!
        ], decodingType: AddNewAddressModel.self) { [weak self] (result) in
            // print("\(result)")
            switch result {
            case .success(let data):
                let addAddress = data
                self?.addnewAddressObject = addAddress
               // print(self?.addnewAddressObject!,"--->self?.addnewAddressObject")
                DispatchQueue.main.async {
                    if !self!.isFromNewAdd {
                        self?.callBackForAddAddress!("")
                    }
                   // self?.alertView(Title: "Success", messg: "Your address has been successfully added")
                    SCLAlertView().showSuccess("Success", subTitle: "Your address has been successfully added")
                    self?.removeAll()
                }
              //  print("addnewAddressObject\(String(describing: self?.addnewAddressObject))")
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func updateDeliveryAddressPostData() {
        serviceInstance.postRequest(url: SeaMartURL.updateDeliveryAddress, dataDictionary: [
            "da_id":dictDataItems.id!,
            "user_id": userID!,
            "user_email": emailID!,
            "name": nameTF.text!,
            "city": "\(selectedCityId ?? "1")",
            "area_id": "\(selectedAreaId ?? "1")",
            "state": "\(selectedStateId ?? "1")",
            "country": "10",
            "pincode": pincodeTF.text!,
            "mobile": mobileTF.text!,
            "type": "\(selectedButton!)",
            "flat_number": landmarkTF.text!
        ], decodingType: AddNewAddressModel.self) { [weak self] (result) in
            switch result {
            case .success(let data):
                let addAddress = data
                self?.addnewAddressObject = addAddress
                
                DispatchQueue.main.async {
                    self?.callBackForEditAddress!("")
                    SCLAlertView().showSuccess("Success", subTitle: "Your address has been successfully updated")
                    self?.removeAll()
                }
              //  print("addnewAddressObject\(String(describing: self?.addnewAddressObject))")
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    func getAllStatesdata(){
        serviceInstance.getRequest(url: SeaMartURL.getAllStatesURL, decodingType: AllStatesModel.self) { [weak self] (result) in
            
            switch result {
            case.success(let data):
                guard let stateData = data.states else {return}
                self!.allStateObject = stateData
                
                var array = [String]()
                for i in self!.allStateObject {
                    array.append(i.stateName!)
                }
                self!.stateTF.optionArray = array
                DispatchQueue.main.async {
                    self?.stateTF.didSelect(completion: { (value, index, index1) in
                        print(value,index,index1,"dggs")
                        self!.fetchCityPostData(id: "\(index+1)")
                        self!.selectedStateId = self!.allStateObject[index].id
                       // self!.fetchAreaPostData(id: "\(index+1)")
                    })
                }
                
                
                print(self!.allStateObject!)
            case .failure(let error):
                print(error.localizedDescription)
                
            }
        }
    }
    
    
    func fetchCityPostData(id:String) {
        serviceInstance.postRequest(url: SeaMartURL.fetchCityURL, dataDictionary: ["state_id":id], decodingType: FetchCityModel.self) { [weak self] (result) in
            switch result {
            case .success(let data):
                guard let fetchData = data.cities else {return}
                print(fetchData,"fetchData")
                self?.fetchCityObject = fetchData
                var cityArray = [String]()
                for i in self!.fetchCityObject {
                    cityArray.append(i.cityName!)
                }
                print(cityArray,"city")
                self!.cityTF.optionArray = cityArray
                DispatchQueue.main.async {
                    self?.cityTF.didSelect(completion: { (value, index, index1) in
                        print(value,index,index1,"Area")
                          self!.fetchAreaPostData(id: "\(index+1)")
                        self!.selectedCityId = self!.fetchCityObject[index].id
                    })
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func fetchAreaPostData(id:String) {
        serviceInstance.postRequest(url: SeaMartURL.fetchAreaURL, dataDictionary: ["city_id":id], decodingType: FetchAreaModel.self) { [weak self] (result) in
            switch result {
            case .success(let data):
                guard let fetchData = data.areaNames else {return}
                self?.fetchAreaObject = fetchData
                var areaArray = [String]()
                for i in self!.fetchAreaObject {
                    areaArray.append(i.areaName!)
                }
                print(areaArray,"areaarray")
                DispatchQueue.main.async {
                    self?.areaDropdown.optionArray = areaArray
                    self?.areaDropdown.didSelect(completion: { (value, index, index1) in
                        print(value,index,index1,"Area")
                        self!.selectedAreaId = self!.fetchAreaObject[index].id
                    })
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
