//
//  ListView.swift
//  track3
//
//  Created by Pedro Alejandro LR on 8/25/23.
//

import SwiftUI
import SDWebImageSwiftUI
import Firebase
import FirebaseFirestore
import AuthenticationServices
import GoogleSignIn
import GoogleSignInSwift
import Lottie

struct ListView: View {
    @EnvironmentObject var dataManager:DataManager
    @State private var showSheet = false
    @State private var isLiked = false
    
    
//    @State private var isLoading = false
    var body: some View {
        
        NavigationView {
            ZStack{
        //            Color.purple.opacity(0.58).ignoresSafeArea(.all)
                    Circle()
                        .foregroundColor(.yellow.opacity(0.20))
                        .blur(radius: 8)
                        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
                        .offset(x: -90, y: -200)
                    Circle()
                        .foregroundColor(.green.opacity(0.20))
                        .blur(radius: 8)
                        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottomLeading)
                        .offset(x: 80, y: 200)
                
                if dataManager.isLoading {
//                    ProgressView("Loading")
            
                    
                }
                
                ScrollView{
                    
                    
                    
                    
                    
                    
                    if dataManager.posts.isEmpty {
                        ShowEmptyView()
                        
                    }
                    
                    else{
                        
                        
                        ForEach(dataManager.posts, id:\.id){post in
                            
                            
                            NListView(usersUni: post.university, userName: post.User, TimeAgo: post.createdAtAgoString, postContent: post.postContent, Likes: post.LikesCount, postID: post.id, UserID: Auth.auth().currentUser?.uid ?? "", IsLiked: false)
                        }
                        
                    }
                }
            }
            
            .onAppear{
                
//                isLoading = true
                dataManager.fetchPost(UsersUni: dataManager.UsersUni)

               
//                DispatchQueue.main.asyncAfter(deadline: .now() + 1) { // Simulated 2-second delay
//                    dataManager.fetchPost(UsersUni: dataManager.UsersUni)
//                    isLoading = false
//                }
              
            }
            
            .navigationTitle("Confesiones")
            .navigationBarItems(trailing: Button(action: {
                // button activates link
                
                showSheet.toggle()
                
            } ) {
                Image(systemName: "plus")
                    .resizable()
                    .padding(6)
                    .frame(width: 30, height: 30)
                    .background(Color.blue)
                    .clipShape(Circle())
                    .foregroundColor(.white)
                
            } )
        }
        
        
        
        .sheet(isPresented: $showSheet) {
            BottomSheet()
        }
        
        .refreshable {
            //            dataManager.fetchPost(userID: Auth.auth().currentUser!.uid)
            //            dataManager.fetchUserProfile(userID: Auth.auth().currentUser!.uid)
            //            dataManager.fetchPost(userID: dataManager)
            //            dataManager.fethUserProfile(userID: dataManager.userID)
            dataManager.fetchPost(UsersUni: dataManager.UsersUni)
            
        
        }
            
        
    }
}

struct ShowEmptyView: View {
    var body: some View{
        VStack {
            LottieView(name: "LoadingLottie", loopMode: .loop)
//                .frame(width: 300, height: 300)
           
        }
        Spacer()
        
    }
}








struct ListView_Previews: PreviewProvider {
    static var previews: some View {
        ListView()
    }
}
