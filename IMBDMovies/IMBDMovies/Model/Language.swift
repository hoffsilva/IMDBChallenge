//
//  Language.swift
//  IMBDMovies
//
//  Created by Hoff Henry Pereira da Silva on 02/12/2018.
//  Copyright © 2018 Hoff Henry Pereira da Silva. All rights reserved.
//

import Foundation
import Unbox

struct Language {
    
    let iso_639_1   : String?
    let english_name: String?
    let name        : String?
    
}

extension Language: Unboxable {
    
    init(unboxer: Unboxer) throws {
        self.iso_639_1    = try? unboxer.unbox(key: "iso_639_1")
        self.english_name = try? unboxer.unbox(key: "english_name")
        self.name         = try? unboxer.unbox(key: "name")
    }
    
}
