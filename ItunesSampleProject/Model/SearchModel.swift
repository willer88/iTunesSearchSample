//
//  SearchModel.swift
//  ItunesSampleProject
//
//  Created by Wilmar on 28/06/21.
//

import Combine
import Foundation

struct SearchModel {
    var worker: SearchWorkerProtocol?
    
    init(worker: SearchWorkerProtocol) {
        self.worker = worker
    }
    
    func searchTerm(with term: String) -> AnyPublisher<SearchResponse, Error> {
        guard let worker = worker else { preconditionFailure("Could not instantiate Search worker") }
        return worker.searchTerm(with: term)
    }
}
