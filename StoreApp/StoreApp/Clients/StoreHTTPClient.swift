//
//  StoreHTTPClient.swift
//  StoreApp
//
//  Created by kirshi on 8/10/23.
//

import Foundation

enum NetworkError: Error {
    case badUrl
    case invalidResponse
    case decodingError
    case invalidServerError
    case invalidURL
}

enum HttpMethod {
    case get([URLQueryItem])
    case post(Data?)
    case delete
    
    var name: String {
        switch self {
        case .get:
            return "GET"
        case .post(_):
            return "POST"
        case .delete:
            return "DELETE"
        }
    }
}

struct Resource<T: Codable> {
    var url: URL
    var headers: [String: String] = ["Content-Type": "application/json"]
    var method: HttpMethod = .get([])
}

class StoreHTTPClient {
    
    func load<T: Codable>(_ resource: Resource<T>) async throws -> T {
        var request = URLRequest(url: resource.url)
        request.allHTTPHeaderFields = resource.headers
        request.httpMethod = resource.method.name
        
        switch resource.method {
        case .get(let queryItems):
            var components = URLComponents(url: resource.url, resolvingAgainstBaseURL: true)
            components?.queryItems = queryItems
            guard let url = components?.url else {
                throw NetworkError.badUrl
            }
            request.url = url
            break
        case .post(let data):
            request.httpBody = data
            break
        case .delete:
            break
        }
        
        let configuration = URLSessionConfiguration.default
        configuration.httpAdditionalHeaders = resource.headers
        
        let session = URLSession(configuration: configuration)
        
        let (data, response) = try await session.data(for: request)
        
        if let jsonString = String(data: data, encoding: .utf8) {
            print("JSON Body: \(jsonString)")
        } else {
            print("Unable to convert data to JSON string.")
        }
        
        if let httpResponse = response as? HTTPURLResponse {
            print("Status Code: \(httpResponse.statusCode)")
        } else {
            print("Invalid response type or no HTTPURLResponse")
        }
        
        guard let httpResponse = response as? HTTPURLResponse,
              httpResponse.statusCode == 200 || httpResponse.statusCode == 201
        else {
            throw NetworkError.invalidResponse
        }
        
        print(httpResponse.statusCode)
        
        guard let result = try? JSONDecoder().decode(T.self, from: data) else {
            throw NetworkError.decodingError
        }
        
        return result;
    }
    
    
//    func getCategories(url: URL) async throws -> [Category] {
//        let (data, response) = try await URLSession.shared.data(from: url)
//
//        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
//            throw NetworkError.invalidResponse
//        }
//
//        guard let categories = try? JSONDecoder().decode([Category].self, from: data) else {
//            throw NetworkError.decodingError
//        }
//
//        return categories
//    }
//
//    func getProductsByCategory(url: URL) async throws -> [Product] {
//        let (data, response) = try await URLSession.shared.data(from: url)
//
//        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
//            throw NetworkError.invalidResponse
//        }
//
//        guard let product = try? JSONDecoder().decode([Product].self, from: data) else {
//            throw NetworkError.decodingError
//        }
//
//        return product
//    }
}
