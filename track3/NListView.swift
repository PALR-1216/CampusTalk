//
//  testView.swift
//  track3
//
//  Created by Pedro Alejandro LR on 9/24/23.
//

import SwiftUI

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
                Image("\(usersUni)")
                    .resizable()
                    .scaledToFit()
                    .clipShape(Circle())
                    .frame(width: 60, height: 100)
                    .padding(.leading, 5)
                Text("@\(userName)")
                    .fontWeight(.bold)
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
                        
                        
                    } label: {
                        Label("\(Likes)", systemImage: "heart")
                            .font(.title2)
                        
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
        }
        
    }
}

struct testView_Previews: PreviewProvider {
    static var previews: some View {
        NListView()
    }
}

