//
//  MovieTrailer.swift
//  IMBDMovies
//
//  Created by Hoff Henry Pereira da Silva on 02/12/2018.
//  Copyright © 2018 Hoff Henry Pereira da Silva. All rights reserved.
//

import Foundation

struct MovieTrailer: Decodable {
    
    let id             : String
    let languageCode   : String
    let countryCode    : String
    let key            : String
    let name           : String
    let site           : String
    let size           : Int
    let type           : String
    
}

extension MovieTrailer {
    enum CodingKeys: String, CodingKey {
        case id, key, name, site, size, type
        case languageCode = "iso_639_1"
        case countryCode  = "iso_3166_1"
    }
}
