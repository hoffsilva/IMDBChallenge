//
//  Genre.swift
//  IMBDMovies
//
//  Created by Hoff Henry Pereira da Silva on 04/12/2018.
//  Copyright © 2018 Hoff Henry Pereira da Silva. All rights reserved.
//

struct Genre: Decodable {
    let id: Int
    let name: String
}

extension Genre {
    private enum CodingKeys: String, CodingKey {
        case id, name
    }
}
