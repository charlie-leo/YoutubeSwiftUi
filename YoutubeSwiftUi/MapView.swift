//
//  MapView.swift
//  YoutubeSwiftUi
//
//  Created by charles raj on 09/07/24.
//

import SwiftUI
import MapKit

struct IdentificableLocation : Identifiable {
    var id = UUID()
    let coordnate : CLLocationCoordinate2D
    
    init(id: UUID = UUID(), coordnate: CLLocationCoordinate2D) {
        self.id = id
        self.coordnate = coordnate
    }
    
}


struct MapView: View {
    
    @StateObject private var locationManager = LocationManager()
    @State private var annotations = [IdentificableLocation]()
    
    var body: some View {
        
        VStack{
            if #available(iOS 17.0, *) {
                Map(initialPosition: .region(locationManager.region))
            } else {
                Map(coordinateRegion: $locationManager.region, showsUserLocation: true, annotationItems: annotations ){ item in
                    MapMarker(coordinate: item.coordnate)
                }
                .onAppear{
                    if let userLocation = locationManager.userLocation{
                        let identificatiLocation = IdentificableLocation(coordnate: userLocation)
                        annotations.append(identificatiLocation)
                    }
                }
            }
            
            Text(locationManager.userAddress ?? "")
                .font(.title2)
            
        }
        
    }
}

#Preview {
    MapView()
}
