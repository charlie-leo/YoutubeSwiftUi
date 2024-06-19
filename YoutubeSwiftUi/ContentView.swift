//
//  ContentView.swift
//  YoutubeSwiftUi
//
//  Created by charles raj on 19/06/24.
//

import SwiftUI

struct ContentView: View {
    
    @State private var selectedTap = 0
    
    var body: some View {
        
        VStack {
            TabView (selection: $selectedTap) {
                
                NavigationView {
                    VStack{
                        Text("HomeView")
                            .font(.largeTitle)
                            .foregroundColor(.green)
                        
                    }
                    .navigationTitle("HomeView")
                }
                .tag(0)
                .tabItem {
                    Image(systemName: "house.fill")
                    Text("Home")
                }
                
                
                VStack{
                    Text("Search")
                    .font(.largeTitle)
                    .foregroundColor(.cyan)
                }
                .tag(1)
                .tabItem {
                    Image(systemName: "magnifyingglass")
                    Text("Search")
                }
                
                VStack{
                    Text("Profile")
                    .font(.largeTitle)
                    .foregroundColor(.accentColor)
                }
                .tag(2)
                .tabItem {
                    Image(systemName: "person.fill")
                    Text("Profile")
                }
                
                
            }
            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
            
            HStack {
                Spacer()
                Button(action: {
                    selectedTap = 0
                }, label: {
                    VStack {
                        Image(systemName: "house.fill")
                        if selectedTap == 0 {
                            Text("Home")
                        }
                    }
                })
                Spacer()
                Button(action: {
                    selectedTap = 1
                }, label: {
                    VStack {
                        Image(systemName: "magnifyingglass")
                        if selectedTap == 1 {
                            Text("Search")
                        }
                        
                    }
                })
                Spacer()
                Button(action: {
                    selectedTap = 2
                }, label: {
                    VStack {
                        Image(systemName: "person.fill")
                        if selectedTap == 2 {
                            Text("Profile")
                        }
                    }
                })
                Spacer()
            }
            .padding()
            .background(Color(UIColor.systemGray6))
            
            
            
        }
        
    }
}




struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

