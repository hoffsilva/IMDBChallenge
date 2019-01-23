//
//  ErrorResponse.swift
//  IMBDMovies
//
//  Created by Hoff Henry Pereira da Silva on 03/12/2018.
//  Copyright © 2018 Hoff Henry Pereira da Silva. All rights reserved.
//

import Foundation
import Unbox

struct ErrorResponse: Decodable {
    let statusCode: Int
    let statusMessage: String
}

extension ErrorResponse {
    enum CodingKeys: String, CodingKey {
        case statusCode = "status_code"
        case statusMessage = "status_message"
    }
}
