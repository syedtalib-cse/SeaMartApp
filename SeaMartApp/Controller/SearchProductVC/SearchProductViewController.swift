//
//  SearchProductViewController.swift
//  ProtiensApp
//
//  Created by mehtab alam on 25/01/2021.
//

import UIKit

class SearchProductViewController: UIViewController {

    // MARK:- IBOutlet
    @IBOutlet weak var collectionProduct: UICollectionView!
    @IBOutlet weak var searchBarForPincode: UISearchBar!
    @IBOutlet weak var placeHolderLbl: UILabel!
    
    //MARK:- Variable
    private var serviceInstance = Service()
    var pincodeArray:ModelSearchPincode!
    var nameArray:ModelSearchProductName!
    var isFromLocation = Bool()
    var pincode = String()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Set default pincode
        self.searchBarForPincode.text! = self.pincode
        searchBarForPincode.setBackgroundImage(UIImage(), for: .any, barMetrics: .compact)
       // self.searchBarForPincode.self.isTranslucent = false
        
    }
    
}

//MARK: Action Events
extension SearchProductViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if !searchBar.text!.isEmpty {
           // searchBar.isTranslucent = false
            searchBar.resignFirstResponder()
            if isFromLocation {
                self.searchPincodePostData(text: searchBar.text!)
            } else {
                self.searchProductNamePostData(text: searchBar.text!)
                
            }
        }
    }
    
    @IBAction func clickBackButton(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
}

//MARK:- API CALL
extension SearchProductViewController {
    func searchPincodePostData(text : String) {
        let service = SeaMartURL.serachProductByPincodeURL
        serviceInstance.postRequest(url: service, dataDictionary: ["pincode": text], decodingType: ModelSearchPincode.self) { (result) in
               switch result {
               case .success(let data):
                DispatchQueue.main.async {
                    self.pincodeArray = data
                    if self.pincodeArray.productsbypincode!.count > 0 {
                        self.collectionProduct.isHidden = false
                    } else {
                        self.collectionProduct.isHidden = true
                    }
                    self.collectionProduct.reloadData()
                }
                
               case .failure(let error):
                   print(error.localizedDescription)
               }
           }
       }
    
    func searchProductNamePostData(text : String) {
           let service = SeaMartURL.serachProductByName
        serviceInstance.postRequest(url: service, dataDictionary: ["product_name": text], decodingType: ModelSearchProductName.self) { (result) in
               switch result {
               case .success(let data):
                DispatchQueue.main.async {
                    self.nameArray = data
                    if self.nameArray.searchproducts!.count > 0 {
                        self.collectionProduct.isHidden = false
                    } else {
                        self.collectionProduct.isHidden = true
                    }
                    self.collectionProduct.reloadData()
                }
                
               case .failure(let error):
                   print(error.localizedDescription)
               }
           }
       }
}

//MARK:- CollectionView Delegate And dataSource
extension SearchProductViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if isFromLocation {
            if self.pincodeArray != nil {
                return self.pincodeArray.productsbypincode!.count
            } else {
                return 0
            }
        } else {
            if self.nameArray != nil {
                return self.nameArray.searchproducts!.count
            } else {
                return 0
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CategoryCollectionViewCell", for: indexPath) as! CategoryCollectionViewCell
        
        if isFromLocation {
            if self.pincodeArray == nil {
                return cell
            }
            let data = self.pincodeArray.productsbypincode![indexPath.row]
            
            let link = SeaMartURL.productImageURL
            let completeLink = link + data.image!
            cell.categoryImage.sd_setImage(with: URL(string: completeLink), placeholderImage: UIImage(named: "placeholder"))
            if data.productName != nil {
                cell.categoryLabel.text! = data.productName!
            }
            if data.price != nil {
                cell.categoryPriceLbl.text! = "₹\(data.price!)"
            }
            if data.discount != nil {
                cell.discountLbl.text! = "\(data.discount!)%"
            }
        } else {
            if self.nameArray == nil {
                return cell
            }
            let data = self.nameArray.searchproducts![indexPath.row]
            
            let link = SeaMartURL.productImageURL
            let completeLink = link + data.image!
            cell.categoryImage.sd_setImage(with: URL(string: completeLink), placeholderImage: UIImage(named: "placeholder"))
            
            if data.productName != nil {
                cell.categoryLabel.text! = data.productName!
            }
            
            if data.price != nil {
                cell.categoryPriceLbl.text! = "₹\(data.price!)"
            }
            if data.discount != nil {
                cell.discountLbl.text! = "\(data.discount!)%"
            }
        }
        
        cell.ViewRoundCorners(corners: [.allCorners], radius: 15)
        cell.viewDetail3.layer.cornerRadius = 6
        cell.addShadowInView()
        return cell
        
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let BDDVC = self.storyboard?.instantiateViewController(withIdentifier: "BestDealDetailViewController") as! BestDealDetailViewController
        BDDVC.pincode = self.searchBarForPincode.text!
        
        if isFromLocation {
            BDDVC.attributeProductID = self.pincodeArray.productsbypincode![indexPath.row].id
            BDDVC.singleProductID = self.pincodeArray.productsbypincode![indexPath.row].id
        } else{
            BDDVC.attributeProductID = self.nameArray.searchproducts![indexPath.row].id
            BDDVC.singleProductID = self.nameArray.searchproducts![indexPath.row].id
        }
        self.navigationController?.pushViewController(BDDVC, animated: true)
        print("-------------BestDealDetailViewController-------------")
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
            let width = (collectionView.frame.size.width - 10) / 2
            return CGSize(width: width, height: width)
    }
}
