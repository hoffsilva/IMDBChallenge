//
//  JSONDecoder+Request.swift
//  IMBDMovies
//
//  Created by Cast Group on 28/01/19.
//  Copyright © 2019 Hoff Henry Pereira da Silva. All rights reserved.
//

import Foundation
import Alamofire
import FCAlertView

extension JSONDecoder {
    
    public func decode<Element: Decodable>(_ type: Element.Type, url: String, completion: @escaping (Element) -> Void) {
        if VerifyConnection.isConnected {
            Alamofire.request(url).responseJSON { response in
                guard let secureData = response.data else {
                    return
                }
                do {
                    let object = try self.decode(type, from: secureData)
                    completion(object)
                } catch {
                    print(error)
                }
                
            }
        }
    }
    
}
