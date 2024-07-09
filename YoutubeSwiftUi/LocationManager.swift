//
//  LocationManager.swift
//  YoutubeSwiftUi
//
//  Created by charles raj on 09/07/24.
//

//import SwiftUI
import Foundation
import CoreLocation
import MapKit

class LocationManager: NSObject, ObservableObject, CLLocationManagerDelegate {
    private var locationManager = CLLocationManager()
    
    @Published var region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 0.0, longitude: 0.0),
                                               span: MKCoordinateSpan(latitudeDelta: 0.2, longitudeDelta: 0.2))
    
    @Published var userLocation : CLLocationCoordinate2D?
    
    private var geocoder = CLGeocoder()
    @Published var userAddress: String?
    
    override init() {
        super.init()
        
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.first else { return }
        userLocation = location.coordinate
        region = MKCoordinateRegion(
            center: location.coordinate, span: MKCoordinateSpan(latitudeDelta: 0.001, longitudeDelta: 0.001)
        )
        
        
        // get geo coder
        geocoder.reverseGeocodeLocation(location){ placemark, error in
            if let error = error {
                print("Reverse geocode error: \(error.localizedDescription)")
                return
            }
            
            guard let placemark = placemark?.first else {
                print("No placemark found")
                return
            }
            
            // Construct address string
            var addressString = ""
            if let name = placemark.name {
                addressString += "\(name), "
            }
            if let thoroughfare = placemark.thoroughfare {
                addressString += "\(thoroughfare), "
            }
            if let locality = placemark.locality {
                addressString += "\(locality), "
            }
            if let administrativeArea = placemark.administrativeArea {
                addressString += "\(administrativeArea), "
            }
            if let country = placemark.country {
                addressString += "\(country)"
            }
            
            self.userAddress = addressString
            
        }
    }
    
}
