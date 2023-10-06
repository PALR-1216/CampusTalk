//
//  ProfileView.swift
//  track3
//
//  Created by Pedro Alejandro LR on 9/5/23.
//

import SwiftUI
import Firebase
import SDWebImageSwiftUI

struct ProfileView: View {
    @EnvironmentObject var dataManager:DataManager
    var body: some View {
        NavigationView{
            VStack {
                Text(dataManager.UsersUni)
                Text(dataManager.userName)
                WebImage(url: URL(string: "https://robohash.org/\(dataManager.userName)"))
                    .resizable()
                
                
                Button {
                    dataManager.signOut()
                    
                } label: {
                    Text("Log Out")
                    
                }
            }
            .navigationTitle("Profile")
            .onAppear {
                // run profile fetch
//                dataManager.fetchPost()
            }
        }
        
        
    }
    
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}
