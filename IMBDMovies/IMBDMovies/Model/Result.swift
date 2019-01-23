//
//  Result.swift
//  IMBDMovies
//
//  Created by Hoff Henry Pereira da Silva on 30/11/2018.
//  Copyright © 2018 Hoff Henry Pereira da Silva. All rights reserved.
//

struct Result: Decodable {
    
    let results       :  [Movie]!
    let page          :  Int
    let totalResults  :  Int
    let dates         :  Dates
    let totalPages    :  Int
    
}

extension Result {
    enum CodingKeys: String, CodingKey {
        case results, page, dates
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }
}
