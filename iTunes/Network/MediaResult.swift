//
//  MediaResult.swift
//  iTunes
//
//  Created by 이찬호 on 8/9/24.
//

import Foundation

struct MediaResult: Decodable {
    let resultCount: Int
    let results: [Media]
}

struct Media: Decodable {
    let artistName: String
    let trackName: String
    let artworkUrl100: String
    let longDescription: String
}
