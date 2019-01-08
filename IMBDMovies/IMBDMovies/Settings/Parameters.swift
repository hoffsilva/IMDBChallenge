//
//  Parameters.swift
//  IMBDMovies
//
//  Created by Cast Group on 08/01/19.
//  Copyright © 2019 Hoff Henry Pereira da Silva. All rights reserved.
//

enum ParametersEnum: String,  PlistManager {
    
    static var plistName = "Parameters"
    
    case include_adult_param
    case query_param
    case api_key_param
    case page_param
    case language_param
}
