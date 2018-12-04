//
//  Dates.swift
//  IMBDMovies
//
//  Created by Hoff Henry Pereira da Silva on 30/11/2018.
//  Copyright © 2018 Hoff Henry Pereira da Silva. All rights reserved.
//

import Unbox

struct Dates {
    let maximum: String?
    let minimum: String?
}

extension Dates: Unboxable {
    
    init(unboxer: Unboxer) throws {
        self.maximum = try? unboxer.unbox(key: "maximun")
        self.minimum = try? unboxer.unbox(key: "minimun")
    }
    
}

