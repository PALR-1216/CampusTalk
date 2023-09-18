//
//  ListView.swift
//  track3
//
//  Created by Pedro Alejandro LR on 8/25/23.
//

import SwiftUI
import SDWebImageSwiftUI
import Firebase

struct ListView: View {
    @EnvironmentObject var dataManager:DataManager
    @State private var showSheet = false
    var body: some View {
        NavigationView {
            
            ScrollView {
                ForEach(dataManager.posts, id: \.self){post in
                    
                    NewListView(Message: post.postContent)
                    NavigationLink {
                        
                        //
                        
                        
                    } label: {
                        
                   
                    
                    LazyVStack{
//                        ZStack {
//
//                            WebImage(url: URL(string: "https://futbolboricua.co/wp-content/uploads/2016/01/Inter-Logo.png"))
//                                .resizable()
//                                .overlay(
//                                    Rectangle()
//                                        .foregroundColor(.black)
//                                        .opacity(0.3)
//                                )
//
//                                .scaledToFit()
//                                .cornerRadius(8)
//                                .padding()
//                                .shadow(radius: 10)
//
//
//                            VStack{
//                                HStack{
//                                    Text("Confesion")
//                                        .font(.title)
//                                        .foregroundColor(.white)
//                                        .fontWeight(.heavy)
//                                        .padding()
//                                    Spacer()
//                                    Text(post.university)
//                                        .font(.body)
//                                        .foregroundColor(.white)
//                                        .fontWeight(.bold)
//                                        .padding()
//                                }
//                                .padding(10)
//
//                                Spacer()
//
//                            }
//
//                            Text(post.postContent)
//                                .lineLimit(1)
//                                .foregroundColor(.white)
//                                .fontWeight(.heavy)
//                                .padding()
//                                .font(.title)
//                        }
                    }
                       
                        
                    }
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

            .onAppear{
                dataManager.fetchPost()
            }
         
        }
       
        .sheet(isPresented: $showSheet) {
            BottomSheet()
        }
        
        .refreshable {
            dataManager.fetchPost()
            
        }
    }
}








struct ListView_Previews: PreviewProvider {
    static var previews: some View {
        ListView()
    }
}
