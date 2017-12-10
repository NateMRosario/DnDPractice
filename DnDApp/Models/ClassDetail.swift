//
//  ClassDetail.swift
//  DnDApp
//
//  Created by C4Q on 12/8/17.
//  Copyright © 2017 C4Q. All rights reserved.
//

import Foundation

struct ClassDetail: Codable {
    let hit_die: Int
}

//struct ClassDetail: Codable {
//    let name: String
//    let hitDie: Int
//    let profSkills: [Proficiency]
//    let profEquip: [Equipment]
//    let savingThrows: [SavingThrow]
//    enum CodingKeys: String, CodingKey {
//        case name
//        case hitDie = "hit_die"
//        case profSkills = "proficiency_choices"
//        case profEquip = "proficiencies"
//        case savingThrows = "saving_throws"
//    }
//    ///ProfSkills
//    struct Proficiency: Codable {
//        let skillList: [Skill]
//        enum CodingKeys: String, CodingKey {
//            case skillList = "from"
//        }
//        struct Skill: Codable {
//            let name: String
//        }
//    }
//    ///ProfEquip
//    struct Equipment: Codable {
//        let name: String
//    }
//    ///SavingThrow
//    struct SavingThrow: Codable {
//        let name: String
//    }
//}

struct ClassDetailAPIClient {
    private init() {}
    static let manager = ClassDetailAPIClient()
    func getClassDetails(from urlStr: String, completionHandler: @escaping (ClassDetail) -> Void, errorHandler: @escaping (AppError) -> Void) {
        guard let url = URL(string: urlStr) else {
            errorHandler(.badURL)
            return
        }
        let completion: (Data) -> Void = {(data: Data) in
            do {
                let classDetail = try JSONDecoder().decode(ClassDetail.self, from: data)
                completionHandler(classDetail)
            } catch {
                errorHandler(.couldNotParseJSON(rawError: error))
            }
        }
        NetworkHelper.manager.performDataTask(with: URLRequest(url: url), completionHandler: completion, errorHandler: errorHandler)
    }
}

