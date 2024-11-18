//
//  PeopleDataModel.swift
//  DeskBreak_Test
//
//  Created by admin44 on 18/11/24.
//

import Foundation

struct Person: Codable {
    var name: String
    var age: Int
    var gender: String
    var dailyGoal: Int
    var height: Float
    var weight: Float
    var wheelchair: Bool
    var image: String
    var points: Int
    var communities: [String]
    var weeklyPoints: [Int]
    var loginData: LoginData
}

struct LoginData: Codable {
    var email: String
    var password: String
}

let sampleLoginData = LoginData(email: "john.doe@example.com", password: "securepassword123")

let samplePerson = Person(
    name: "John Doe",
    age: 30,
    gender: "Male",
    dailyGoal: 60, // Daily goal in minutes
    height: 5.9, // Height in feet
    weight: 75.0, // Weight in kg
    wheelchair: false,
    image: "john_doe.jpg", // Image filename or URL
    points: 1200, // Total points earned
    communities: ["Fitness Enthusiasts", "Weekend Warriors"], // List of community names
    weeklyPoints: [200, 300, 250, 220, 180, 150, 200], // Points for the past week
    loginData: sampleLoginData
)

let anotherPerson = Person(
    name: "Jane Smith",
    age: 28,
    gender: "Female",
    dailyGoal: 45,
    height: 5.5,
    weight: 65.0,
    wheelchair: false,
    image: "jane_smith.jpg",
    points: 980,
    communities: ["Yoga Lovers", "Healthy Living"],
    weeklyPoints: [180, 220, 240, 200, 190, 210, 200],
    loginData: LoginData(email: "jane.smith@example.com", password: "mypassword456")
)

let sampleData = [samplePerson, anotherPerson]


