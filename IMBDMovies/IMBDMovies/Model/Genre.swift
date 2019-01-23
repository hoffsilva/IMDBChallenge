//
//  Genre.swift
//  IMBDMovies
//
//  Created by Hoff Henry Pereira da Silva on 04/12/2018.
//  Copyright © 2018 Hoff Henry Pereira da Silva. All rights reserved.
//

import Foundation

struct Genre: Decodable {
    let id: Int
    let name: String
}

extension Genre {
    enum CodingKeys: String, CodingKey {
        case id, name
    }
}
