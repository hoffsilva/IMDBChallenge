//
//  GenreList.swift
//  IMBDMovies
//
//  Created by Hoff Henry Pereira da Silva on 04/12/2018.
//  Copyright © 2018 Hoff Henry Pereira da Silva. All rights reserved.
//

import Foundation
import Unbox

struct GenresList {
    let genres : [Genre]?
}

extension GenresList: Unboxable {
    
    init(unboxer: Unboxer) throws {
        self.genres = try? unboxer.unbox(key: "genres")
    }
    
}
