//
//  CheckoutViewController.swift
//  SeaMartApp
//
//  Created by mehtab alam on 13/02/2021.
//

import UIKit
import DLRadioButton
import Razorpay
import SafariServices
import Alamofire
class CheckoutViewController: UIViewController {

    @IBOutlet weak var checkoutUpperView: UIView!
    @IBOutlet weak var proceedBtn: UIButton!
    
   static let themeColor: UIColor = UIColor.rgb(red: 244, green: 155, blue: 15)
    private var containerViewHeightConstraint: NSLayoutConstraint!
    private var serviceInstance = Service()
    
    var userPhone:String!
    var userEmail:String!
    var userID:String!
    var addressID:String!
    var billDetail:BillDetailsModel!
    var razorpayObj : RazorpayCheckout? = nil
    var couponCode:String!
    var createOrder:CreateOrderIDModel!
    
    // radio button
    private var radioButtons = [DLRadioButton]()
    public var selectedRadioButton: Int = 11
    //11 -> COD
    //12 -> CArdPayment/RazorPay
    
    // MARK:- UI Components
    let containerView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.clear
       // view.backgroundColor = .blue
        view.clipsToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let radioButtonContainer1: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
       // view.backgroundColor = .red
//        view.layer.cornerRadius = 6
//        view.layer.borderWidth = 1
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    let radioButtonContainer2: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
       // view.backgroundColor = .green
//        view.layer.cornerRadius = 6
//        view.layer.borderWidth = 1
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let rbCard: DLRadioButton = {
        let radioButton = DLRadioButton()
        radioButton.isMultipleSelectionEnabled = false
        radioButton.titleLabel!.font = UIFont.systemFont(ofSize: 19)
        radioButton.setTitle("Credit/Debit Card", for: .normal)
        radioButton.titleLabel?.numberOfLines = 0
        radioButton.titleLabel?.lineBreakMode = .byWordWrapping
        radioButton.setTitleColor(.black, for: .normal)
        radioButton.setTitleColor(themeColor, for: UIControl.State.selected)
        radioButton.iconSize = 20
        radioButton.indicatorSize = 8
        radioButton.marginWidth = 4
        radioButton.iconColor = .black
        radioButton.indicatorColor = themeColor
        radioButton.clipsToBounds = true
        radioButton.contentHorizontalAlignment = UIControl.ContentHorizontalAlignment.left
        radioButton.tag = 1
        radioButton.translatesAutoresizingMaskIntoConstraints = false
        return radioButton
    }()
    private let rbCOD: DLRadioButton = {
        let radioButton = DLRadioButton()
        radioButton.isMultipleSelectionEnabled = false
        radioButton.titleLabel!.font = UIFont.systemFont(ofSize: 19)
        radioButton.setTitle("Cash On Delivery(COD)", for: .normal)
        radioButton.titleLabel?.numberOfLines = 0
        radioButton.titleLabel?.lineBreakMode = .byWordWrapping
        radioButton.setTitleColor(.black, for: .normal)
        radioButton.setTitleColor(themeColor, for: UIControl.State.selected)
        radioButton.iconSize = 20
        radioButton.indicatorSize = 8
        radioButton.marginWidth = 4
        radioButton.iconColor = .black
        radioButton.indicatorColor = themeColor
        radioButton.clipsToBounds = true
        radioButton.contentHorizontalAlignment = UIControl.ContentHorizontalAlignment.left
        radioButton.tag = 2
        radioButton.translatesAutoresizingMaskIntoConstraints = false
        return radioButton
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print(addressID ?? "","addressID2")
        setUpView()
    
        userEmail = singleton.shared.getFromDefault(Key: DefaultKeys.email) as? String
        userPhone = singleton.shared.getFromDefault(Key: DefaultKeys.mobile) as? String
        userID = singleton.shared.getFromDefault(Key: DefaultKeys.userId) as? String
        
        rbCOD.sendActions(for: .touchUpInside)
    }
    
    @IBAction func clickProceed(_ sender: Any) {
        if self.selectedRadioButton == 12 {
            self.creatOrderID()
            proceedBtn.isEnabled = false
//            self.test()
            //self.openRazorpayCheckout(orderId: "")
        } else {
            self.placeOrderPostData(paymentID: "")
            proceedBtn.isEnabled = false
        }
    }
    
    @IBAction func clickBackBtn(_ sender: Any) {
        self.addressID = nil
        self.navigationController?.popViewController(animated: true)
    }
    
    func setUpView() {
        //containerview
        view.addSubview(containerView)
        containerView.topAnchor.constraint(equalTo: checkoutUpperView.bottomAnchor, constant: 20).isActive = true
        containerView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 0).isActive = true
        containerView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 0).isActive = true
        containerViewHeightConstraint = NSLayoutConstraint(item: containerView, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 100)
        containerViewHeightConstraint.isActive = true
        
        // radioButtonContainer1
        containerView.addSubview(radioButtonContainer1)
        radioButtonContainer1.topAnchor.constraint(equalTo: containerView.topAnchor).isActive = true
        radioButtonContainer1.leftAnchor.constraint(equalTo: containerView.leftAnchor, constant: 20).isActive = true
        radioButtonContainer1.rightAnchor.constraint(equalTo: containerView.rightAnchor, constant: -20).isActive = true
        radioButtonContainer1.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        //rbCard Radio Button
        radioButtonContainer1.addSubview(rbCard)
        rbCard.addTarget(self, action: #selector(radioButtonSelected(_:)), for: UIControl.Event.touchUpInside)
        rbCard.topAnchor.constraint(equalTo: radioButtonContainer1.topAnchor, constant: 5).isActive = true
        rbCard.bottomAnchor.constraint(equalTo: radioButtonContainer1.bottomAnchor, constant: 5).isActive = true
        rbCard.leftAnchor.constraint(equalTo: radioButtonContainer1.leftAnchor, constant: 10).isActive = true
        rbCard.rightAnchor.constraint(equalTo: radioButtonContainer1.rightAnchor, constant: -10).isActive = true
        
        // radioButtonContainer2
        containerView.addSubview(radioButtonContainer2)
        radioButtonContainer2.topAnchor.constraint(equalTo: radioButtonContainer1.bottomAnchor, constant: 20).isActive = true
        radioButtonContainer2.leftAnchor.constraint(equalTo: containerView.leftAnchor, constant: 20).isActive = true
        radioButtonContainer2.rightAnchor.constraint(equalTo: containerView.rightAnchor, constant: -20).isActive = true
        radioButtonContainer2.bottomAnchor.constraint(equalTo: containerView.bottomAnchor).isActive = true
       // radioButtonContainer2.heightAnchor.constraint(equalToConstant: 60).isActive = true
        
        //rbCard Radio Button
        radioButtonContainer2.addSubview(rbCOD)
        rbCOD.addTarget(self, action: #selector(radioButtonSelected(_:)), for: UIControl.Event.touchUpInside)
        rbCOD.topAnchor.constraint(equalTo: radioButtonContainer2.topAnchor, constant: 5).isActive = true
        rbCOD.bottomAnchor.constraint(equalTo: radioButtonContainer2.bottomAnchor, constant: 5).isActive = true
        rbCOD.leftAnchor.constraint(equalTo: radioButtonContainer2.leftAnchor, constant: 10).isActive = true
        rbCOD.rightAnchor.constraint(equalTo: radioButtonContainer2.rightAnchor, constant: -10).isActive = true
    }
    
    @objc private func radioButtonSelected(_ radioButton: DLRadioButton) {
        guard let tag = radioButton.selected()?.tag else { return }
        
        if tag == rbCard.tag {
            print("rbCard")
            self.selectedRadioButton = 12
            rbCOD.isSelected = false
        } else {
            print("rbCOD")
            self.selectedRadioButton = 11
            rbCard.isSelected = false
        }
    }

}

// RazorpayPaymentCompletionProtocol - This will execute two methods 1.Error and 2. Success case. On payment failure you will get a code and description. In payment success you will get the payment id.
extension CheckoutViewController : RazorpayPaymentCompletionProtocol {
    func openRazorpayCheckout(orderId:String) {
        if billDetail == nil {
            return
        }
        // 1. Initialize razorpay object with provided key. Also depending on your requirement you can assign delegate to self. It can be one of the protocol from RazorpayPaymentCompletionProtocolWithData, RazorpayPaymentCompletionProtocol.
        razorpayObj = RazorpayCheckout.initWithKey(DefaultKeys.razorPayLiveKey, andDelegate: self)
        let options: [AnyHashable:Any] = [
            "prefill": [
                "contact": "\(userPhone ?? ""))",
                "email": "\(userEmail ?? "")"
            ],
            "image": "placeholder",
            "order_id": orderId,
            "currency": "INR",
            "amount" : 100,//Double(billDetail.grand_total!) * 100,
            "name": "Fish",
            "theme": [
                "color": "#C41210",
            ]
        ]
        if let rzp = self.razorpayObj {
            DispatchQueue.main.async {
                rzp.open(options)
            }

        } else {
            print("Unable to initialize")
        }
    }

    func onPaymentError(_ code: Int32, description str: String) {
        print("error: ", code, str)
        if code == 2 {
//           // self.navigationController?.popToRootViewController(animated: true)
        }
    }

    func onPaymentSuccess(_ payment_id: String) {
        print("success: ", payment_id)
//        self.capturePayment(paymentID: payment_id)
        self.placeOrderPostData(paymentID: payment_id)
    }
}
extension CheckoutViewController {
    func creatOrderID() {

        let user = DefaultKeys.razorPayLiveKey
        let password = DefaultKeys.razorPayLiveSecretKey
        let credentialData = "\(user):\(password)".data(using: String.Encoding.utf8)!
        let base64Credentials = credentialData.base64EncodedString(options: [])

        let headers = [
            "Authorization": "Basic \(base64Credentials)",
            "Content-Type" : "application/json"
        ]
        var param = [String:Any]()
        param = [
            "currency": "INR",
            "receipt": "1",
            "amount": 100,//Double(billDetail.grand_total!)*100,
            "payment_capture": 1,
        ]

        let url = SeaMartURL.createOrderID

        var request = URLRequest(url: URL.init(string: url)!)
        request.httpMethod = "POST"
        request.httpBody = try? JSONSerialization.data(withJSONObject: param)
        request.allHTTPHeaderFields = headers

        //Now use this URLRequest with Alamofire to make request
        AF.request(request).responseJSON { response in
            //Your code
            print( response)
            switch response.result{
            case.success(let value):
                print(value)
                do {
                    self.createOrder = try JSONDecoder().decode(CreateOrderIDModel.self, from: response.data!)

                    if self.createOrder.id != nil {
                        self.openRazorpayCheckout(orderId: self.createOrder.id!)
                    }

                } catch {
                    print(error)
                }
            case .failure(let error):
                print(error)
            }

        }
    }

    func placeOrderPostData(paymentID: String) {
        let service = SeaMartURL.placeOrderURL
            serviceInstance.postRequest(url: service, dataDictionary:
                                            ["payment_method": self.selectedRadioButton == 12 ? "Razorpay" : "CashonDelivery",
                                             "user_email":userEmail,
                                             "phone":userPhone,
                                             "user_id":userID,
                                             "da_id":"\(addressID ?? "da-id")",
                                             "shipping_charges":billDetail.shippingCharges!,
                                             "grand_total":"\(billDetail.grand_total ?? 0)",
                                             "coupon_code":"\(couponCode!)",
                                             "coupon_amount":"\(billDetail.coupon_discount ?? 0)",
                                             "razorpay_order_id": self.createOrder != nil ? self.createOrder.id! : "",
                                             "razorpay_payment_id": paymentID,
                                             "payment": "success",
                                             "order_date":"2021-01-15",
                                             "payment_date":"2021-01-15"]
                , decodingType: ModelOrederDetail.self) { [weak self] (result) in
                switch result {
                case .success(let data):
                    var orderID = 0
                    if let id = data.orderId {
                        orderID = id
                        print("OrderID -> \(orderID)")
                    }
                    if data.status == "Thanks" {
                        DispatchQueue.main.async {
                            let viewVC = self!.storyboard?.instantiateViewController(withIdentifier: "OrderSuccessFullCODViewController") as! OrderSuccessFullCODViewController
                            viewVC.orderID = "\(orderID)"
                            viewVC.totalAmount = data.grandTotal!
                            //  self!.present(viewVC, animated: true, completion: nil)
                            self!.navigationController?.pushViewController(viewVC, animated: true)
                        }
                    } else if data.status == "razorpay" {
                        DispatchQueue.main.async {
                            let viewVC = self!.storyboard?.instantiateViewController(withIdentifier: "OrderSuccessFullPaymentViewController") as! OrderSuccessFullPaymentViewController
                            viewVC.orderID = "\(orderID)"
                            viewVC.totalAmount = data.grandTotal!
                            //  self!.present(viewVC, animated: true, completion: nil)
                            self!.navigationController?.pushViewController(viewVC, animated: true)
                        }
                    } else {
                        self?.alertView(Title: "Alert", messg: data.status!)
                    }


                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        }

}
//MARK: - MODEL
struct ModelOrederDetail :Codable {

    let grandTotal : String?
    let orderId : Int?
    let status : String?
    
    enum CodingKeys: String, CodingKey {
        case grandTotal = "grand_total"
        case orderId = "order_id"
        case status = "status"
    }
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        grandTotal = try values.decodeIfPresent(String.self, forKey: .grandTotal)
        orderId = try values.decodeIfPresent(Int.self, forKey: .orderId)
        status = try values.decodeIfPresent(String.self, forKey: .status)
    }
    
}

extension CheckoutViewController : SFSafariViewControllerDelegate {
    
    func safariViewControllerDidFinish(_ controller: SFSafariViewController) {
        controller.dismiss(animated: true, completion: nil)
    }
}
struct CreateOrderIDModel : Codable {

    let amount : Int?
    let amountDue : Int?
    let amountPaid : Int?
    let attempts : Int?
    let createdAt : Int?
    let currency : String?
    let entity : String?
    let id : String?
    let notes : Note?
    let offerId : String?
    let receipt : String?
    let status : String?


    enum CodingKeys: String, CodingKey {
        case amount = "amount"
        case amountDue = "amount_due"
        case amountPaid = "amount_paid"
        case attempts = "attempts"
        case createdAt = "created_at"
        case currency = "currency"
        case entity = "entity"
        case id = "id"
        case notes
        case offerId = "offer_id"
        case receipt = "receipt"
        case status = "status"
    }
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        amount = try values.decodeIfPresent(Int.self, forKey: .amount)
        amountDue = try values.decodeIfPresent(Int.self, forKey: .amountDue)
        amountPaid = try values.decodeIfPresent(Int.self, forKey: .amountPaid)
        attempts = try values.decodeIfPresent(Int.self, forKey: .attempts)
        createdAt = try values.decodeIfPresent(Int.self, forKey: .createdAt)
        currency = try values.decodeIfPresent(String.self, forKey: .currency)
        entity = try values.decodeIfPresent(String.self, forKey: .entity)
        id = try values.decodeIfPresent(String.self, forKey: .id)
        notes = try Note(from: decoder)
        offerId = try values.decodeIfPresent(String.self, forKey: .offerId)
        receipt = try values.decodeIfPresent(String.self, forKey: .receipt)
        status = try values.decodeIfPresent(String.self, forKey: .status)
    }


}
struct Note : Codable {

    let notesKey1 : String?
    let notesKey2 : String?


    enum CodingKeys: String, CodingKey {
        case notesKey1 = "notes_key_1"
        case notesKey2 = "notes_key_2"
    }
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        notesKey1 = try values.decodeIfPresent(String.self, forKey: .notesKey1)
        notesKey2 = try values.decodeIfPresent(String.self, forKey: .notesKey2)
    }
}

//MARK:- If we require capture ID
//func capturePayment(paymentID:String) {
//        let user = DefaultKeys.razorPayLiveKey
//        let password = DefaultKeys.razorPayLiveSecretKey
//        let credentialData = "\(user):\(password)".data(using: String.Encoding.utf8)!
//        let base64Credentials = credentialData.base64EncodedString(options: [])
//        let headers = ["Authorization": "Basic \(base64Credentials)"]
//
//        var param = [String:Any]()
//
////        param = ["amount":100,
////                 "currency":"INR"]
//
//        let url = URL(string:"https://api.razorpay.com/v1/payments/" + "\(paymentID)" + "/capture")
//        print(url!)
//
//        var request = URLRequest(url: url!)
//        request.httpMethod = "POST"
//        request.httpBody = try? JSONSerialization.data(withJSONObject: param)
//        request.allHTTPHeaderFields = headers
//
//        AF.request(request).responseJSON { response in
//            //Your code
//            print( response)
//            switch response.result{
//            case.success(let value):
//                print(value)
//                self.placeOrderPostData(paymentID: paymentID)
//            case .failure(let error):
//                print(error)
//            }
//
//        }
//    }
