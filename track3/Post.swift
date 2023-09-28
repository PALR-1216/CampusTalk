//
//  Post.swift
//  track3
//
//  Created by Pedro Alejandro LR on 8/25/23.
//

import Foundation
import SwiftUI
import Firebase


struct Posts:Identifiable, Hashable {
    var id: String
    var postContent:String
    var university:String
    var timeStamp: Timestamp
    var User:String
    var UserID:String
    var LikesCount: Int
//    var isLiked: Bool 
    
    var createdAtAgoString: String {
           let currentDate = Date()
           let secondsAgo = Int(currentDate.timeIntervalSince(timeStamp.dateValue()))
           
           if secondsAgo < 60 {
               return "\(secondsAgo)s ago"
           } else if secondsAgo < 3600 {
               let minutesAgo = secondsAgo / 60
               return "\(minutesAgo)m ago"
           } else if secondsAgo < 86400 {
               let hoursAgo = secondsAgo / 3600
               return "\(hoursAgo)h ago"
           } else {
               let daysAgo = secondsAgo / 86400
               return "\(daysAgo)d ago"
           }
       }
}

