//
//  MapView.swift
//  YoutubeSwiftUi
//
//  Created by charles raj on 09/07/24.
//

import SwiftUI
import MapKit

struct IdentifiableLocation: Identifiable {
    var id = UUID()
    let coordinate: CLLocationCoordinate2D
    let isCurrentLocation: Bool
    
    init(id: UUID = UUID(), coordinate: CLLocationCoordinate2D, isCurrentLocation: Bool) {
        self.id = id
        self.coordinate = coordinate
        self.isCurrentLocation = isCurrentLocation
    }
    
}

struct MapView: View {
    
    @StateObject private var locationManager = LocationManager()
    @State private var annotations = [IdentifiableLocation]()
    @State private var searchText = ""
    
    
    var body: some View {
        
        GeometryReader { reader in
            VStack{
                
                HStack {
                    TextField("Search Field", text: $searchText, onCommit: {
                        locationManager.searchLocation(searchQuery: searchText)
                    })
                    .padding()
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    
                    
                    Button(action: {
                        locationManager.searchLocation(searchQuery: searchText)
                    }, label: {
                        Image(systemName: "magnifyingglass")
                            .padding()
                            .background(
                                Circle().foregroundColor(Color.gray.opacity(0.3))
                            )
                    })
                }
                
                VStack{
                    if #available(iOS 17.0, *) {
                        Map(initialPosition: .region(locationManager.region))
                    } else {
                        
                        RouteMapView(locationManager: locationManager)
                        
//                        Map(coordinateRegion: $locationManager.region, showsUserLocation: true, annotationItems: createAnnotaions())
//                        { item in
//                            MapMarker(coordinate: item.coordinate , tint: item.isCurrentLocation ? .blue : .red)
//                        }
//                        .overlay {
//                            if let route = locationManager.route {
//                                MapPolyline(coordinates: route.polyline.coordinates, count: route.polyline.pointCount)
//                                    .stroke(Color.blue, lineWidth: 4)
//                            }
//                        }
                        
                        
                    }
                }
                
                VStack(alignment: .leading) {
                    if let route = locationManager.route {
                                   Text("Distance: \(route.distance / 1000, specifier: "%.2f") km")
                                   Text("Estimated Time: \(route.expectedTravelTime / 60, specifier: "%.0f") minutes")
                               }
                    HStack{
                        Image(systemName: "location.circle.fill")
                        Text("Address")
                            .font(.subheadline)
                        Spacer()
                    }
                    .foregroundStyle(.secondary)
                    .padding(.bottom, 2)
                    
                    HStack{
                        Text(locationManager.userAddress ?? "")
                            .font(.title)
                        Spacer()
                    }
                    .padding(.bottom, 10)
                    
                    if let searchAddress = locationManager.searchAddress{
                        
                        HStack{
                            Image(systemName: "location.fill")
                            Text("Search Address")
                                .font(.subheadline)
                            Spacer()
                        }
                        .foregroundStyle(.secondary)
                        .padding(.bottom, 2)
                        
                        HStack{
                            Text(searchAddress)
                                .font(.title)
                            Spacer()
                        }
                        .padding(.bottom, 10)
                    }
                    //                    HStack{
                    //                        Text("Joshua Tree National pare")
                    //                            .font(.subheadline)
                    //                        Spacer()
                    //                        Text("California")
                    //                            .font(.subheadline)
                    //                    }
                    //                    .font(.subheadline)
                    //                    .foregroundStyle(.secondary)
                    ////
                    //                    Divider()
                    //                    Text("About Turtle Rock")
                    //                        .font(.title2)
                    //                    Text("Description Text gose here.")
                    //                        .foregroundStyle(.secondary)
                    
                }
                .padding()
            }
            
        }
        
        
    }
    
    private func createAnnotaions() -> [IdentifiableLocation] {
        var annotations = [IdentifiableLocation]()
        
        if let userLocation = locationManager.userLocation {
            annotations.append(IdentifiableLocation(coordinate: userLocation, isCurrentLocation: true))
        }
        if let searchLocation = locationManager.searchLocation {
            annotations.append(IdentifiableLocation(coordinate: searchLocation, isCurrentLocation: false))
        }
        
        return annotations
        
    }
    
}

extension MKPolyline {
    var coordinates: [CLLocationCoordinate2D] {
        var coords = [CLLocationCoordinate2D](repeating: kCLLocationCoordinate2DInvalid, count: pointCount)
        getCoordinates(&coords, range: NSRange(location: 0, length: pointCount))
        return coords
    }
}

#Preview {
    MapView()
}

