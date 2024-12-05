//
//  dataModel.swift
//  DeskBreak_Test
//
//  Created by admin@33 on 02/12/24.
//

import Foundation
import CoreData
import UIKit

struct UserRegistrationData {
    var profilePicture: UIImage? = nil
    var profilePictureURL: String? = nil
    var username: String = ""
    var dateOfBirth: String = ""
    var email: String = ""
    var contactNumber: String = ""
    var password: String = ""
    var dailyTarget: Int16 = 0
}


@objc(User)
public class User: NSManagedObject {
    @NSManaged public var userId: UUID
    @NSManaged public var username: String
    @NSManaged public var email: String
    @NSManaged public var passwordHash: String
    @NSManaged public var profilePicture: String?
    @NSManaged public var dailyTarget: Int16
    @NSManaged public var totalMinutes: Int32
    @NSManaged public var totalPoints: Int32
    @NSManaged public var createdAt: Date
    @NSManaged public var dateOfBirth: Date
    @NSManaged public var contactNumber: String
    @NSManaged public var gameSessions: Set<GameSession>
    @NSManaged public var communities: Set<CommunityMembership>
}

@objc(GameSession)
public class GameSession: NSManagedObject {
    @NSManaged public var sessionId: UUID
    @NSManaged public var startTime: Date
    @NSManaged public var endTime: Date
    @NSManaged public var minutesPlayed: Int16
    @NSManaged public var pointsEarned: Int16
    @NSManaged public var user: User
}

@objc(Community)
public class Community: NSManagedObject {
    @NSManaged public var communityId: UUID
    @NSManaged public var communityName: String
    @NSManaged public var descriptionText: String
    @NSManaged public var createdBy: UUID
    @NSManaged public var createdAt: Date
    @NSManaged public var members: Set<CommunityMembership>
}

@objc(CommunityMembership)
public class CommunityMembership: NSManagedObject {
    @NSManaged public var membershipId: UUID
    @NSManaged public var joinedAt: Date
    @NSManaged public var user: User
    @NSManaged public var community: Community
}

@objc(LeaderboardEntry)
public class LeaderboardEntry: NSManagedObject {
    @NSManaged public var entryId: UUID
    @NSManaged public var date: Date
    @NSManaged public var points: Int32
    @NSManaged public var rank: Int16
    @NSManaged public var user: User
}

@objc(GlobalLeaderboard)
public class GlobalLeaderboard: NSManagedObject {
    @NSManaged public var leaderboardId: UUID
    @NSManaged public var type: String
    @NSManaged public var startDate: Date
    @NSManaged public var endDate: Date
    @NSManaged public var leaderboardEntries: Set<LeaderboardEntry>
}
