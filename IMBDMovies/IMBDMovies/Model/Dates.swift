//
//  Dates.swift
//  IMBDMovies
//
//  Created by Hoff Henry Pereira da Silva on 30/11/2018.
//  Copyright © 2018 Hoff Henry Pereira da Silva. All rights reserved.
//

struct Dates: Decodable {
    let maximum: String?
    let minimum: String?

    init(maximum: String, minimum: String) {
        self.maximum = maximum
        self.minimum = minimum
    }
}

extension Dates {
    private enum CodingKeys: String, CodingKey {
        case maximum, minimum
    }
}
