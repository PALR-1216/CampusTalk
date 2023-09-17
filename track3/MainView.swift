//
//  MainView.swift
//  track3
//
//  Created by Pedro Alejandro LR on 8/27/23.
//

import SwiftUI

struct MainView: View {
    var body: some View {
        TabView {
            ListView()
                .tabItem {
                    Label("Posts", systemImage: "list.dash")
                    
                }
            UserLikesView()
                .tabItem {
                    Label("Likes", systemImage: "heart.fill")
                    
            }
            
            ProfileView()
                .tabItem {
                    Label("Profile", systemImage: "person")
                }
                
        }
    }
}


struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
