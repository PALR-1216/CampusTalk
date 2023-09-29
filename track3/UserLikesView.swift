//
//  UserLikesView.swift
//  track3
//
//  Created by Pedro Alejandro LR on 8/27/23.
//

import SwiftUI
import Firebase


struct UserLikesView: View {
    @EnvironmentObject var dataManager:DataManager
    var body: some View {
        NavigationView{
            VStack {
                ScrollView{
                    Text("hell oworld")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                }
                
                .navigationTitle("Likes")
            }
           
        }
        .onAppear {
            dataManager.fetchLikes(userID: Auth.auth().currentUser?.uid ?? ""  )
            
        }
    }
    
        
}

struct UserLikesView_Previews: PreviewProvider {
    static var previews: some View {
        UserLikesView()
    }
}
