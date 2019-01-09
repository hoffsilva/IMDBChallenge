//
//  Country.swift
//  IMBDMovies
//
//  Created by Hoff Henry Pereira da Silva on 02/12/2018.
//  Copyright © 2018 Hoff Henry Pereira da Silva. All rights reserved.
//

import Foundation

struct Country: Decodable {
    
    let iso_3166_1: String
    let english_name: String
    
}

extension Country {
    enum CondingKeys: String, CodingKey {
        case english_name, iso_3166_1
    }
}


