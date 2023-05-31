//
//  CategoryViewController.swift
//  SeaMartApp
//
//  Created by mehtab alam on 09/02/2021.
//

import UIKit

class CategoryViewController: UIViewController {
    
    @IBOutlet weak var subCatCollectionView: UICollectionView!
    @IBOutlet weak var CategoryCollectionView: UICollectionView!
    @IBOutlet weak var parentCategoryCollectionView: UICollectionView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    //MARK:- Variable Declaration
    private var serviceInstance = Service()
    var categorystore:String!
    var categoryID:String!
    var pincode = String()
    
    private var isSubCategorySelected = false
    
    //MARK:- UI components for showing Messege view
    private let messageView: OSOMessageView = {
        let view = OSOMessageView(showCancelButton: false, addBlurBackground: true)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private var arraySubCategories:[Productsbycategory] = []
    private var subCategoryObj:[Subcat_names] = []
    private var arraySubCategoryData:[ProductsByChildCategory] = []
    private var parentObject:[Parent_categories] = [Parent_categories]()
    private var trendingObject:[Trending_products] = [Trending_products]()
    private var bestDealObject:[Best_deal_products] = [Best_deal_products]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(pincode,"new pincode")
        
        getProductByCatPostData(id: categorystore)
        getSubCatPostData(id: categorystore)
        getParentCategorydata()
        //  searchBar.layer.cornerRadius = 15
          showActivityIndicator(messageView:messageView)
    }
}
//MARK:-Event Handler
extension CategoryViewController {
    @IBAction func OnClickBackButton(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
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
}

//MARK:-API Call
extension CategoryViewController {
    
    func getParentCategorydata() {
        serviceInstance.getRequest(url: SeaMartURL.homeURL, decodingType: HomeModel.self) { (result) in
            
            switch result {
            case.success(let data):
//                print(data)
                guard let parentData = data.home?.parent_categories else {return}
                self.parentObject = parentData
                DispatchQueue.main.async {
                    self.messageView.isHidden = true
                    self.messageView.animateActivityIndicator(animate: false)
                    self.parentCategoryCollectionView.reloadData()
                }
            case .failure(let error):
                print(error.localizedDescription)
                self.messageView.isHidden = false
                self.messageView.animateActivityIndicator(animate: true)
            }
        }
    }
    
    func getProductByCatPostData(id:String) {
        serviceInstance.postRequest(url: SeaMartURL.GetProductsbyCatURL, dataDictionary: ["parent_category_id":id], decodingType: ProductsbycategoryModel.self) { [weak self] (result) in
            switch result {
            case .success(let data):
                self?.arraySubCategories.removeAll()
                guard let productBycat = data.productsbycategory else {return}
                
                self?.arraySubCategories = productBycat
                print("arraySubCategories count --> \(self!.arraySubCategories.count)","123")
                DispatchQueue.main.async {
                    self?.messageView.isHidden = true
                    self?.messageView.animateActivityIndicator(animate: false)
                    self?.subCatCollectionView.reloadData()
                    self!.CategoryCollectionView.reloadData()
                }
            case .failure(let error):
                print(error.localizedDescription)
                DispatchQueue.main.async {
                    self?.messageView.isHidden = false
                    self?.messageView.animateActivityIndicator(animate: true)
                }
            }
        }
    }
    
    func getSubCatPostData(id:String) {
        serviceInstance.postRequest(url: SeaMartURL.GetSubCategoryNameByParentIDURL, dataDictionary: ["parent_id":id], decodingType: SubCatModel.self) { [weak self] (result) in
            switch result {
            case .success(let data):
                guard let productBySubcat = data.subcat_names else {return}
                self?.subCategoryObj = productBySubcat
                print("subCategoryObj count --> \(self!.subCategoryObj.count)","123")
                DispatchQueue.main.async {
                    self?.messageView.isHidden = true
                    self?.messageView.animateActivityIndicator(animate: false)

                    self!.subCatCollectionView.reloadData()
                    self?.CategoryCollectionView.reloadData()
                    //By default select first row
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
//                        if self!.arraySubCategories.count == 0 {
//                            self!.CategoryCollectionView.isHidden = true
//                        } else {
//                            self!.CategoryCollectionView.isHidden = false
//                        }
                        //Get all cell from collectionview
                        for row in 0...self!.subCatCollectionView.numberOfItems(inSection: 0) {
                            let indexPath = IndexPath.init(item: row, section: 0)
                            if let cell = self!.subCatCollectionView.cellForItem(at: indexPath) as? SubCatNameCollectionViewCell {
                                switch row {
                                //by default first one selected
                                case 0 :
                                    cell.subCatNameLbl.backgroundColor = UIColor(hexString: "#C41210")
                                    self?.subCategoryObj[row].isSelected = true
                                default :
                                    cell.subCatNameLbl.backgroundColor = .lightGray
                                    self?.subCategoryObj[row].isSelected = false
                                }
                            }
                        }
                    }
                }
            case .failure(let error):
                print(error.localizedDescription)
                DispatchQueue.main.async {
                    self?.messageView.isHidden = false
                    self?.messageView.animateActivityIndicator(animate: true)
                }
            }
        }
    }
    
    func getProductChildCatPostData(id: String) {
        serviceInstance.postRequest(url: SeaMartURL.GetProductBySubCategoryURL, dataDictionary: ["child_category_id":id], decodingType: ProductsByChildModel.self) { [weak self] (result) in
            switch result {
            case .success(let data):
                self?.arraySubCategoryData.removeAll()
                if let productByChildcat = data.productsByChildCategory, productByChildcat.count > 0 {
                    //print("No data received")
                    
                    self?.arraySubCategoryData = productByChildcat
                  //  print("arraySubCategoryData count --> \(self!.arraySubCategoryData.count)","456")
                } else {
                   // print("arraySubCategoryData count --> \(data.productsByChildCategory?.count)","456")
                    //Alret for no data
                    DispatchQueue.main.async {
                   // self?.showToast(message: "NO DATA..")
                   // self!.CategoryCollectionView.isHidden = true
                    }
                    //self?.messageView.showMessage(message: "NO DATA")
                }
                DispatchQueue.main.async {
                    self?.subCatCollectionView.reloadData()
                    self!.CategoryCollectionView.reloadData()
                    self?.messageView.isHidden = true
                    self?.messageView.animateActivityIndicator(animate: false)
                }
            case .failure(let error):
                print(error.localizedDescription)
            self?.messageView.isHidden = false
            self?.messageView.animateActivityIndicator(animate: true)
            }
        }
    }
}

//MARK:-Collectionview delegate datasource
extension CategoryViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch collectionView {
        case self.CategoryCollectionView:
            if self.isSubCategorySelected {
               return arraySubCategoryData.count
            } else {
                return arraySubCategories.count
            }
        case self.parentCategoryCollectionView:
            return parentObject.count
        case self.subCatCollectionView:
            return subCategoryObj.count
        default:
            print("default")
            return 0
        }
//        if collectionView == self.CategoryCollectionView {
//            return isSubCategorySelected ? (arraySubCategoryData.count) : (arraySubCategories.count)
//        } else if collectionView == self.parentCategoryCollectionView {
//
//        }
//            else {
//            return subCategoryObj.count
//        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == self.CategoryCollectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CategoryCollectionViewCell", for: indexPath) as! CategoryCollectionViewCell
            if isSubCategorySelected {
                let subCategoryData = self.arraySubCategoryData[indexPath.row]
                cell.configCellUsingSubCategory(data: subCategoryData)
            } else {
               // if arraySubCategories.count != nil {
                if self.arraySubCategories.count >= indexPath.row {
                let categoryData = self.arraySubCategories[indexPath.row]
                cell.configCellForCategory(data: categoryData)
                }
             //   }
            }
            cell.viewDetail3.layer.cornerRadius = 6
            cell.ViewRoundCorners(corners: [.allCorners], radius: 15)
            //  cell.backgroundColor = .systemGray5
            return cell
        } else if collectionView == self.parentCategoryCollectionView {
            let cell1 = collectionView.dequeueReusableCell(withReuseIdentifier: "MainCollectionViewCell", for: indexPath) as! MainCollectionViewCell
            // guard let object = parentObject else {return cell1}
            let parentCategoryData = parentObject[indexPath.row]
            cell1.configCellForParentCategory(data: parentCategoryData)
            return cell1
            
        }else {
            let cell2 = collectionView.dequeueReusableCell(withReuseIdentifier: "SubCatNameCollectionViewCell", for: indexPath) as! SubCatNameCollectionViewCell
            let subCategoryData = subCategoryObj[indexPath.row]
            cell2.configCellForSubCategory(data: subCategoryData)
            
            //Selection cell label
            if subCategoryData.isSelected == true {
                cell2.subCatNameLbl.backgroundColor = UIColor(hexString: "#C41210")
            } else {
                cell2.subCatNameLbl.backgroundColor = .lightGray
            }
            return cell2
        }
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == subCatCollectionView {
            if let cell = collectionView.cellForItem(at: indexPath) as? SubCatNameCollectionViewCell {
                cell.subCatNameLbl.backgroundColor = UIColor(hexString: "#C41210")
                self.subCategoryObj[indexPath.row].isSelected = true
            }
            if let defaultIdSelection = subCategoryObj[indexPath.row].id {
                if self.subCategoryObj[indexPath.row].name?.lowercased() == "all" {
                    isSubCategorySelected = false
                    //For All section API
                    getProductByCatPostData(id: categorystore)
                } else {
                    isSubCategorySelected = true
                    //For other section API
                    getProductChildCatPostData(id: defaultIdSelection)
                }
            }
            //Set cell selection on tap
            for (index, _) in self.subCategoryObj.enumerated() {
                if let cell = self.subCatCollectionView.cellForItem(at: indexPath) as? SubCatNameCollectionViewCell {
                    if indexPath.row == index {
                        cell.subCatNameLbl.backgroundColor = UIColor(hexString: "#C41210")
                        self.subCategoryObj[index].isSelected = true
                    } else {
                        cell.subCatNameLbl.backgroundColor = .lightGray
                        self.subCategoryObj[index].isSelected = false
                    }
                }
            }
            
        } else if collectionView == self.parentCategoryCollectionView {
            if let id = parentObject[indexPath.row].id {
                print(id,"id")
                self.showActivityIndicator(messageView:self.messageView)
                DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(3)) {

                    self.isSubCategorySelected = false
                    self.getProductByCatPostData(id: id)
                    self.getSubCatPostData(id: id)
                  //  self.getProductChildCatPostData(id: id)
                }
            }
        }
        else {
            let BDDVC = self.storyboard?.instantiateViewController(withIdentifier: "BestDealDetailViewController") as! BestDealDetailViewController
            if !isSubCategorySelected {
                BDDVC.attributeProductID = arraySubCategories[indexPath.row].id
                BDDVC.singleProductID = arraySubCategories[indexPath.row].id
                BDDVC.pincode = pincode

            } else {
                BDDVC.attributeProductID = arraySubCategoryData[indexPath.row].id
                BDDVC.singleProductID = arraySubCategoryData[indexPath.row].id
                BDDVC.pincode = pincode
//                BDDVC.attributeProductID = parentObject[indexPath.row].id
//                BDDVC.singleProductID = parentObject[indexPath.row].id
            }
            self.navigationController?.pushViewController(BDDVC, animated: true)
            print("-------------BestDealDetailViewController-------------")
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == self.CategoryCollectionView {
            let width = (CategoryCollectionView.frame.size.width - 10) / 2
            return CGSize(width: width, height: width)
        } else if collectionView == self.parentCategoryCollectionView {
            return CGSize(width: 90, height: 90)
        } else {
            let width = (subCatCollectionView.frame.size.width - 10) / 2.5
            if subCategoryObj.count > 0 {
                let item = subCategoryObj[indexPath.row]
                let size = item.name!.size(withAttributes: nil)
                return CGSize(width: size.width+50 , height: 45)
            } else {
                return CGSize(width: width, height: 50)
            }
        }
    }
    
}

