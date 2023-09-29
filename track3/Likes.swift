//
//  Likes.swift
//  track3
//
//  Created by Pedro Alejandro LR on 9/26/23.
//

import Foundation


struct Likes: Codable, Identifiable {

    var id: UUID?
    var PostID: String
    var UserID: String
    
}
