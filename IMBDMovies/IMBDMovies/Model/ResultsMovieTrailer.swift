//
//  ResultsMovieTrailer.swift
//  IMBDMovies
//
//  Created by Hoff Henry Pereira da Silva on 02/12/2018.
//  Copyright © 2018 Hoff Henry Pereira da Silva. All rights reserved.
//

struct ResultsMovieTrailer: Decodable {
    let id: Int
    let results: [MovieTrailer]
}

extension ResultsMovieTrailer {
    private enum CodingKeys: String, CodingKey {
        case id, results
    }
}
