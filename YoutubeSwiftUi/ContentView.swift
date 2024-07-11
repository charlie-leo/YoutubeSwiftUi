//
//  ContentView.swift
//  YoutubeSwiftUi
//
//  Created by charles raj on 19/06/24.
//

import SwiftUI

struct ContentView: View {
    
    @State private var selectedTab = 0
    @Namespace private var animationNamespace
    
    
    var body: some View {
        
        VStack {
            TabView (selection: $selectedTab) {
                
                HomeView()
                    .tag(0)
                
                MapView()
                .tag(1)
                
                VStack{
                    Text("Profile")
                        .font(.largeTitle)
                        .foregroundColor(.accentColor)
                }
                .tag(2)
            }
            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
            
            HStack {
                
                Spacer()
                TabCustomItem("Home", tab: 0, icon: "house.fill")
                Spacer()
                Spacer()
                TabCustomItem("Map", tab: 1, icon: "map.fill")
                Spacer()
                Spacer()
                TabCustomItem("Profile", tab: 2, icon: "person.fill")
                Spacer()
            }
            .padding()
            .background(Color(UIColor.black))
            .cornerRadius(10.0)
            .padding(EdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10))
            .shadow(radius: 10)
            .onAppear{
            }
            
        }
    }
    
    @ViewBuilder
    private func TabCustomItem(_ text: String, tab: Int, icon: String ) -> some View {
        VStack{
            ZStack{
                if selectedTab == tab {
                    Color.gray
                        .frame(width: 40, height: 40)
                        .foregroundColor(.blue)
                        .background(RoundedRectangle(cornerRadius: 20))
                        .clipShape(.ellipse)
                        .matchedGeometryEffect(id: "background", in: animationNamespace)
                }
                Image(systemName: icon)
                    .frame(width: 40, height: 40)
            }
            Text(text)
        }
        .onTapGesture {
            withAnimation(.spring){
                selectedTab = tab
            }
        }
        
    }
    
}




struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

