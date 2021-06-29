//
//  AlbumsViewModel.swift
//  ItunesSampleProject
//
//  Created by Wilmar on 27/06/21.
//

import Foundation
import Combine

struct AlbumViewModel: Hashable {
    var uuid = UUID()
    var artistName: String?
    var iconURL: String?
    var albumName: String?
    var trackCount: String?
    var trackName: String?
}

final class AlbumsViewModel: ObservableObject {
    @Published private(set) var results: [AlbumViewModel]
    @Published private(set) var error: Error?
    private var cancellable = Set<AnyCancellable>()
    private var model: SearchModel
    
    init(model: SearchModel) {
        self.model = model
        self.results = []
    }
    
    func search(with term: String) {
        model.searchTerm(with: term)
            .sink { completion in
                if case .failure(let error) = completion {
                    self.error = error
                }
            } receiveValue: { response in
                self.results = response
                    .results
                    .map({ AlbumViewModel(artistName: $0.artistName,
                                          iconURL: $0.artworkUrl100,
                                          albumName: $0.collectionName,
                                          trackCount: "Track count: \(String($0.trackCount ?? 0))",
                                          trackName: $0.trackName)
                    })
            }
            .store(in: &cancellable)

    }
}
