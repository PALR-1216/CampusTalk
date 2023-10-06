//
//  UserLikesView.swift
//  track3
//
//  Created by Pedro Alejandro LR on 8/27/23.
//

import SwiftUI
import Firebase
import SDWebImageSwiftUI


struct UserLikesView: View {
    @EnvironmentObject var dataManager:DataManager
    @State var IsLiked: Bool = false
    var body: some View {
        NavigationView{
            
            if dataManager.likedPost.isEmpty {
                ShowEmptyView()
                
            }
            
            else {
                
                ScrollView{
                    ForEach(dataManager.likedPost, id:\.id) { post in
                        
                        
                        VStack {
                            Divider()
                            HStack {
                                //                Image("\(usersUni)")
                                WebImage(url: URL(string: "https://robohash.org/\(post.User)"))
                                
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 55, height: 100)
                                    .cornerRadius(60 / 2)
                                    .overlay(
                                        Circle()
                                            .stroke(Color.white, lineWidth: 4)
                                            .frame(width: 60, height: 100)
                                    )
                                    .shadow(radius: 10)
                                    .padding(.leading, 5)
                                Text("@\(post.User)")
                                    .fontWeight(.bold)
                                    .padding(.leading, 2)
                                Spacer()
                                
                                
                                
                                Menu {
                                    Button(action: {
                                        // Handle the action for the first menu item
                                    }) {
                                        HStack {
                                            Image(systemName: "exclamationmark.bubble")
                                            Text("Report")
                                        }
                                    }
                                    
                                }label: {
                                    Image(systemName: "ellipsis")
                                    
                                }
                                .menuStyle(BorderlessButtonMenuStyle())
                                .foregroundColor(.black)
                                .padding(.trailing, 10)
                                
                            }
                            HStack{
                                
                                Text(post.postContent)
                                    .font(.title3)
                                    .padding(.leading,10)
                                
                                
                                Spacer()
                            }
                            
                            VStack {
                                HStack {
                                    //                                Button {
                                    //                                    //
                                    //                                    dataManager.LikePost(postId: post.id , userID: Auth.auth().currentUser?.uid ?? "" )
                                    //                                    let Generator = UIImpactFeedbackGenerator(style: .medium)
                                    //                                    Generator.impactOccurred()
                                    //
                                    //                                } label: {
                                    //
                                    //                                    //                        Label("\(Likes)", systemImage: "heart")
                                    //                                    Text("\(post.LikesCount)")
                                    //                                        .font(.title3)
                                    //
                                    //                                    Image(systemName: IsLiked ? "heart.fill" : "heart")
                                    //                                        .font(.title2)
                                    //                                        .foregroundColor(IsLiked ? .red : .black)
                                    //
                                    //
                                    //                                }
                                    
                                    Button {
                                        
                                    } label: {
                                        Image(systemName: "trash")
                                            .foregroundColor(.red)
                                    }
                                    
                                    
                                    Button {
                                        
                                    } label: {
                                        Image(systemName: "message")
                                            .font(.title2)
                                    }
                                    
                                    Spacer()
                                }
                                .foregroundColor(.black)
                                .padding(.top, 10)
                                .padding(.leading,5)
                                
                            }
                            
                            .onAppear {
                                DispatchQueue.global(qos: .background).async {
                                    dataManager.checkIfPostIsLikedInLikesCollection(postId: post.id) { Liked in
                                        if (Liked) {
                                            //                            dataManager.isLiked = true
                                            IsLiked = true
                                        } else {
                                            //                            dataManager.isLiked = false
                                            IsLiked = false
                                        }
                                    }
                                }
                            }
                        }
                    }
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
