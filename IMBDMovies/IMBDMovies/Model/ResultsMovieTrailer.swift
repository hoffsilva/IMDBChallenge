//
//  ResultsMovieTrailer.swift
//  IMBDMovies
//
//  Created by Hoff Henry Pereira da Silva on 02/12/2018.
//  Copyright © 2018 Hoff Henry Pereira da Silva. All rights reserved.
//

import Foundation

struct ResultsMovieTrailer: Decodable {
    let id      : Int
    let results : [MovieTrailer]
}

extension ResultsMovieTrailer {
    enum CodingKeys: String, CodingKey {
        case id, results
    }
}
