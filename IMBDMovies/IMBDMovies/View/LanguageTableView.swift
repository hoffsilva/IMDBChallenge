//
//  TranslateTableView.swift
//  IMBDMovies
//
//  Created by Hoff Henry Pereira da Silva on 02/12/2018.
//  Copyright © 2018 Hoff Henry Pereira da Silva. All rights reserved.
//

import Foundation
import UIKit
import FCAlertView



class LanguageTableView: UITableViewController {
    
    var selectedLanguage = IndexPath()
    
    var languageViewModel = LanguageViewModel()
    
    let alertView = FCAlertView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        alertView.delegate = self
        languageViewModel.langaugeViewModelDelegate = self
        pleaseWait()
        tableView.isHidden = true
        languageViewModel.getPrimaryTranslations()
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return languageViewModel.translations.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "languageCell", for: indexPath) as! LanguageTableViewCell
        cell.languageLabel.text = languageViewModel.getTranslationName(by: indexPath).uppercased() + " - " + languageViewModel.getTranslationCountry(by: indexPath)
        if languageViewModel.isSelectedLanguage(by: indexPath) {
            cell.accessoryType = .checkmark
        } else {
            cell.accessoryType = .none
        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedLanguage = indexPath
        alertView.blurBackground = true
        alertView.hideDoneButton = true
        alertView.makeAlertTypeCaution()
        alertView.showAlert(withTitle: "Change Language", withSubtitle: "Would You like to alter the app's language?", withCustomImage: nil, withDoneButtonTitle: nil, andButtons: ["YES", "NO"])
    }
    
}

extension LanguageTableView: FCAlertViewDelegate {
    
    func fcAlertView(_ alertView: FCAlertView!, clickedButtonIndex index: Int, buttonTitle title: String!) {
        if title == "YES" {
            languageViewModel.setDefaulTranslation(by: selectedLanguage)
            navigationController?.popViewController(animated: true)
        } else {
            alertView.dismiss()
        }
    }
    
}

extension LanguageTableView: LangaugeViewModelDelegate {
    
    func didNotLoadLanguages(message: String) {
        clearAllNotice()
        noticeOnlyText(message)
    }
    
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
        tableView.reloadData()
        tableView.isHidden = false
        clearAllNotice()
    }
    
}
