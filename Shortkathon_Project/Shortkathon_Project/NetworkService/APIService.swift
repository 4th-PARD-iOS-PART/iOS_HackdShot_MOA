//
//  APIService.swift
//  6th_hw_HyeonhakDo
//
//  Created by 도현학 on 10/30/24.
//

import Foundation

enum NetworkError: Error {
    case noData
    case decodingError(Error)
}

//class APIService {
//    func fetchProjects(completion: @escaping (Result<[Project], Error>) -> Void) {
//        guard let url = NetworkManager.shared.makeURL(part: "projects") else {
//            print("🧨 Invalid URL")
//            completion(.failure(NetworkError.noData))
//            return
//        }
//        
//        var request = URLRequest(url: url)
//        request.httpMethod = "GET"
//        
//        URLSession.shared.dataTask(with: request) { data, response, error in
//            if let error = error {
//                print("🧨 Error: \(error.localizedDescription)")
//                completion(.failure(error))
//                return
//            }
//            
//            guard let data = data else {
//                completion(.failure(NetworkError.noData))
//                return
//            }
//            do {
//                let projects = try JSONDecoder().decode([Project].self, from: data)
//                completion(.success(projects))
//            } catch {
//                completion(.failure(NetworkError.decodingError(error)))
//            }
//        }.resume()
//    }
//}
