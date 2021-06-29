//
//  URL+Endpoints.swift
//  ItunesSampleProject
//
//  Created by Wilmar on 28/06/21.
//

import Foundation

extension URL {
    static func search(with term: String) -> URL {
        guard let formattedTerm = term.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        else { preconditionFailure("Could not create query search string")}
        return makeForEndpoint("search?term=\(formattedTerm)&limit=20")
    }
}

private extension URL {
    static func makeForEndpoint(_ endpoint: String) -> URL {
        URL(string: "https://itunes.apple.com/\(endpoint)")!
    }
}
