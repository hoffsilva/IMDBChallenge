//
//  MovieTrailer.swift
//  IMBDMovies
//
//  Created by Hoff Henry Pereira da Silva on 02/12/2018.
//  Copyright © 2018 Hoff Henry Pereira da Silva. All rights reserved.
//

import Foundation
import Unbox

struct MovieTrailer {
    
    let id         : String
    let iso_639_1  : String
    let iso_3166_1 : String
    let key        : String
    let name       : String
    let site       : String
    let size       : Int
    let type       : String
    
}

extension MovieTrailer: Unboxable {
    
    init(unboxer: Unboxer) throws {
        self.id         = try unboxer.unbox(key: "id")
        self.iso_639_1  = try unboxer.unbox(key: "iso_639_1")
        self.iso_3166_1 = try unboxer.unbox(key: "iso_3166_1")
        self.key        = try unboxer.unbox(key: "key")
        self.name       = try unboxer.unbox(key: "name")
        self.site       = try unboxer.unbox(key: "site")
        self.size       = try unboxer.unbox(key: "size")
        self.type       = try unboxer.unbox(key: "type")
    }
    
}
