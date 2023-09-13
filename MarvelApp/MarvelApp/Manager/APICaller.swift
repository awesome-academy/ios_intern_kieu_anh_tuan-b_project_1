//
//  APICaller.swift
//  MarvelApp
//
//  Created by Tobi on 12/09/2023.
//

import Foundation

enum  APIError: Error {
    case failedToGetData
}

class APICaller {
    static let shared = APICaller()

    func apiIdentifier() -> String? {
        var keys: NSDictionary?
        var identifier: String?

        if let path = Bundle.main.path(forResource: "key", ofType: "plist") {
            keys = NSDictionary(contentsOfFile: path)
        }

        let timeStamp = keys?["timeStamp"] as? String
        let apiKey = keys?["apiKey"] as? String
        let hashValue = keys?["hashValue"] as? String

        if let timeStamp = timeStamp, let apiKey = apiKey, let hashValue = hashValue {
            identifier = "ts=\(timeStamp)&apikey=\(apiKey)&hash=\(hashValue)"
        }

        return identifier
    }

    func getInformation<T: Decodable>(dataType: T.Type, categoryType: CategoryType,
                                      completion: @escaping (Result<T, Error>) -> Void) {

        guard let apiIdentifier = self.apiIdentifier() else {
            return
        }

        guard let url = URL(
                string: "\(Endpoint.baseURL)/v1/public/\(categoryType.rawValue)?\(apiIdentifier)") else { return }

        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, _, error in
            guard let data = data, error == nil else {
                return
            }

            do {
                let results = try JSONDecoder().decode(dataType.self, from: data)
                completion(.success(results))
            } catch {
                completion(.failure(APIError.failedToGetData))
            }

        }
        task.resume()
    }
}
