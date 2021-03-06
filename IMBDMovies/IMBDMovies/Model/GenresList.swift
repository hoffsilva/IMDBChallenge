//
//  GenreList.swift
//  IMBDMovies
//
//  Created by Hoff Henry Pereira da Silva on 04/12/2018.
//  Copyright © 2018 Hoff Henry Pereira da Silva. All rights reserved.
//

struct GenresList: Decodable {
    let genres: [Genre]?
}

extension GenresList {
    private enum CodingKeys: String, CodingKey {
        case genres
    }
}
