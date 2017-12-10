//
//  Classes.swift
//  DnDApp
//
//  Created by C4Q on 12/8/17.
//  Copyright © 2017 C4Q. All rights reserved.
//

import Foundation

struct ClassInfo: Codable {
    let results: [ClassList]
}
struct ClassList: Codable {
    let name: String
    let url: String
}

struct ClassListAPIClient {
    private init() {}
    static let manager = ClassListAPIClient()
    func getClasses(from urlStr: String, completionHandler: @escaping ([ClassList]) -> Void, errorHandler: @escaping (AppError) -> Void) {
        guard let url = URL(string: urlStr) else {
            errorHandler(.badURL)
            return
        }
        let completion: (Data) -> Void = {(data: Data) in
            do {
                let classInfo = try JSONDecoder().decode(ClassInfo.self, from: data)
                completionHandler(classInfo.results)
            } catch {
                errorHandler(.couldNotParseJSON(rawError: error))
            }
        }
        NetworkHelper.manager.performDataTask(with: URLRequest(url: url), completionHandler: completion, errorHandler: errorHandler)
    }
}
