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

        
        VStack{
           BannerView(bannerImages: bannerImages, currentIndex: $currentIndex)
            BannerIndicator(bannerCount: bannerImages.count, currentIndex: $currentIndex)
                
        }
    }
    
}

struct BannerView : View {
    
    let bannerImages : [String]
    @Binding var currentIndex : Int
    
    var body: some View {
        
        TabView(selection: $currentIndex) {
            ForEach(0..<bannerImages.count) { index in
                @State var offset = 0.0
                Image(bannerImages[index])
                    .resizable()
                    .cornerRadius(10)
                    .padding(10)
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
        
            Timer.scheduledTimer(withTimeInterval: 3.0, repeats: true, block: { timer in
                withAnimation(){
                    currentIndex = (currentIndex + 1) % bannerImages.count
                }
            })
        }
        
    }
    
}


struct BannerIndicator : View {
    let bannerCount : Int
    @Binding var currentIndex : Int
    @Namespace private var indicatorNameSpace
    var body: some View {
        HStack{
            ForEach(0..<bannerCount){ index in
                if index == currentIndex {
                    Circle()
                        .fill(Color.blue)
                        .frame(width: 10, height: 10)
                        .matchedGeometryEffect(id: "indicator", in: indicatorNameSpace)
                } else {
                    Circle()
                        .fill(Color.gray)
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
