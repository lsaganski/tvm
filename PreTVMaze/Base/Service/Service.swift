//
//  Service.swift
//  PreTVMaze
//
//  Created by Leonardo Saganski on 05/01/25.
//

import Foundation

enum ServiceError: Error {
    case urlError
    case requestError
    case decodingError
    
    func getMessage() -> String {
        switch self {
        case .urlError:
            return "Failed at processing URL"
        case .requestError:
            return "Failed at API request"
        case .decodingError:
            return "Failed at decoding response data"
        }
    }
}

class Service {
    //MARK: Public functions
    func get<T: Codable>(strUrl: String) async throws -> T {
        guard let url = URL(string: Constants.URL.baseUrl + strUrl) else {
            throw ServiceError.urlError
        }
        
        let (data, response) = try await URLSession.shared.data(from: url)

        guard (response as? HTTPURLResponse)?.statusCode == 200 else {
            throw ServiceError.requestError
        }
        
        
        let strData = String(data: data, encoding: .utf8) ?? ""
        if let _ = try? JSONSerialization.jsonObject(with: data, options: []) {
            debugPrint(strData.replacingOccurrences(of: "\\", with: "") as AnyObject)
        } else {
            debugPrint(strData)
        }

        
        
        guard let parsedData = try? JSONDecoder().decode(T.self, from: data) else {
            throw ServiceError.decodingError
        }
        
        return parsedData
    }
}
