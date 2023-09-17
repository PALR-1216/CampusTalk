//
//  UserLikesView.swift
//  track3
//
//  Created by Pedro Alejandro LR on 8/27/23.
//

import SwiftUI

struct UserLikesView: View {
    var body: some View {
        NavigationView{
            ScrollView{
                Text("hell oworld")
                    .font(.largeTitle)
                    .fontWeight(.bold)
            }
            
            .navigationTitle("Likes")
        }
        
    }
}

struct UserLikesView_Previews: PreviewProvider {
    static var previews: some View {
        UserLikesView()
    }
}
