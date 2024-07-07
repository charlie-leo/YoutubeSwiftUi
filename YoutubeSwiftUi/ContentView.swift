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
                
//                VStack{
                    HomeView()
//                }
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
                        let itemColor : Color = (selectedTap == 0) ? Color.white : Color.gray
                        
                        Image(systemName: "house.fill").tint(itemColor)
                        Text("Home").foregroundColor(itemColor)
                        
                    }
                })
                Spacer()
                Spacer()
                Button(action: {
                    selectedTap = 1
                }, label: {
                    VStack {
                        var itemColor : Color = (selectedTap == 1) ? Color.white : Color.gray
                        
                        Image(systemName: "magnifyingglass").tint(itemColor)
                        Text("Search").foregroundColor(itemColor)
                        
                    }
                })
                Spacer()
                Spacer()
                Button(action: {
                    selectedTap = 2
                }, label: {
                    VStack {
                        var itemColor : Color = (selectedTap == 2) ? Color.white : Color.gray
                        
                        Image(systemName: "person.fill").tint(itemColor)
                        Text("Profile").foregroundColor(itemColor)
                        
                    }
                })
                Spacer()
            }
            .padding()
            .background(Color(UIColor.black))
            .cornerRadius(10.0)
            .padding(EdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10))
            
            .shadow(radius: 10)
            .onAppear{
            }
//            .background(Color(UIColor.systemGray6))
//            .cornerRadius(10.0)
            
            
            
        }
        
    }
}




struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

