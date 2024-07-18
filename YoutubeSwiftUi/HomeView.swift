//
//  HomeView.swift
//  YoutubeSwiftUi
//
//  Created by charles raj on 04/07/24.
//

import SwiftUI

struct HomeView: View {
    
    
    @State private var currentIndex = 0
    let bannerImages = [
        "banner_1",
        "banner_2",
        "banner_3"
    ]
    
    var body: some View {
        
        VStack {
            BannerView(bannerImages: bannerImages, currentIndex: $currentIndex)
            BannerIndicatorView(bannercount: bannerImages.count, currentIndex: $currentIndex)
        }
    }
    
}

struct BannerView : View {
    
    let bannerImages : [String]
    @Binding var currentIndex : Int
    var body : some View {
        
        TabView (selection: $currentIndex) {
            
            ForEach(0..<bannerImages.count) { index in
                @State var offset = 0.0
                Image(bannerImages[index])
                    .resizable()
                    .cornerRadius(10)
                    .padding(20)
                    .frame(height: 400)
                    .scaledToFit()
                    .tag(index)
                    .offset(x: offset)
                    .onAppear{
                        withAnimation(.easeIn){
                            offset = 100.0
                        }
                    }
                    .onDisappear{
                        withAnimation(.easeIn){
                            offset = -100.0
                        }
                    }
            }
            
        }
        .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
        .onAppear{
            autoScroll()
        }
    }
    
    func autoScroll() {
        Timer.scheduledTimer(withTimeInterval: 3.0, repeats: true) { timer in
            withAnimation(.easeIn){
                currentIndex = (currentIndex + 1) % bannerImages.count
            }
        }
    }
    
}

struct BannerIndicatorView : View {
    let bannercount : Int
    @Binding var currentIndex : Int
    @Namespace private var animationNamespace
    var body: some View {
        HStack (spacing: 8) {
            ForEach(0..<bannercount) { index in
                if index == currentIndex {
                    Circle()
                        .fill(Color.blue)
                        .frame(width: 10, height: 10)
                        .matchedGeometryEffect(id: "background", in: animationNamespace)
                } else {
                    Circle()
                        .fill( Color.gray)
                        .frame(width: 10, height: 10)
                }
            }
        }
    }
    
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
