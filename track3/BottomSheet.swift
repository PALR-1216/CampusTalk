//
//  BottomSheet.swift
//  track3
//
//  Created by Pedro Alejandro LR on 8/27/23.
//

import SwiftUI

struct BottomSheet: View {
    @EnvironmentObject var dataManager:DataManager
    @State private var Message = ""
    @State private var showingAlert = false

    var body: some View {
        VStack {
           Text("Add Post")
                .font(.largeTitle)
                .fontWeight(.bold)
                .padding(.top, 20)
            TextField("Place Post here", text: $Message, axis: .vertical)
                .textFieldStyle(.roundedBorder)
                .padding()

            Spacer()
            Button {
//                print(UUID().uuidString)
                if !Message.isEmpty {
                    dataManager.AddPost(Message: Message)
                    
                }
                else{
                    showingAlert.toggle()
                }
                
                
                
                
            } label: {
                Text("Add Post")
            }

        }
        .alert("Cant Post a empty confession", isPresented: $showingAlert) {
            Button("OK", role: .cancel) { }
        }
    }
}



struct BottomSheet_Previews: PreviewProvider {
    static var previews: some View {
        BottomSheet()
    }
}
