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
    
    let mapSpan = MKCoordinateSpan(latitudeDelta: 0.2, longitudeDelta: 0.2)
    
    @Published var region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 0.0, longitude: 0.0),
                                               span: MKCoordinateSpan(latitudeDelta: 0.2, longitudeDelta: 0.2))
    @Published var searchLocation : CLLocationCoordinate2D?
    @Published var userLocation : CLLocationCoordinate2D?
    @Published var route : MKRoute?
    
//    @Published var locationList = [MKMapItem]()
    @Published var locationList = [LocationDetails]()
    
    private var geocoder = CLGeocoder()
    @Published var userAddress: String?
    @Published var searchAddress: String?
    
    
    
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
            center: location.coordinate, span: self.mapSpan
        )
        
        getLocationAddress(coordinate: location){ addressString in
            self.userAddress = addressString
        }
    }
    
    
    func searchLocation(searchQuery : String){
        let searchRequest = MKLocalSearch.Request()
        searchRequest.naturalLanguageQuery = searchQuery
        
        let search = MKLocalSearch(request: searchRequest)
        search.start { response, error in
//            guard let response = response, 
//                    let item = response.mapItems.first else {
//                return
//            }
            guard let response = response else {
                return
            }
            
            self.locationList.removeAll()
            response.mapItems.forEach { item in
                var address = ""
                var routeItem : MKRoute = MKRoute()
                
                if let locaiton = item.placemark.location {
                    self.getLocationAddress(coordinate: locaiton){ addressString in
                        
                        address = addressString
                        
                        let coordinate = item.placemark.coordinate
                        self.calculateRoute(destnation: coordinate){ route in
                            routeItem = route
                            
                            let distance = String(format: "%.2f km", routeItem.distance / 1000)
                            let duration = String(format: "%.0f minutes", routeItem.expectedTravelTime / 60)
                            
                            let locationDetails = LocationDetails( coordinate: coordinate, address: address, distance: distance, duration: duration, route: route)
                            
                            self.locationList.append(locationDetails)
                            print(self.locationList.count)
                            
                        }
                        
                    }
                }
                
            }
            
//            let coordinate = item.placemark.coordinate
//            self.searchLocation = coordinate
//            self.region = MKCoordinateRegion(center: coordinate, span: self.mapSpan)
//            
//            self.calculateRoute(destnation: coordinate){ route in
//                self.route = route
//            }
//            
//            if let locaiton = item.placemark.location {
//                self.getLocationAddress(coordinate: locaiton){ addressString in
//                    self.searchAddress = addressString
//                }
//            }
        }
    }
    
    func selectedLocation(selectedLocation : LocationDetails){
        self.searchLocation = selectedLocation.coordinate
        self.route = selectedLocation.route
    }
    
    
    func calculateRoute(destnation : CLLocationCoordinate2D ,callback : @escaping (MKRoute) -> ()) {
        
        guard let userLocation = self.userLocation else {
            return
        }
        
        let userPlacemark = MKPlacemark(coordinate: userLocation)
        let searchPlacemark = MKPlacemark(coordinate: destnation)
        
        let directionRequest = MKDirections.Request()
        directionRequest.source = MKMapItem(placemark: userPlacemark)
        directionRequest.destination = MKMapItem(placemark: searchPlacemark)
        directionRequest.transportType = .automobile
        
        let direction = MKDirections(request: directionRequest)
        direction.calculate{ [weak self] response, error in
            guard let self = self, let response = response, let route = response.routes.first else {
                            print("Route not found")
                            return
                        }
            callback(route)
        }
        
        
    }
    
    func getLocationAddress(coordinate: CLLocation, callback: @escaping (String) -> ()){
        
        geocoder.reverseGeocodeLocation(coordinate) { placemark, error in
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
//            if let thoroughfare = placemark.thoroughfare {
//                addressString += "\(thoroughfare), "
//            }
            if let locality = placemark.locality {
                addressString += "\(locality), "
            }
            if let administrativeArea = placemark.administrativeArea {
                addressString += "\(administrativeArea), "
            }
            if let country = placemark.country {
                addressString += "\(country)"
            }
            callback(addressString)
        }
        
    }
    
    
}


struct LocationDetails : Identifiable {
    var id: UUID
    var coordinate : CLLocationCoordinate2D
    var route : MKRoute
    var address : String
    var distance : String
    var duration : String
    
    init(coordinate: CLLocationCoordinate2D, 
         address: String,
         distance: String,
         duration: String,
         route : MKRoute
    ) {
        self.id = UUID()
        self.coordinate = coordinate
        self.address = address
        self.distance = distance
        self.duration = duration
        self.route = route
    }
    
}
