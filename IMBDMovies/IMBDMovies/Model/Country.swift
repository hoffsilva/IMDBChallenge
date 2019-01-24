//
//  Country.swift
//  IMBDMovies
//
//  Created by Hoff Henry Pereira da Silva on 02/12/2018.
//  Copyright © 2018 Hoff Henry Pereira da Silva. All rights reserved.
//

struct Country: Decodable {
    let englishName: String
    let iso: String
}

extension Country {
    private enum CodingKeys: String, CodingKey {
        case englishName = "english_name"
        case iso = "iso_3166_1"
    }
}
