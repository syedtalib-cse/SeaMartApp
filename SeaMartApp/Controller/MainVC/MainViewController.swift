//
//  MainViewController.swift
//  SeaMartApp
//
//  Created by mehtab alam on 05/02/2021.
//

import UIKit
import CoreLocation
class MainViewController: UIViewController, CLLocationManagerDelegate {
    
    //MARK:- IBOutlet
    @IBOutlet weak var categoryCollectionView: UICollectionView!
    @IBOutlet weak var bestDealCollectionView: UICollectionView!
    @IBOutlet weak var popularCutsCollectionView: UICollectionView!
    @IBOutlet weak var sliderCollectionView: UICollectionView!
    @IBOutlet weak var searchField: UISearchBar!
    @IBOutlet weak var lblLocation: UILabel!
    @IBOutlet weak var lblPincode: UILabel!
    
    
    //MARK:- Variable Declaration
    private var parentObject:[Parent_categories] = [Parent_categories]()
    private var trendingObject:[Trending_products] = [Trending_products]()
    private var bestDealObject:[Best_deal_products] = [Best_deal_products]()
    private var sliderObject:[Slider_banners] = [Slider_banners]()
    var userCartObj:[UserCarts] = [UserCarts]()
    
    //MARK:- UI components for showing Messege view
    private let messageView: OSOMessageView = {
        let view = OSOMessageView(showCancelButton: false, addBlurBackground: true)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private var serviceInstance = Service()
    private var timer:Timer?
    private var currentIndex = 0
    var locationManager:CLLocationManager!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Get Location Permission
        locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestAlwaysAuthorization()
        
        if CLLocationManager.locationServicesEnabled(){
            locationManager.startUpdatingLocation()
        }
        
        getServerdata()
        setTimer()
        searchField.delegate = self
        
        //activity indicator function call
        showActivityIndicator(messageView:messageView)
        
        let email = singleton.shared.getFromDefault(Key: DefaultKeys.email)
        let mobile = singleton.shared.getFromDefault(Key: DefaultKeys.mobile)
        let userId = singleton.shared.getFromDefault(Key: DefaultKeys.userId)
        let cityName = singleton.shared.getFromDefault(Key: DefaultKeys.cityName)
        let pincode = singleton.shared.getFromDefault(Key: DefaultKeys.pincode)

        print(email,"emailll")
        print(mobile,"mobile")
        print(userId,"userId")
        print(cityName,"cityName")
        print(pincode,"pincode")
    }
    
    //MARK:- viewWillAppear and disappear for hidding and showing navigation Bar in next viewcontroller
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // Hide the navigation bar on the this view controller
        if let pincode = singleton.shared.getFromDefault(Key: DefaultKeys.pincode) as? String {
            self.lblPincode.text = pincode
        }
        if let location = singleton.shared.getFromDefault(Key: DefaultKeys.cityName) as? String {
            self.lblLocation.text = location
        }
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        // Show the navigation bar on other view controllers
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
        
    }
    
}
//MARK:- Event Handler
extension MainViewController {
    @IBAction func tapProfileBtn(_ sender: Any) {
        let VC = self.storyboard?.instantiateViewController(withIdentifier: "MyProfileViewController") as! MyProfileViewController
        self.navigationController?.pushViewController(VC, animated: true)
    }
    @IBAction func tapBasketBtn(_ sender: Any) {
        let viewVC = self.storyboard?.instantiateViewController(withIdentifier: "TrackYourOrderViewController") as! TrackYourOrderViewController
      //  viewVC.userCartObj = self.userCartObj
        self.navigationController?.pushViewController(viewVC, animated: true)
    }
    @IBAction func tapNotificationBtn(_ sender: Any) {
    }
    @IBAction func clickOnLocation(_ sender: Any) {
        print("buttonClick")
        let viewVC = self.storyboard?.instantiateViewController(withIdentifier: "SelectCityViewController2") as! SelectCityViewController2
        viewVC.isFromHome = true
       // viewVC.pincode = self.lblPincode.text!
        self.navigationController?.pushViewController(viewVC, animated: true)
    }
}
//MARK:- API CALL
extension MainViewController {
    func getServerdata(){
        serviceInstance.getRequest(url: SeaMartURL.homeURL, decodingType: HomeModel.self) { (result) in
            
            switch result {
            case.success(let data):
                guard let parentData = data.home?.parent_categories else {return}
                guard let trendingData = data.home?.trending_products else {return}
                guard let bestDealData = data.home?.best_deal_products else {return}
                guard let sliderData = data.home?.slider_banners else {return}
                self.parentObject = parentData
                self.trendingObject = trendingData
                self.bestDealObject = bestDealData
                self.sliderObject = sliderData
                DispatchQueue.main.async {
                    self.messageView.isHidden = true
                    self.messageView.animateActivityIndicator(animate: false)
                    self.categoryCollectionView.reloadData()
                    self.bestDealCollectionView.reloadData()
                    self.popularCutsCollectionView.reloadData()
                    self.sliderCollectionView.reloadData()
                }
            case .failure(let error):
                print(error.localizedDescription)
                self.messageView.isHidden = false
                self.messageView.animateActivityIndicator(animate: true)
            }
        }
    }
}

//MARK:- Timer
extension MainViewController {
    func setTimer() {
        timer = Timer.scheduledTimer(timeInterval: 2.0, target: self, selector: #selector(slideToNext), userInfo: nil, repeats: true)
    }
    
    @objc func slideToNext() {
        if currentIndex < sliderObject.count {
            let indexPath = IndexPath.init(item: currentIndex, section: 0)
            sliderCollectionView.scrollToItem(at: indexPath, at: .right, animated: true)
            currentIndex += 1
        } else {
            currentIndex = 0
        }
    }
}

//MARK:- Extention for UICollectionViewDelegate & DataSource
extension MainViewController: UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        switch collectionView {
        case self.categoryCollectionView:
            return parentObject.count
        case self.bestDealCollectionView:
            return bestDealObject.count
        case self.popularCutsCollectionView:
            return trendingObject.count
        case self.sliderCollectionView:
            return sliderObject.count
        default:
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if collectionView == self.sliderCollectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SliderCollectionViewCell", for: indexPath) as! SliderCollectionViewCell
            // guard let object = sliderObject else {return cell1}
            let sliderData = sliderObject[indexPath.row]
            cell.configCellForSlider(data: sliderData)
            return cell
            
        } else if collectionView == self.categoryCollectionView {
            let cell1 = collectionView.dequeueReusableCell(withReuseIdentifier: "MainCollectionViewCell", for: indexPath) as! MainCollectionViewCell
            // guard let object = parentObject else {return cell1}
            let parentCategoryData = parentObject[indexPath.row]
            cell1.configCellForParentCategory(data: parentCategoryData)
            return cell1
            
        } else if collectionView == self.bestDealCollectionView {
            let cell2 = collectionView.dequeueReusableCell(withReuseIdentifier: "BestDealCollectionViewCell", for: indexPath) as! BestDealCollectionViewCell
            let bestDealData = bestDealObject[indexPath.row]
            cell2.configCellForBestDeal(data: bestDealData)
            //  cell2.addShadowInView()
            cell2.ViewRoundCorners(corners: [.allCorners], radius: 15)
            return cell2
        } else {
            let cell3 = collectionView.dequeueReusableCell(withReuseIdentifier: "PopularCutCollectionViewCell", for: indexPath) as! PopularCutCollectionViewCell
            let popularCutData = trendingObject[indexPath.row]
            cell3.configCellForPopularCut(data: popularCutData)
            // cell3.addShadowInView()
            cell3.ViewRoundCorners(corners: [.allCorners], radius: 15)
            return cell3
        }
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == self.categoryCollectionView {
            let CVC = self.storyboard?.instantiateViewController(withIdentifier: "CategoryViewController") as! CategoryViewController
          //  guard let object = parentObject else {return}
            CVC.pincode = self.lblPincode.text!
            CVC.categorystore = parentObject[indexPath.row].id
            self.navigationController?.pushViewController(CVC, animated: true)
            print("-------------CategoryViewController-------------")
        }
        else if collectionView == self.bestDealCollectionView {
            let BDDVC = self.storyboard?.instantiateViewController(withIdentifier: "BestDealDetailViewController") as! BestDealDetailViewController
            BDDVC.pincode = self.lblPincode.text!
            BDDVC.attributeProductID = bestDealObject[indexPath.row].id
            BDDVC.singleProductID = bestDealObject[indexPath.row].id
            self.navigationController?.pushViewController(BDDVC, animated: true)
            print("-------------BestDealDetailViewController-------------")
        } else {
            let BDDVC = self.storyboard?.instantiateViewController(withIdentifier: "BestDealDetailViewController") as! BestDealDetailViewController
            BDDVC.pincode = self.lblPincode.text!
            BDDVC.attributeProductID = trendingObject[indexPath.row].id
            BDDVC.singleProductID = trendingObject[indexPath.row].id
            self.navigationController?.pushViewController(BDDVC, animated: true)
            print("-------------BestDealDetailViewController-------------")
        }
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == self.categoryCollectionView {
            return CGSize(width: 90, height: 90)
        } else if collectionView == self.bestDealCollectionView {
            return CGSize(width: 165, height: 210)
        } else if collectionView == self.popularCutsCollectionView  {
            return CGSize(width: 165, height: 210)
        } else {
            return CGSize(width: self.sliderCollectionView.frame.size.width, height: 150)
            
        }
    }
}

//MARK: - SearchBar Delegate Methods
extension MainViewController:UISearchBarDelegate {
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        self.searchField.endEditing(true)
        let VC = self.storyboard?.instantiateViewController(withIdentifier: "SearchProductViewController") as! SearchProductViewController
        self.navigationController?.pushViewController(VC, animated: true)
    }
}
//Mark:- Shortcut key for xcode
// 1. for autocomplete suggestion -> control + space
// 2. to open new file  -> command + shift + O
// 3. to open new library  -> command + shift + L
// 4. to jump one file to another file  -> command + J
// 5. for multiple edit  -> command + control + E
// 6. to jump on particular function  -> control + 6
// 7. to fold all function  -> command + shift + Option + backarrow
// 8. to unfold all function  -> command + shift + Option + frontarrow
// 7. to fold particular function  -> command + Option + backarrow
// 8. to unfold particular function  -> command + Option + frontarrow
// 9. to open tab  -> command + T
// 10. to close tab  -> command + W
// 11. to move particular line of code up and down  -> command + alt + [ ,or ]
// 11. to move more line of code left and right  -> command + [ ,or ]
