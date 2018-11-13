//
//  ProfileInfo.swift
//  Companion
//
//  Created by Serhii PERKHUN on 10/17/18.
//  Copyright © 2018 Serhii PERKHUN. All rights reserved.
//

import Foundation

struct ProfileInfo {
    static var login: String?
    static var phone: String?
    static var email: String?
    static var wallet: Int?
    static var correction: Int?
    static var image: String?
    static var level: Float?
    static var location: String?
    static var projects: [(String, Float, Bool?)] = []
    static var skills: [(String, Float)] = []
    static var coalition_id: Int?
    static let coalitions = [
        URL(string: "https://cdn.intra.42.fr/coalition/cover/5/alliance_background.jpg"),
        URL(string: "https://cdn.intra.42.fr/coalition/cover/6/union_background.jpg"),
        URL(string: "https://cdn.intra.42.fr/coalition/cover/7/empire_background.jpg"),
        URL(string: "https://cdn.intra.42.fr/coalition/cover/8/hive_background.jpg")]
}
