//
//  NewListView.swift
//  track3
//
//  Created by Pedro Alejandro LR on 9/11/23.
//

import SwiftUI
import SDWebImageSwiftUI

struct NewListView: View {
    @State var Message = ""
    @State private var isLiked = false
    var body: some View {
        
        
        
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
                
                Text("@Senpai")
                    .font(.callout)
                Text("-")
                    .font(.callout)
                Text("3h")
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
                Text(Message)
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
    

}

//struct NewListView_Previews: PreviewProvider {
//    static var previews: some View {
//        NewListView()
//    }
//}
