//
//  SearchResponse.swift
//  ItunesSampleProject
//
//  Created by Wilmar on 28/06/21.
//

import Foundation

struct SearchResultResponse: Codable {
    var artistName: String?
    var artworkUrl100: String?
    var collectionName: String?
    var trackName: String?
    var trackCount: Int?
}

struct SearchResponse: Codable {
    var resultCount: Int?
    var results: [SearchResultResponse]
}
