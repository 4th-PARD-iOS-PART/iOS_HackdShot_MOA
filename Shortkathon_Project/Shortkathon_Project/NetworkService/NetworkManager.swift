//
//  NetworkManager.swift
//  6th_hw_HyeonhakDo
//
//  Created by 도현학 on 10/30/24.
//

import Foundation

class NetworkManager {
    static let shared = NetworkManager()
    private let baseURL = "http://ec2-13-209-3-68.ap-northeast-2.compute.amazonaws.com:8080"
    
    func makeURL(part: String, id: Int? = nil) -> URL? {
        switch part {
        case "projects":  // GET /projects
            return URL(string: "\(baseURL)/projects")
        case "POST":
            return URL(string: "\(baseURL)/user")
        case "DELETE", "PATCH":
            if let id = id {
                return URL(string: "\(baseURL)/user/\(id)")
            }
            print("🧨 Missing ID for \(part) request")
            return nil
        default:
            print("🧨 Invalid part")
            return nil
        }
    }
}
