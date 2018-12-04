//
//  Genre.swift
//  IMBDMovies
//
//  Created by Hoff Henry Pereira da Silva on 04/12/2018.
//  Copyright © 2018 Hoff Henry Pereira da Silva. All rights reserved.
//

import Foundation
import Unbox

struct Genre {
    let id   : Int?
    let name : String?
}

extension Genre: Unboxable {
    
    init(unboxer: Unboxer) throws {
        self.id   = try? unboxer.unbox(key: "id")
        self.name = try? unboxer.unbox(key: "name")
    }
    
}
