////
////  APIService.swift
////  Shortkathon_Project
////
////  Created by 도현학 on 11/16/24.
////
//
//import Foundation
//
//class APIService {
//    func fetchProjects(completion: @escaping (Result<[Project], Error>) -> Void) {
//        guard let url = NetworkManager.shared.makeURL(part: "GET") else {
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
//    
//    func fetchMembers(for projectId: Int, completion: @escaping (Result<[Member], Error>) -> Void) {
//        guard let url = NetworkManager.shared.makeURL(part: "MEMBERGET", id: projectId) else {
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
//                let members = try JSONDecoder().decode([Member].self, from: data)
//                completion(.success(members))
//            } catch {
//                completion(.failure(NetworkError.decodingError(error)))
//            }
//        }.resume()
//    }
//    
//    func fetchTasks(for projectId: Int, completion: @escaping (Result<[Task], Error>) -> Void) {
//        guard let url = NetworkManager.shared.makeURL(part: "TASKGET", id: projectId) else {
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
//                let tasks = try JSONDecoder().decode([Task].self, from: data)
//                completion(.success(tasks))
//            } catch {
//                completion(.failure(NetworkError.decodingError(error)))
//            }
//        }.resume()
//    }
//    
//    func postProject(name: String, completion: @escaping (Result<Project, Error>) -> Void) {
//        guard let url = NetworkManager.shared.makeURL(part: "POSTPROJECT") else {
//            print("🧨 Invalid URL for POST project")
//            completion(.failure(NetworkError.noData))
//            return
//        }
//        
//        var request = URLRequest(url: url)
//        request.httpMethod = "POST"
//        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
//        
//        // JSON 데이터 생성
//        let requestData = ["name": name]
//        
//        do {
//            request.httpBody = try JSONSerialization.data(withJSONObject: requestData, options: [])
//        } catch {
//            print("🧨 Encoding error: \(error)")
//            completion(.failure(NetworkError.decodingError(error)))
//            return
//        }
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
//            
//            do {
//                let createdProject = try JSONDecoder().decode(Project.self, from: data)
//                completion(.success(createdProject))
//            } catch {
//                print("🧨 Decoding Error: \(error)")
//                completion(.failure(NetworkError.decodingError(error)))
//            }
//        }.resume()
//    }
//
//    
//    func postMember(_ member: Member, for projectId: Int, completion: @escaping (Result<Member, Error>) -> Void) {
//        guard let url = NetworkManager.shared.makeURL(part: "POSTMEMBER") else {
//            print("🧨 Invalid URL for POST Member")
//            completion(.failure(NetworkError.noData))
//            return
//        }
//        
//        var request = URLRequest(url: url)
//        request.httpMethod = "POST"
//        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
//        
//        do {
//            request.httpBody = try JSONEncoder().encode(member)
//        } catch {
//            print("🧨 Encoding error: \(error)")
//            completion(.failure(NetworkError.decodingError(error)))
//            return
//        }
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
//            
//            do {
//                let createdMember = try JSONDecoder().decode(Member.self, from: data)
//                completion(.success(createdMember))
//            } catch {
//                completion(.failure(NetworkError.decodingError(error)))
//            }
//        }.resume()
//    }
//    
//    func postTask(_ task: Task, for projectId: Int, completion: @escaping (Result<Task, Error>) -> Void) {
//        guard let url = NetworkManager.shared.makeURL(part: "POSTTASK") else {
//            print("🧨 Invalid URL for POST Task")
//            completion(.failure(NetworkError.noData))
//            return
//        }
//        
//        var request = URLRequest(url: url)
//        request.httpMethod = "POST"
//        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
//        
//        do {
//            request.httpBody = try JSONEncoder().encode(task)
//        } catch {
//            print("🧨 Encoding error: \(error)")
//            completion(.failure(NetworkError.decodingError(error)))
//            return
//        }
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
//            
//            do {
//                let createdTask = try JSONDecoder().decode(Task.self, from: data)
//                completion(.success(createdTask))
//            } catch {
//                completion(.failure(NetworkError.decodingError(error)))
//            }
//        }.resume()
//    }
//}
//
//enum NetworkError: Error {
//    case noData
//    case decodingError(Error)
//}
