//
//  CountryViewModel.swift
//  TelstraDemo
//
//  Created by Arun.V on 20/12/19.
//  Copyright © 2019 Arun.V. All rights reserved.
//

import Foundation
import UIKit

class CountryViewModel: NSObject {
    var title: String?
    var rows: [RowDetail]?
    let constants = Constants()
    
    func fetchCountryData(completion: @escaping (_ modelData: CountryViewModel) -> Void) {
        //Completion demo method
        sharedInstance.getMyCountryData(constants.downloadUrl) { (countryData) in
            if let countryData = countryData {
                do {
                     let country = try JSONDecoder().decode(Country.self, from: countryData)
                     self.title = country.title
                     self.rows = country.rows
                     self.filterModelObject()
                     completion(self)
                 } catch let error as NSError {
                    print(error)
                }
            } else {
                self.title = "No country data found"
                return
            }
        }
    }
    
    func filterModelObject() {
        var updatedRows: [RowDetail] = []
        guard let rows = self.rows else { return }
        for value in rows {
            let shouldAddRow = (value.title != nil || value.description != nil || value.imageHref != nil)
            if (shouldAddRow) {
                updatedRows.append(value)
            }
        }
        self.rows = updatedRows
    }
    
    func getImageForUrl(_ url: String, completion: @escaping (_ image: UIImage?) -> Void) {
        sharedInstance.downloadAndReturnImage(url) { (imageData) in
            if let imgData = imageData {
                DispatchQueue.main.async {
                    completion(UIImage(data: imgData))
                }
            }
        }
    }
}

