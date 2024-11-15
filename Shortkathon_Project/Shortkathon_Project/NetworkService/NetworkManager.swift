////
////  NetworkManager.swift
////  6th_hw_HyeonhakDo
////
////  Created by 도현학 on 10/30/24.
////
//
//import Foundation
//
//class NetworkManager {
//    static let shared = NetworkManager()
//    private let baseURL = "http://172.17.198.87:8080"
//    
//    func makeURL(part: String, id: Int? = nil) -> URL? {
//        switch part {
//        case "GET":  // GET /projects
//            return URL(string: "\(baseURL)/projects")
//        case "MEMBERGET": // GET /projects/{id}/member
//            if let id = id {
//                return URL(string: "\(baseURL)/projects/\(id)/members")
//            }
//            print("🧨 Missing ID for MEMBER request")
//            return nil
//        case "TASKGET":
//            if let id = id {
//                return URL(string: "\(baseURL)/tasks/\(id)")
//            }
//            print("🧨 Missing ID for Tasks request")
//            return nil
//        case "POSTPROJECT":
//            return URL(string: "\(baseURL)/projects")
//        case "POSTMEMBER":
//            return URL(string: "\(baseURL)/projects/\(id)/members")
//        case "POSTTASK":
//            return URL(string: "\(baseURL)/tasks/\(id)")
//        case "DELETE", "PATCH":
//            if let id = id {
//                return URL(string: "\(baseURL)/user/\(id)")
//            }
//            print("🧨 Missing ID for \(part) request")
//            return nil
//        default:
//            print("🧨 Invalid part")
//            return nil
//        }
//    }
//}
