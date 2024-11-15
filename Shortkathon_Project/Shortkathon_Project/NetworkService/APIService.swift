//
//  APIService.swift
//  6th_hw_HyeonhakDo
//
//  Created by 도현학 on 10/30/24.
//

import Foundation

class APIService {
//    var users: [MemberData] = []
    
    // GET FUNC
    func getRequest<T: Decodable>(completion: @escaping (Result<T, Error>) -> Void) {
        guard let url = NetworkManager.shared.makeURL(part: "all", id: 0) else {
            print("🧨 Invalid URL")
            completion(.failure(NetworkError.noData))
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                print("🧨 Error: \(error.localizedDescription)")
                completion(.failure(error))
                return
            }
            
            guard let data = data else {
                completion(.failure(NetworkError.noData))
                return
            }
            do {
                let decodeData = try JSONDecoder().decode(T.self, from: data)
                completion(.success(decodeData))
            } catch {
                completion(.failure(NetworkError.decodingError(error)))
            }
        }.resume()
    }
    
    // POST FUNC
    func postRequest<T: Codable>(body: T, completion: @escaping (Result<T, Error>) -> Void) {
        guard let url = NetworkManager.shared.makeURL(part: "POST", id: 0) else {
            print("🧨 Invalid URL")
            completion(.failure(NetworkError.noData))
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        do {
            request.httpBody = try JSONEncoder().encode(body)
        } catch {
            print("🧨 Encoding error: \(error)")
            completion(.failure(error))
            return
        }
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                print("Error: \(error.localizedDescription)")
                completion(.failure(error))
                return
            }
            if let data = data {
                if let dataString = String(data: data, encoding: .utf8) {
                    print("Success with data: \(dataString)")
                    completion(.success(body))
                } else {
                    print("🧨 Unable to decode data using UTF-8 encoding")
                    completion(.failure(NetworkError.noData))
                }
            }
        }.resume()
    }

    // PATCH FUNC
    func patchRequest<T: Codable>(id: Int?, body: T, completion: @escaping (Result<T, Error>) -> Void) {
        guard let url = NetworkManager.shared.makeURL(part: "PATCH", id: id) else {
            print("🧨 Invalid URL")
            completion(.failure(NetworkError.noData))
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "PATCH"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        do {
            request.httpBody = try JSONEncoder().encode(body)
        } catch {
            print("🧨 Encoding error: \(error)")
            completion(.failure(error))
            return
        }
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                print("🧨 Error: \(error.localizedDescription)")
                completion(.failure(error))
                return
            }

            if let data = data, !data.isEmpty {
                do {
                    let decodeData = try JSONDecoder().decode(T.self, from: data)
                    completion(.success(decodeData))
                } catch {
                    print("🧨 Decoding error")
                    if let dataString = String(data: data, encoding: .utf8) {
                        print("Received data from server: \(dataString)")
                    }
                    completion(.failure(NetworkError.decodingError(error)))
                }
            } else {
                print("Received empty response from server")
                completion(.success(body))
            }
        }.resume()
    }

    // DELETE FUNC
    func deleteRequest<T: Decodable>(id: Int?, completion: @escaping (Result<T?, Error>) -> Void) { // T?는 success(nil)을 위해서 : nodata인 경우에도 성공으로 간주하기 위해
        guard let url = NetworkManager.shared.makeURL(part: "DELETE", id: id) else {
            print("🧨 Invalid URL")
            completion(.failure(NetworkError.noData))
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "DELETE"
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                print("🧨 Error: \(error.localizedDescription)")
                completion(.failure(error))
                return
            }
            
            if let data = data, !data.isEmpty {
                do {
                    let decodedData = try JSONDecoder().decode(T.self, from: data)
                    completion(.success(decodedData))
                } catch {
                    print("🧨 Decoding error: \(error)")
                    completion(.failure(NetworkError.decodingError(error)))
                }
            } else {
                print("🧨 No data")
                completion(.success(nil))
            }
        }.resume()
    }
}

enum NetworkError: Error {
    case noData
    case decodingError(Error)
}
