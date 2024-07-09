//
//  MapView.swift
//  YoutubeSwiftUi
//
//  Created by charles raj on 09/07/24.
//

import SwiftUI
import MapKit


struct MapView: View {
    
    @State private var sregion = MKCoordinateRegion(
            center: CLLocationCoordinate2D(latitude: 34.011_284, longitude: -116.166_860),
            span: MKCoordinateSpan(latitudeDelta: 0.2, longitudeDelta: 0.2)
        )
    
    var body: some View {
        
        GeometryReader { reader in
            VStack{
                VStack{
                    if #available(iOS 17.0, *) {
                        Map(initialPosition: .region(region))
                    } else {
                        Map(coordinateRegion: $sregion)
                    }
                }
                .frame(height: reader.size.height/2)
                Image("")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 200, height: 200)
                    .clipShape(Circle())
                    .overlay( 
                        Circle().stroke(Color.white, lineWidth: 4)
                    )
                    .shadow(radius: 25)
                    .offset(x: 0, y: -120)
                    .padding(.bottom, -120)
                
                VStack(alignment: .leading) {
                    HStack{
                        Text("Turtle Rock")
                            .font(.title)
                        Spacer()
                    }
                    HStack{
                        Text("Joshua Tree National pare")
                            .font(.subheadline)
                        Spacer()
                        Text("California")
                            .font(.subheadline)
                    }
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
                    
                    Divider()
                    Text("About Turtle Rock")
                        .font(.title2)
                    Text("Description Text gose here.")
                        .foregroundStyle(.secondary)
                    
                }
                .padding()
            }
        
        }
        
       
    }
    
    
    private var region : MKCoordinateRegion {
        MKCoordinateRegion(
        
            center: CLLocationCoordinate2D(latitude: 34.011_286, longitude: -116.166_868),
            span: MKCoordinateSpan(latitudeDelta: 0.2, longitudeDelta: 0.2)
        )
            
    }
    
}

#Preview {
    MapView()
}
