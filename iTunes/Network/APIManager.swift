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
    
    func callRequest(term: String) -> Observable<MediaResult> {
//        let url = "https://itunes.apple.com/search?"
        let url = "https://itunes.apple.com/search?term=\(term)&country=KR&lang=ko_KR&media=movie"
//        term=%ED%83%9D%EC%8B%9C&country=KR&lang=ko_KR
        let result = Observable<MediaResult>.create { observer in
            let sessionConfig = URLSessionConfiguration.default
            sessionConfig.httpAdditionalHeaders = ["User-Agent": "dsaf"]
            let session = URLSession(configuration: sessionConfig)
            guard let url = URL(string: url) else {
                observer.onError(APIError.invalidURL)
                return Disposables.create()
            }
            var urlRequest = URLRequest(url: url)
            urlRequest.allHTTPHeaderFields = [
                "User-Agent": "myItunes"
            ]

            session.dataTask(with: url) { data, response, error in
                guard error == nil else {
                    observer.onError(APIError.unknownResponse)
                    return
                }
                guard let response = response as? HTTPURLResponse ,
                    (200...299).contains(response.statusCode) else {
                    observer.onError(APIError.statusError)
                    return
                }
                if let data = data,
                   let appData = try? JSONDecoder().decode(MediaResult.self, from: data) {
                    observer.onNext(appData)
                    observer.onCompleted()
                }
                else {
                    observer.onError(APIError.decodingFail)
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
