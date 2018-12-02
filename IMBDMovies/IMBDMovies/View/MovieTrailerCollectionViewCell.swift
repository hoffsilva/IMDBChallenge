//
//  MovieTrailerCollectionViewCell.swift
//  IMBDMovies
//
//  Created by Hoff Henry Pereira da Silva on 02/12/2018.
//  Copyright © 2018 Hoff Henry Pereira da Silva. All rights reserved.
//

import Foundation
import UIKit
import WebKit

class MovieTrailerCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var movieTrailerWebView: WKWebView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
}

extension MovieTrailerCollectionViewCell: WKNavigationDelegate {
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        activityIndicator.stopAnimating()
    }
    
}
