//
//  testView.swift
//  track3
//
//  Created by Pedro Alejandro LR on 9/24/23.
//

import SwiftUI
import SDWebImageSwiftUI

struct NListView:View {
    @EnvironmentObject var dataManager:DataManager
    @State var usersUni: String = ""
    @State var userName:String = ""
    @State var TimeAgo:String = ""
    @State var postContent: String = ""
    @State var Likes: Int = 0
    @State var postID: String = ""
    @State var UserID: String = ""
    @State var IsLiked: Bool = false
    
    
    var body: some View{
        VStack {
            Divider()
            HStack {
                
                WebImage(url: URL(string: "https://robohash.org/\(userName)"))
                    
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
                Text("@\(userName)")
                    .fontWeight(.bold)
                    .padding(.leading, 2)
                Spacer()
                
                    Text(TimeAgo)
                
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
                
                Text(postContent)
                    .font(.title3)
                    .padding(.leading,10)
                    
                    
                Spacer()
            }
            
            VStack {
                HStack {
                    Button {
                        //
                        dataManager.LikePost(postId: postID, userID: UserID )
                        let Generator = UIImpactFeedbackGenerator(style: .medium)
                        Generator.impactOccurred()
                        
                    } label: {
                        
//                        Label("\(Likes)", systemImage: "heart")
                        Text("\(Likes)")
                            .font(.title3)
                        
                        Image(systemName: IsLiked ? "heart.fill" : "heart")
                            .font(.title2)
                            .foregroundColor(IsLiked ? .red : .black)
                                    
                        
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
                    dataManager.checkIfPostIsLikedInLikesCollection(postId: postID) { Liked in
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



struct testView_Previews: PreviewProvider {
    static var previews: some View {
        NListView()
    }
}

