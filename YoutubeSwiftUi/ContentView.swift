//
//  ContentView.swift
//  YoutubeSwiftUi
//
//  Created by charles raj on 19/06/24.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        
        TabView {
            NavigationView {
                         HomeView()
                     }
                     .tabItem {
                         Image(systemName: "house.fill")
                         Text("Home")
                     }
                     
                     NavigationView {
                         SearchView()
                     }
                     .tabItem {
                         Image(systemName: "magnifyingglass")
                         Text("Search")
                     }
                     
                     NavigationView {
                         ProfileView()
                     }
                     .tabItem {
                         Image(systemName: "person.fill")
                         Text("Profile")
                     }
                }
        
    }
}

//struct HomeView: View {
//    var body: some View {
//        Text("Home View")
//            .font(.largeTitle)
//            .foregroundColor(.blue)
//    }
//}
//
//struct SearchView: View {
//    var body: some View {
//        Text("Search View")
//            .font(.largeTitle)
//            .foregroundColor(.green)
//    }
//}
//
//struct ProfileView: View {
//    var body: some View {
//        Text("Profile View")
//            .font(.largeTitle)
//            .foregroundColor(.purple)
//    }
//}

struct HomeView: View {
    var body: some View {
        Text("Home View")
            .font(.largeTitle)
            .foregroundColor(.blue)
            .navigationTitle("Home")
    }
}

struct SearchView: View {
    var body: some View {
        Text("Search View")
            .font(.largeTitle)
            .foregroundColor(.green)
            .navigationTitle("Search")
    }
}

struct ProfileView: View {
    var body: some View {
        Text("Profile View")
            .font(.largeTitle)
            .foregroundColor(.purple)
            .navigationTitle("Profile")
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

