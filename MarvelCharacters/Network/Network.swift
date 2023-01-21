//
//  Service.swift
//  Assesment1
//
//  Created by Mina Atef on 04/01/2023.
//

import Foundation
enum HTTPMethod: String {
    case post = "POST"
    case get = "GET"
}
class NetworkManager {
    
    static func request<T: Codable>(from urlString: String?, method: HTTPMethod, params: [URLQueryItem], successModel: T.Type) async throws -> Result<T, Error> {
        guard let urlString = urlString else {
            return .failure(NSError(domain: "", code: CustomError.noURL.code, userInfo: [NSLocalizedDescriptionKey: CustomError.noURL.key]))
        }
        var url = URLComponents(string: urlString)!
        url.queryItems = params
        var request  = URLRequest(url: url.url!)
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = method.rawValue
        let (data, response) = try await URLSession.shared.data(for: request)
        guard let httpResponse = response as? HTTPURLResponse else {
            return .failure(NSError(domain: "", code: CustomError.noHttpResponse.code, userInfo: [NSLocalizedDescriptionKey: CustomError.fileNotFound.key]))
        }
        if (200...299).contains(httpResponse.statusCode) {
            do {
                let decoder = JSONDecoder()
                let result = try decoder.decode(T.self, from: data)
                return .success(result)
            } catch {
                return .failure(NSError(domain: "\(urlString)", code: CustomError.faildtoPasrse.code, userInfo: [NSLocalizedDescriptionKey: CustomError.faildtoPasrse.key]))
            }
        } else {
            do {
                let decoder = JSONDecoder()
                let result = try decoder.decode(MarvelError.self, from: data)
                return .failure(NSError(domain: "\(urlString)", code: -1, userInfo: [NSLocalizedDescriptionKey: "\(result.message ?? "")"]))
            } catch {
                return .failure(NSError(domain: "\(urlString)", code: CustomError.faildtoPasrse.code, userInfo: [NSLocalizedDescriptionKey: CustomError.faildtoPasrse.key]))
            }
        }
        
    }
}
