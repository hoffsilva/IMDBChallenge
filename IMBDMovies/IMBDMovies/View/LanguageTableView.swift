//
//  TranslateTableView.swift
//  IMBDMovies
//
//  Created by Hoff Henry Pereira da Silva on 02/12/2018.
//  Copyright © 2018 Hoff Henry Pereira da Silva. All rights reserved.
//

import Foundation
import UIKit

class LanguageTableView: UITableViewController {
    
    var languageViewModel = LanguageViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        languageViewModel.langaugeViewModelDelegate = self
        languageViewModel.getPrimaryTranslations()
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return languageViewModel.translations.count
    }
    
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
}

extension LanguageTableView: LangaugeViewModelDelegate {
    
    func didLoadPrimaryTranslations() {
        languageViewModel.getCountries()
    }
    
    func didLoadCountries() {
        languageViewModel.getLanguages()
    }
    
    func didLoadLanguages() {
        languageViewModel.getTranslations()
    }
    
    func didLoadTranslations() {
        print("")
    }
    
}
