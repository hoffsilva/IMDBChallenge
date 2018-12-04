//
//  ResultsMovieTrailer.swift
//  IMBDMovies
//
//  Created by Hoff Henry Pereira da Silva on 02/12/2018.
//  Copyright © 2018 Hoff Henry Pereira da Silva. All rights reserved.
//

import Foundation
import Unbox

struct ResultsMovieTrailer {
    let id      : Int
    let results : [MovieTrailer]
}

extension ResultsMovieTrailer: Unboxable {
    
    init(unboxer: Unboxer) throws {
        self.id      = try unboxer.unbox(key: "id")
        self.results = try unboxer.unbox(key: "results")
    }
    
}
