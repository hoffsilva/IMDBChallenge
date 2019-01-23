//
//  Language.swift
//  IMBDMovies
//
//  Created by Hoff Henry Pereira da Silva on 02/12/2018.
//  Copyright © 2018 Hoff Henry Pereira da Silva. All rights reserved.
//

import Foundation
import Unbox

struct Language: Decodable {
    
    let iso        : String?
    let englishName: String?
    let name       : String?
    
}

extension Language {
    enum CodingKeys: String, CodingKey {
        case iso = "iso_639_1"
        case englishName = "english_name"
        case name
    }
}
