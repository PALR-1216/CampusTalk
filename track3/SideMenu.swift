//
//  SideMenu.swift
//  TwiiterUIMenu
//
//  Created by Pedro Alejandro LR on 8/30/23.
//

import SwiftUI

struct SideMenu: View {
    @Binding var ShowMenu: Bool
    var body: some View {
        VStack(alignment: .leading, spacing: 0){
            VStack(alignment: .leading, spacing: 14) {
                Image(systemName: "person.circle")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 65, height: 65)
                
                    Text("Pedro Lorenzo")
                    .font(.title2.bold())
                
                HStack(spacing: 12) {
                    Button {
                        
                        
                    } label: {
                        Label {
                            Text("followers")
                        } icon: {
                            Text("111")
                                .fontWeight(.bold)
                        }

                    }
                    
                    
                    Button {
                        
                        
                    } label: {
                        Label {
                            Text("Following")
                        } icon: {
                            Text("1.2M")
                                .fontWeight(.bold)
                        }

                    }

                }
//                .foregroundColor(.primary)
            }
            
            .padding(.horizontal)
            .padding(.top)
            .padding(.leading)
            
            ScrollView(.vertical, showsIndicators: false) {
                VStack {
                    VStack(alignment: .leading, spacing: 45) {
                        TabButton(title: "Profile", image: "person", color: .black)
                        TabButton(title: "Settings", image: "gear", color:.black)
                        TabButton(title: "Likes", image: "heart.circle", color:.black)
                        
                        TabButton(title: "", image: "", color: .red)
                        TabButton(title: "", image: "", color: .red)
                        TabButton(title: "", image: "", color: .red)
                        TabButton(title: "", image: "", color: .red)
                        TabButton(title: "", image: "", color: .red)
                        
                        
                        
                    }
                    .padding()
                    .padding()
                    .padding(.top, 35)
                    Divider()
                    HStack(spacing: 14){
                        TabButton(title: "About", image: "info.circle", color:.black)
                            .padding()
                            .padding(.leading)
                        
                        TabButton(title: "Log Out", image: "rectangle.portrait.and.arrow.right", color:.red)
                            .padding()
                            
//                            .padding(.leading)
                        
                    }
                   
                    Divider()
                   
                }
                
            }
        }
        .frame(maxWidth: .infinity , alignment: .leading)
        .frame(width: getRect().width - 90)
        .frame(maxHeight: .infinity)
        .background(Color.primary.opacity(0.04))
        .ignoresSafeArea(.container, edges: .vertical)
        .frame(maxWidth: .infinity, alignment: .leading)
    }
    
    
    
    @ViewBuilder
    func TabButton(title:String, image:String, color:Color) -> some View {
        Button {
            
        } label: {
            HStack(spacing: 14) {
                Image(systemName: image)
                    .resizable()
                    .renderingMode(.template)
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 22, height: 22)
                    .foregroundColor(color)
                Text(title)
                    .foregroundColor(color)
                
            }
            .foregroundColor(.primary)
            .frame(maxWidth: .infinity, alignment: .leading)
        }

    }
    
}

struct SideMenu_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


extension View{
    func getRect() ->CGRect{
        return UIScreen.main.bounds
    }
}

