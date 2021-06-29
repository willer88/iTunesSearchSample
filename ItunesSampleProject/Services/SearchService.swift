//
//  SearchService.swift
//  ItunesSampleProject
//
//  Created by Wilmar on 28/06/21.
//

import Combine
import Foundation

protocol SearchWorkerProtocol {
    func searchTerm(with term: String) -> AnyPublisher<SearchResponse, Error>
}

struct SearchWorker: SearchWorkerProtocol {
    func searchTerm(with term: String) -> AnyPublisher<SearchResponse, Error> {
        
        var request = URLRequest(url: .search(with: term))
        request.setValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")
        request.setValue("application/json; charset=utf-8", forHTTPHeaderField: "Accept")
        request.httpMethod = "GET"
        
        return URLSession.shared
            .dataTaskPublisher(for: request)
            .map(\.data)
            .decode(type: SearchResponse.self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
    }
}
