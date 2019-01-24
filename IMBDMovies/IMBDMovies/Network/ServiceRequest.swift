//
//  ServiceRequest.swift
//  IMBDMovies
//
//  Created by Hoff Henry Pereira da Silva on 01/12/2018.
//  Copyright © 2018 Hoff Henry Pereira da Silva. All rights reserved.
//

import Alamofire
import FCAlertView
import Foundation
import Unbox

typealias object = (Data?) -> Swift.Void

struct ServiceRequest {
    fileprivate static var isConnected = true
    
    static func fetchData(endPointURL: String, responseJSON: @escaping object) {
        if isConnected {
            Alamofire.request(endPointURL.trimmingCharacters(in: .whitespaces)).responseJSON { response in
                if let pt = response.data {
                    responseJSON(pt)
                    return
                }
            }
        } else {
            responseJSON(nil)
            return
        }
    }
    
    static func verifyConnection() {
        guard let reachabilityNetwork = Alamofire.NetworkReachabilityManager(host: "www.google.com") else {
            return
        }
        isConnected = reachabilityNetwork.isReachable
        if !reachabilityNetwork.isReachable {
            DispatchQueue.main.async {
                let alert = FCAlertView()
                alert.showAlert(
                    withTitle: "Internet Connection",
                    withSubtitle: "You are offline.",
                    withCustomImage: nil,
                    withDoneButtonTitle: nil,
                    andButtons: nil)
                alert.autoHideSeconds = 5
                alert.dismissOnOutsideTouch = true
                alert.hideDoneButton = true
                alert.makeAlertTypeWarning()
            }
        }
    }
}
