//
//  RouteMapView.swift
//  YoutubeSwiftUi
//
//  Created by charles raj on 11/07/24.
//

import SwiftUI
import MapKit

struct RouteMapView: UIViewRepresentable {
   
    
    @ObservedObject var locationManager: LocationManager

    func makeUIView(context: Context) -> MKMapView {
        let mapView = MKMapView()
        mapView.delegate = context.coordinator
        mapView.showsUserLocation = true
        return mapView
    }

    func updateUIView(_ uiView: MKMapView, context: Context) {
        if let userLocation = locationManager.userLocation {
            let region = MKCoordinateRegion(center: userLocation, span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05))
            uiView.setRegion(region, animated: true)
        }

      
        uiView.removeAnnotations(uiView.annotations)
        if let userLocation = locationManager.userLocation {
            let annotation = MKPointAnnotation()
            annotation.coordinate = userLocation
            annotation.title = "Current Location"
            uiView.addAnnotation(annotation)
        }
        if let searchedLocation = locationManager.searchLocation {
            let annotation = MKPointAnnotation()
            annotation.coordinate = searchedLocation
            annotation.title = "Searched Location"
            uiView.addAnnotation(annotation)
        }
        
        uiView.removeOverlays(uiView.overlays)
        if let route = locationManager.route {
            uiView.addOverlay(route.polyline)
        }

    }
    
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    class Coordinator: NSObject, MKMapViewDelegate {
        var parent: RouteMapView

        init(_ parent: RouteMapView) {
            self.parent = parent
        }

        func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
            if let polyline = overlay as? MKPolyline {
                let renderer = MKPolylineRenderer(polyline: polyline)
                renderer.strokeColor = .blue
                renderer.lineWidth = 4
                return renderer
            }
            return MKOverlayRenderer(overlay: overlay)
        }
    }
}
