//
//  DataStruct.swift
//  Shortkathon_Project
//
//  Created by 김도원 on 11/16/24.
//

import Foundation


struct Name {
    let name: String
}


struct Task {
    let taskName: String
}

struct Project {
    let projectName: String
}


struct DataStruct {
    static var names: [Name] = []
    static var tasks: [Task] = []
    static var projects: [Project] = []
}
