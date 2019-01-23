//
//  Country.swift
//  IMBDMovies
//
//  Created by Hoff Henry Pereira da Silva on 02/12/2018.
//  Copyright © 2018 Hoff Henry Pereira da Silva. All rights reserved.
//

import Foundation

struct Country: Decodable {
    let iso3166: String
    let englishName: String
}

extension Country {
    enum CondingKeys: String, CodingKey {
        case englishName = "english_name"
        case iso3166 = "iso_3166_1"
    }
}
