//
//  APIManager.swift
//  iTunes
//
//  Created by 이찬호 on 8/9/24.
//

import Foundation
import RxSwift

final class APIManager {
    
    static let shared = APIManager()
    
    private init() {}
    
    func callRequest(term: String) -> Single<MediaResult> {
        let url = "https://itunes.apple.com/search?term=\(term)&country=KR&lang=ko_KR&media=movie"
        let result = Single<MediaResult>.create { single in
            let sessionConfig = URLSessionConfiguration.default
            sessionConfig.httpAdditionalHeaders = ["User-Agent": "dsaf"]
            let session = URLSession(configuration: sessionConfig)
            guard let url = URL(string: url) else {
                single(.failure(APIError.invalidURL))
                return Disposables.create()
            }
            var urlRequest = URLRequest(url: url)
            urlRequest.allHTTPHeaderFields = [
                "User-Agent": "myItunes"
            ]

            session.dataTask(with: url) { data, response, error in
                guard error == nil else {
                    single(.failure(APIError.unknownResponse))
                    return
                }
                guard let response = response as? HTTPURLResponse ,
                    (200...299).contains(response.statusCode) else {
                    single(.failure(APIError.statusError))
                    return
                }
                if let data = data,
                   let appData = try? JSONDecoder().decode(MediaResult.self, from: data) {
                    single(.success(appData))
                }
                else {
                    single(.failure(APIError.decodingFail))
                }
            }
            .resume()
            return Disposables.create()
        }
        
        return result
    }
    
    
    enum APIError: Error {
        case invalidURL
        case urlCompenetFail
        case unknownResponse
        case statusError
        case decodingFail
    }
}
