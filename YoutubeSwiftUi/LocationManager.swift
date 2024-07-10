//
//  LocationManager.swift
//  YoutubeSwiftUi
//
//  Created by charles raj on 09/07/24.
//

import Foundation
import CoreLocation
import MapKit


class LocationManager : NSObject, ObservableObject, CLLocationManagerDelegate {
    private var locationManager = CLLocationManager()
    
    @Published var region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 0.0, longitude: 0.0), span: MKCoordinateSpan(latitudeDelta: 0.005, longitudeDelta: 0.005))
    
    @Published var userLocation : CLLocationCoordinate2D?
    @Published var userAddress : String?
    private var geocoder = CLGeocoder()
    
    override init() {
        super.init()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }
    
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.first else {return}
        
        userLocation = location.coordinate
        region = MKCoordinateRegion(center: location.coordinate,
                                    span: MKCoordinateSpan(latitudeDelta: 0.005, longitudeDelta: 0.005))
        
        geocoder.reverseGeocodeLocation(location){ placemarks, error in
            if let error = error {
                return
            }
            guard let placemark = placemarks?.first else  {
                return
            }
            
            var addressString = ""
            
            if let name = placemark.name {
                addressString += "\(name)"
            }
            
            if let name = placemark.thoroughfare {
                addressString += "\(name)"
            }
            
            if let name = placemark.locality {
                addressString += "\(name)"
            }
            
            if let name = placemark.administrativeArea {
                addressString += "\(name)"
            }
            
            if let name = placemark.country {
                addressString += "\(name)"
            }
            
            self.userAddress =  addressString
            
        }
        
        
    }
    
}
