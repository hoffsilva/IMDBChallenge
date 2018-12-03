//
//  ServiceRequest.swift
//  IMBDMovies
//
//  Created by Hoff Henry Pereira da Silva on 01/12/2018.
//  Copyright © 2018 Hoff Henry Pereira da Silva. All rights reserved.
//

import Foundation
import Alamofire
import Unbox
import FCAlertView

typealias obj = (Any?) -> Swift.Void

struct ServiceRequest {
    
    fileprivate static var isConnected = true
    
    static func fetchData(endPointURL: String, responseJSON: @escaping obj) {
        if isConnected {
            Alamofire.request(endPointURL.trimmingCharacters(in: .whitespaces)).responseJSON { (response) in
                if let pt = response.value as? Array<String>{
                    responseJSON(pt)
                    return
                }
                
                if let countries = response.value as? Array<UnboxableDictionary> {
                    responseJSON(countries)
                    return
                }
                responseJSON(response.value as? UnboxableDictionary)
                
            }
        } else {
            responseJSON(nil)
            return
        }
    }
    
    static func verifyConnection(){
        guard let reachabilityNetwork = Alamofire.NetworkReachabilityManager(host: "www.google.com") else {
            return
        }
        isConnected = reachabilityNetwork.isReachable
        if !reachabilityNetwork.isReachable {
            DispatchQueue.main.async {
                let alert = FCAlertView()
                alert.showAlert(
                    withTitle: "Error",
                    withSubtitle: "The internet connection has some problem 🤔",
                    withCustomImage: nil,
                    withDoneButtonTitle: nil,
                    andButtons: nil)
                alert.dismissOnOutsideTouch = true
                alert.hideDoneButton = true
                alert.makeAlertTypeCaution()
            }
        }
    }
    
}
