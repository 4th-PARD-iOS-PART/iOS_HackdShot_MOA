//
//  NetworkManager.swift
//  6th_hw_HyeonhakDo
//
//  Created by 도현학 on 10/30/24.
//

import Foundation

class NetworkManager {
    static let shared = NetworkManager()
//    private let baseURL = "http://172.17.198.87:8080"
    private let baseURL = "http://ec2-13-209-3-68.ap-northeast-2.compute.amazonaws.com:8080"
    
    func makeURL(part: String, id: Int? = nil) -> URL? {
        
        if part == "all" {  // GET MODE
            return URL(string: "\(baseURL)/user?part=\(part)")
        } else if part == "POST" {  // POST MODE
            return URL(string: "\(baseURL)/user")
        } else if part == "DELETE" || part == "PATCH" { // PATCH, DELETE MODE
            if let id = id {
                return URL(string: "\(baseURL)/user/\(id)")
            }
            print("🧨 Missing ID for \(part) request")
            return nil
        } else {
            print("🧨 Invalid part")
            return nil
        }
    }
}
