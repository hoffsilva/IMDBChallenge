//
//  Country.swift
//  IMBDMovies
//
//  Created by Hoff Henry Pereira da Silva on 02/12/2018.
//  Copyright © 2018 Hoff Henry Pereira da Silva. All rights reserved.
//

import Foundation
import Unbox

struct Country {
    
    let iso_3166_1  : String?
    let english_name: String?
    
    init(iso_3166_1: String, english_name: String) {
        self.iso_3166_1   = iso_3166_1
        self.english_name = english_name
    }
    
}

extension Country: Unboxable {
    
    init(unboxer: Unboxer) throws {
        self.iso_3166_1   = try? unboxer.unbox(key: "iso_3166_1")
        self.english_name = try? unboxer.unbox(key: "english_name")
    }
    
}


