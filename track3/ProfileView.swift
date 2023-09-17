//
//  ProfileView.swift
//  track3
//
//  Created by Pedro Alejandro LR on 9/5/23.
//

import SwiftUI
import Firebase

struct ProfileView: View {
    @EnvironmentObject var dataManager:DataManager
    var body: some View {
        NavigationView{
            VStack {
                
                
                Button {
                    dataManager.signOut()
                    
                } label: {
                    Text("Log Out")
                    
                }
            }
            .navigationTitle("Profile")
            .onAppear {
                // run profile fetch
                dataManager.fethUserProfile(userID: Auth.auth().currentUser?.uid ?? "")
            }
        }
        
        
    }
    
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}
