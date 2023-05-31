//
//  SelectYourLocationViewController.swift
//  SeaMartApp
//
//  Created by mehtab alam on 19/02/2021.
//

import UIKit
import CoreLocation
import GoogleMaps
import GooglePlaces

class SelectYourLocationViewController: UIViewController,CLLocationManagerDelegate,UITextFieldDelegate {

    @IBOutlet weak var cityTF: UITextField!
    @IBOutlet weak var pincodeTF: UITextField!
    @IBOutlet weak var mapView: GMSMapView!
    @IBOutlet weak var searchTF: UITextField!
    

    private var OTPObject:OTPModel?
    var login:Bool?
    var status2:String!
    var locationManager:CLLocationManager!
    var cityName:String?
    var pincodeData:String?
    var isFromHome = Bool()
    var mobileNoStore: String!
    var latitute: Double!
    var longitude: Double!
    var userLocation:CLLocation!
    var initialLocation:CLLocationCoordinate2D?
    var isAutoCompleteCall = false
    var autoCompleteVC = GMSAutocompleteViewController()
    var selectedTF:String = ""
    var currentLocation = CLLocation()
    var pincode:String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.mapView.delegate = self
        self.cityTF.delegate = self
        self.searchTF.delegate = self
        self.pincodeTF.delegate = self
        autoCompleteVC.delegate = self
        
        locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestAlwaysAuthorization()
        
        if CLLocationManager.locationServicesEnabled(){
            locationManager.startUpdatingLocation()
        }
         cityName = self.cityTF.text
        pincodeData = self.pincodeTF.text
    }
    @IBAction func clickDeliveryLocation(_ sender: Any) {
        
        if status2 == "OTP Verifid..Please Signup" {
            print("Please Fill the Detials")
            DispatchQueue.main.async {
                let PDVC = self.storyboard?.instantiateViewController(withIdentifier: "PersonalDetailsViewController") as! PersonalDetailsViewController
                //  PDVC.mobileNoStore = self.mobileNoStore
                self.navigationController?.pushViewController(PDVC, animated: true)
                
            }
        } else if status2 == "OTP Verifid..home page" {
            print("HOME PAGE")
            DispatchQueue.main.async {
                let MVC = self.storyboard?.instantiateViewController(withIdentifier: "MainViewController") as! MainViewController
                UserDefaults.standard.setValue(true, forKey: "isUserLoggedIn")
                UserDefaults.standard.synchronize()
                self.navigationController?.pushViewController(MVC, animated: true)
            }
        }
        singleton.shared.saveToDefault(value: self.cityTF.text!, Key: DefaultKeys.cityName)
        singleton.shared.saveToDefault(value: self.pincodeTF.text!, Key: DefaultKeys.pincode)
        
        if self.isFromHome {
            if let stack = self.navigationController?.viewControllers {
                for vc in stack where vc.isKind(of: MainViewController.self) {
                    debugPrint("exists")
                    self.navigationController?.popToViewController(vc, animated: true)
                }
            }
//            let MVC = self.storyboard?.instantiateViewController(withIdentifier: "MainViewController") as! MainViewController
//            self.navigationController?.pushViewController(MVC, animated: true)
           // self.navigationController?.popToRootViewController(animated: true)
        }
    }
  
    @IBAction func clickOnBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
//MARK: - Location Delegate Methods
func dragToMaponLocation(location:CLLocationCoordinate2D) {
    let camera = GMSCameraPosition.camera(withLatitude: location.latitude, longitude: location.longitude, zoom: 15.0)
    mapView.camera = camera
    let marker = GMSMarker()
    marker.position = CLLocationCoordinate2D(latitude: location.latitude, longitude: location.longitude)
    //        marker.isDraggable = true
    //        marker.map = mapView
    // self.mapView.delegate = self
    marker.isDraggable = true
    reverseGeocoding(marker: marker)
    marker.map = mapView
    self.mapView.clear()
}
}
//MARK: - CLLocation Delegate Methods
extension SelectYourLocationViewController {
func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
    
    mapView.isMyLocationEnabled = true
    let userLocation:CLLocation = locations[0] as CLLocation
    
    self.locationManager.stopUpdatingLocation()
    
    print("user latitude = \(userLocation.coordinate.latitude)")
    print("user longitude = \(userLocation.coordinate.longitude)")
    
    let geocoder = CLGeocoder()
    geocoder.reverseGeocodeLocation(userLocation) { (placemarks, error) in
        if (error != nil){
            print("error in reverseGeocode")
        }
        let placemark = placemarks! as [CLPlacemark]
        if placemark.count>0{
            let placemark = placemarks![0]
            print(placemark)
            
            self.pincodeTF.text = placemark.postalCode
            self.cityTF.text = placemark.subLocality
            self.initialLocation = CLLocationCoordinate2D(latitude: userLocation.coordinate.latitude, longitude: userLocation.coordinate.longitude)
            
            self.dragToMaponLocation(location: self.initialLocation!)
            
            
          //  self.getLocalAddress(location: self.initialLocation!, textField: self.cityTF)
            
            self.cityTF.text = placemark.subLocality
            self.pincodeTF.text = placemark.postalCode
            singleton.shared.saveToDefault(value: self.cityTF.text!, Key: DefaultKeys.cityName)
            singleton.shared.saveToDefault(value: self.pincodeTF.text!, Key: DefaultKeys.pincode)
        }
    }
    
}
}

//MARK: - GMS MAP VIEW Delegate and textField delegate Methods
extension SelectYourLocationViewController: GMSMapViewDelegate, GMSAutocompleteViewControllerDelegate {

func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
    return true
}

func textFieldDidBeginEditing(_ textField: UITextField) {
    if(textField == searchTF) {
        selectedTF = "Destination TextField"
    }
    present(autoCompleteVC, animated: true, completion: nil)
}

func viewController(_ viewController: GMSAutocompleteViewController, didAutocompleteWith place: GMSPlace) {
    print("didAutocompleteWith")
    
    if(selectedTF == "Destination TextField")
    {
        print("place--->",place)
        searchTF.text = place.formattedAddress
        cityTF.text = place.name
        
        let marker = GMSMarker()
        let geocoder = CLGeocoder()
        let coordinate = CLLocation(latitude: place.coordinate.latitude, longitude: place.coordinate.longitude)
        
        geocoder.reverseGeocodeLocation(coordinate) { (places, error) in
            if (error != nil){
                print("error in reverseGeocode")
            }
            if let address = places?.first {
                self.pincodeTF.text = address.postalCode
               // self.cityTF.text = address.name
                marker.isDraggable = true
                self.mapView.clear()
                let camera = GMSCameraPosition.camera(withLatitude: place.coordinate.latitude, longitude: place.coordinate.longitude, zoom: 15.0)
                self.mapView.camera = camera
                marker.position = CLLocationCoordinate2D(latitude: place.coordinate.latitude, longitude: place.coordinate.longitude)
                marker.title = place.formattedAddress
                marker.map = self.mapView
            }
        }
        dismiss(animated: true, completion: nil)
    }
}

//Mark: Marker methods
func mapView(_ mapView: GMSMapView, didEndDragging marker: GMSMarker) {
    print("Position of marker is = \(marker.position.latitude),\(marker.position.longitude)")
    reverseGeocoding(marker: marker)
    print("Position of marker is = \(marker.position.latitude),\(marker.position.longitude)")
}
func mapView(_ mapView: GMSMapView, didBeginDragging marker: GMSMarker) {
    print("didBeginDragging")
}
func mapView(_ mapView: GMSMapView, didDrag marker: GMSMarker) {
    print("didDrag")
}


//Mark: Reverse GeoCoding
func reverseGeocoding(marker: GMSMarker) {
    let geocoder = GMSGeocoder()
    let coordinate = CLLocationCoordinate2DMake(Double(marker.position.latitude),Double(marker.position.longitude))
    
    var currentAddress = String()
    
    geocoder.reverseGeocodeCoordinate(coordinate) { response , error in
        if (error != nil){
            print("error in reverseGeocode")
        }
        if let address = response?.firstResult(){
            let lines = address.lines! as [String]
            let  area = address.subLocality!
            let postalcode = address.postalCode
          //  let pincode = singleton.shared.getFromDefault(Key: DefaultKeys.pincode)
            self.pincodeTF.text = postalcode
          //  postalCode = address.postalCode
            
            print("Response is address = \(address)")
            print("Response is lines = \(lines)")
            
            currentAddress = lines.joined(separator: "\n")
            self.mapView.clear()
            marker.title = currentAddress
            if self.searchTF.text!.isEmpty {
            self.cityTF.text = area
            } else {
                self.cityTF.text = currentAddress
            }
            marker.map = self.mapView
            marker.position = coordinate
            
        }
        
    }
}

func viewController(_ viewController: GMSAutocompleteViewController, didFailAutocompleteWithError error: Error) {
    print("didFailAutocompleteWithError")
}

func wasCancelled(_ viewController: GMSAutocompleteViewController) {
    print("didFailAutocompleteWithError")
}
}
