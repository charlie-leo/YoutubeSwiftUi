//
//  ContentView.swift
//  YoutubeSwiftUi
//
//  Created by charles raj on 19/06/24.
//

import SwiftUI

struct ContentView: View {
    
    @State private var selectedTap = 0
    @Namespace private var animationNameSpace
    
    var body: some View {
        
        VStack {
            TabView (selection: $selectedTap) {
                
                HomeView()
                .tag(0)
            
                
                
                VStack{
                    Text("Search")
                    .font(.largeTitle)
                    .foregroundColor(.cyan)
                }
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
                TabCustomItem("Search", tab: 1, icon: "magnifyingglass")
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
//            .background(Color(UIColor.systemGray6))
//            .cornerRadius(10.0)
            
            
            
        }
        
    }
    
    
    @ViewBuilder
    private func TabCustomItem(
        _ text : String,
        tab : Int,
        icon : String
    ) -> some View {
        VStack{
            ZStack{
                if selectedTap == tab {
                    Color.gray
                        .frame(width: 40, height: 40)
                        .background(Circle())
                        .clipShape(.ellipse)
                        .matchedGeometryEffect(id: "backgroung", in: animationNameSpace)
                }
                Image(systemName: icon)
                    .frame(width: 40, height: 40)
            }
            Text(text)
        }
        .onTapGesture {
            withAnimation(.spring){
                selectedTap = tab
            }
        }
    }
    
    
}




struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

