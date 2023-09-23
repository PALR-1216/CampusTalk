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

struct ListView: View {
    @EnvironmentObject var dataManager:DataManager
    @State private var showSheet = false
    @State private var isLiked = false
//    @State private var isLoading = false
    var body: some View {
        
        NavigationView {
            
            ScrollView{
//                if dataManager.isLoading {
//                    VStack {
//
//                        ProgressView("Loading...")
//                            .padding()
//
//                    }
//                }else{
                    
                    
                    ForEach(dataManager.posts, id:\.id){post in
                        
                        
                        VStack {
                            
                            
                            //            ZStack {
                            //                WebImage(url: URL(string: "https://www.nicepng.com/png/full/970-9708408_universidad-interamericana-de-puerto-rico-inter-metro.png"))
                            //                    .resizable()
                            //                    .scaledToFit()
                            //                    .frame(width: 300, height: 300)
                            //                    .padding()
                            //            }
                            Divider()
                            
                            
                            
                            
                            HStack {
                                
                                Text("@\(post.User)")
                                    .font(.callout)
                                Text("-")
                                    .font(.callout)
                                
                                Text(post.createdAtAgoString)
                                    .font(.callout)
                                
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
                                    
                                    Button(action: {
                                        // Handle the action for the second menu item
                                    }) {
                                        HStack {
                                            Image(systemName: "trash")
                                            Text("Delete")
                                        }
                                    }
                                    
                                    Button(action: {
                                        // Handle the action for the third menu item
                                    }) {
                                        HStack {
                                            Image(systemName: "arrow.down.circle")
                                            Text("Export")
                                        }
                                    }
                                }label: {
                                    Image(systemName: "ellipsis")
                                    
                                }
                                .menuStyle(BorderlessButtonMenuStyle())
                                
                                .padding(.trailing, 10)
                                
                            }
                            .padding(10)
                            .foregroundColor(.gray)
                            
                            
                            
                            
                            HStack {
                                Text(post.postContent)
                                    .padding()
                                
                                Spacer()
                            }
                            
                            
                            
                            
                            .fontWeight(.semibold)
                            
                            
                            HStack {
                                Button {
                                    
                                } label: {
                                    Label("comment", systemImage: "ellipsis.message")
                                        .labelStyle(IconOnlyLabelStyle())
                                        .font(.title2)
                                    
                                    
                                }
                                //                .padding(.horizontal,50)
                                
                                
                                Button {
                                    isLiked = true
                                    
                                    
                                } label: {
                                    Label("Like", systemImage: isLiked ? "heart.fill" : "heart")
                                        .labelStyle(IconOnlyLabelStyle())
                                        .font(.title2)
                                        .foregroundColor(isLiked ? .red : .black)
                                }
                                //                .padding(.horizontal,50)
                                
                                
                                
                                
                                Spacer()
                            }
                            .padding(.top, 5)
                            .padding()
                            .foregroundColor(.black)
                            //            Divider()
                            
                            
                        }
                    }
//                }
                
            }
            
            .onAppear{
//                isLoading = true
                dataManager.fetchPost(UsersUni: dataManager.UsersUni)

               
//                DispatchQueue.main.asyncAfter(deadline: .now() + 1) { // Simulated 2-second delay
//                    dataManager.fetchPost(UsersUni: dataManager.UsersUni)
//                    isLoading = false
//                }
//
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








struct ListView_Previews: PreviewProvider {
    static var previews: some View {
        ListView()
    }
}
