//
//  TestModelPerformance.swift
//  HXHSwiftHub
//
//  Created by huangyu on 2021/8/23.
//

import Foundation
import ObjectMapper

class TestModelPerformance: Mappable {
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        
    }
    
    
}
enum CodingKeys: String,CodingKey {
    case username = "username"
    case age = "age"
    case weight = "weight"
    case arr = "arr"
    case dict = "dict"
    case best_friend = "best_friend"
    case friends = "friends"
}
class DecoderUser: NSObject, Decodable {
    var username: String?
    var age: Int?
    var weight: Double!
    var array: [Any]?
    var dictionary: [String : Any] = [:]
//    var bestFriend: DecoderUser?                       // Nested User object
//    var friends: [DecoderUser]?                        // Array of Users
//    var birthday: Date?
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.username = try container.decodeIfPresent(String.self, forKey: .username)
        self.age = try container.decodeIfPresent(Int.self, forKey: .age)
        self.weight = try container.decodeIfPresent(Double.self, forKey: .weight)
//        self.array = try container.decodeIfPresent(Any.self, forKey: .arr)
//        self.dictionary = try container.decodeIfPresent([String : Any].self, forKey: .dict)
//        self.bestFriend = try container.decode(DecoderUser.self, forKey: .best_friend)
    }
}
class User: NSObject, Mappable {
    var username: String?
    var age: Int?
    var weight: Double!
    var array: [Any]?
    var dictionary: [String : Any] = [:]
    var bestFriend: User?                       // Nested User object
    var friends: [User]?                        // Array of Users
//    var birthday: Date?

    required init?(map: Map) {

    }

    // Mappable
    func mapping(map: Map) {
        username    <- map["username"]
        age         <- map["age"]
        weight      <- map["weight"]
        array       <- map["arr"]
        dictionary  <- map["dict"]
        bestFriend  <- map["best_friend"]
        friends     <- map["friends"]
//        birthday    <- (map["birthday"], DateTransform())
    }
}
