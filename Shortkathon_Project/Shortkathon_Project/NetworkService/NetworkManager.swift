//
//  NetworkManager.swift
//  Shortkathon_Project
//
//  Created by 현승훈 on 11/16/24.
//

//
//  NetworkManager.swift
//  Server
//
//  Created by 김도원 on 11/15/24.
//

import Foundation

class NetworkManager {
    static let shared = NetworkManager()
    private let baseURL = "http://ec2-13-209-3-68.ap-northeast-2.compute.amazonaws.com:8080"
    
    private init() {}

    func request<T: Codable>(_ endpoint: String,
                            method: String,
                            parameters: [String: String]? = nil,
                            body: Codable? = nil,
                            completion: @escaping (Result<T, Error>) -> Void) {
        
        // MARK: - URL 생성 부분입니당!
        // 기본 URL + 엔드포인트
        var urlString = baseURL + endpoint
        if let parameters = parameters {
            let queryItems = parameters.map { URLQueryItem(name: $0.key, value: $0.value) }
            var components = URLComponents(string: urlString)!
            components.queryItems = queryItems
            urlString = components.url?.absoluteString ?? urlString
        }
        
        // URL이 유효한지 체크해요!
        guard let url = URL(string: urlString) else {
            completion(.failure(NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "Invalid URL"])))
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = method
        
        // body가 있으면 JSON으로 인코딩해서 추가할것!
        if let body = body {
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            do {
                request.httpBody = try JSONEncoder().encode(body)
            } catch {
                completion(.failure(error))
                return
            }
        }
        
        // MARK: - 네트워크 요청 실행 부분이에요!!
        URLSession.shared.dataTask(with: request) { data, response, error in
            
            // 에러 체크 해주고~
            if let error = error {
                completion(.failure(error))
                return
            }
            
            // 데이터 존재 체크한다음~
            guard let data = data else {
                completion(.failure(NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "No data"])))
                return
            }
            
            // 받은 데이터를 요청한 타입으로 디코딩 하기!
            do {
                let decodedResponse = try JSONDecoder().decode(T.self, from: data)
                completion(.success(decodedResponse))
            } catch {
                completion(.failure(error))
            }
        }.resume() // 요청 시자악!
    }
}
