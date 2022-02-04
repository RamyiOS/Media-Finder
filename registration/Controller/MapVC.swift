//
//  MapVC.swift
//  registration
//
//  Created by Mac on 10/18/21.
//  Copyright © 2021 ramy. All rights reserved.
//

import MapKit
import UIKit
import CoreLocation

protocol sendingAddressDelegate: class {
    func sendAdress(to address: String)
}

class MapVC: UIViewController {
    
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var addressLabel: UILabel!
    
    let locationManager = CLLocationManager()
    weak var delegate: sendingAddressDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        checkLocationServices()
        mapView.delegate = self
    }
    
    
    private func centerMapOnCurrentLocation() {
        if let location = locationManager.location?.coordinate {
            let region = MKCoordinateRegion(center: location, latitudinalMeters: 10000, longitudinalMeters: 10000)
            mapView.setRegion(region, animated: true)
            self.setAddressFrom(location: locationManager.location!)
        }
    }
    
    private func centerMapOnSpecificLocation() {
        let location = CLLocation(latitude: 30.096655, longitude: 31.662533)
        let region = MKCoordinateRegion(center: location.coordinate, latitudinalMeters: 10000, longitudinalMeters: 10000)
        mapView.setRegion(region, animated: true)
        self.setAddressFrom(location: location)
    }
    
    private func checkLocationServices() {
        if CLLocationManager.locationServicesEnabled() {
            checkLocationAuthorisation()
        } else {
            showAlert(message: "can not get your location!")
        }
    }
    
    private func checkLocationAuthorisation() {
        switch CLLocationManager.authorizationStatus() {
        case .authorizedAlways, .authorizedWhenInUse:
            centerMapOnSpecificLocation()
        case .restricted, .denied:
            showAlert(message: "can not get your location!")
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
        default:
            showAlert(message: "can not get your location!")
        }
    }
    
    private func setAddressFrom(location: CLLocation) {
        let geoCoder = CLGeocoder()
        geoCoder.reverseGeocodeLocation(location) { (placeMarks, erorr) in
            if let erorr = erorr {
                print("erorr is \(erorr.localizedDescription)")
            }
            else if let firstPlaceMarks = placeMarks?.first {
                if let country = firstPlaceMarks.country, let city = firstPlaceMarks.locality, let region = firstPlaceMarks.subLocality, let street = firstPlaceMarks.thoroughfare {
                    let detailsAddress = "\(country), \(city), \(region), \(street)"
                    self.addressLabel.text = detailsAddress
                }
            }
        }
    }
    
    @IBAction func confirmBtnPressed(_ sender: UIButton) {
        let address = addressLabel.text ?? ""
        delegate?.sendAdress(to: address)
        self.dismiss(animated: true, completion: nil)
    }
}

extension MapVC: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, regionDidChangeAnimated animated: Bool) {
        let lat = mapView.centerCoordinate.latitude
        let long = mapView.centerCoordinate.longitude
        let location = CLLocation(latitude: lat, longitude: long)
        self.setAddressFrom(location: location)
    }
}

