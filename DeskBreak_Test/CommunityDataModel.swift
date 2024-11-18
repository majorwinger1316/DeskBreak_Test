//
//  CommunityDataModel.swift
//  DeskBreak_Community2
//
//  Created by admin44 on 04/11/24.
//

import Foundation

// Member struct to represent individual members in a community
public struct Member {
    public let id: Int
    public let name: String
    public let details: String
    public let profilePic: String
    
    // Public initializer for Member struct
    public init(id: Int, name: String, details: String, profilePic: String) {
        self.id = id
        self.name = name
        self.details = details
        self.profilePic = profilePic
    }
}

// Updated Community struct with members and code
public struct Community {
    public let name: String
    public let icon: String
    public let code: String
    public var members: [Member]
    
    // Public initializer for Community struct
    public init(name: String, icon: String, code: String, members: [Member]) {
        self.name = name
        self.icon = icon
        self.code = code
        self.members = members
    }
}

// Updated array with sample communities and members
public var communities = [
    Community(
        name: "Family",
        icon: "person.3",
        code: "5668",
        members: [
            Member(id: 1, name: "Alice", details: "Loves cooking and reading.", profilePic: "a"),
            Member(id: 2, name: "Bob", details: "Enjoys hiking and photography.", profilePic: "b")
        ]
    ),
    Community(
        name: "Friends",
        icon: "person.3.fill",
        code: "3346",
        members: [
            Member(id: 3, name: "Charlie", details: "Musician and artist.", profilePic: "c"),
            Member(id: 4, name: "Daisy", details: "Sports enthusiast and gamer.", profilePic: "d")
        ]
    ),
    Community(
        name: "Apple",
        icon: "applelogo",
        code: "4456",
        members: [
            Member(id: 5, name: "Eve", details: "Tech enthusiast and developer.", profilePic: "e"),
            Member(id: 6, name: "Frank", details: "iOS developer and designer.", profilePic: "f")
        ]
    )
]

