//
//  SearchView.swift
//  YoutubeSwiftUi
//
//  Created by charles raj on 11/07/24.
//

import SwiftUI

struct SearchView: View {
    
    @Environment(\.dismiss) var dismiss
    
    @ObservedObject var locationManager: LocationManager
    @State private var searchText = ""
    
    var body: some View {
        VStack{
            HStack{
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
            
            List(locationManager.locationList){ item in
                VStack(alignment: .leading) {
                    Text(item.address)
                        .font(.title3)
                    Text("\(item.distance) (\(item.duration))")
                }
                .onTapGesture {
                    locationManager.selectedLocation(selectedLocation: item)
                    dismiss()
                }
            }
            
            
        }
    }
}

//#Preview {
//    SearchView()
//}
