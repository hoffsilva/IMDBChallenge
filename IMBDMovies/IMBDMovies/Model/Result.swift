//
//  Result.swift
//  IMBDMovies
//
//  Created by Hoff Henry Pereira da Silva on 30/11/2018.
//  Copyright © 2018 Hoff Henry Pereira da Silva. All rights reserved.
//

import Unbox

struct Result {
    
    let results       :  [Movie]?
    let page          :  Int?
    let total_results :  Int?
    let dates         :  Dates?
    let total_pages   :  Int?
    
}

extension Result: Unboxable {
    
    init(unboxer: Unboxer) throws {
        self.results       = try? unboxer.unbox(key: "results")
        self.page          = try? unboxer.unbox(key: "page")
        self.total_results = try? unboxer.unbox(key: "total_results")
        self.dates         =      unboxer.unbox(key: "dates")
        self.total_pages   = try? unboxer.unbox(key: "total_pages")
    }
    
}
