//
//  ErrorResponse.swift
//  IMBDMovies
//
//  Created by Hoff Henry Pereira da Silva on 03/12/2018.
//  Copyright © 2018 Hoff Henry Pereira da Silva. All rights reserved.
//

import Foundation
import Unbox

struct ErrorResponse {
    
    let status_code   : Int
    let status_message: String
    
}

extension ErrorResponse: Unboxable {
    
    init(unboxer: Unboxer) throws {
        self.status_code    = try unboxer.unbox(key: "status_code")
        self.status_message = try unboxer.unbox(key: "status_message")
    }
    
}
