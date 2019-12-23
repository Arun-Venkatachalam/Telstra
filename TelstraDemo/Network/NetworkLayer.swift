//
//  NetworkLayer.swift
//  TelstraDemo
//
//  Created by Arun.V on 20/12/19.
//  Copyright © 2019 Arun.V. All rights reserved.
//

import Foundation

let sharedInstance = NetworkLayer()

class NetworkLayer : NSObject {
    
    func getMyCountryData(_ value: String, completion: @escaping (_ countryData: Data?) -> Void) {
        guard let dataUrl = URL(string: value) else { return }
        URLSession.shared.dataTask(with: dataUrl) { (data, response, error) in
             guard let data = data else { return }
            let str = String(decoding: data, as: UTF8.self)
            let encodedData = str.data(using: .utf8)!
            completion(encodedData)
        }.resume()
    }
    
    func downloadAndReturnImage(_ urlStr: String, completion: @escaping (_ imageData: Data?) -> Void) {
        guard let dataUrl = URL(string: urlStr) else { return }
        URLSession.shared.dataTask(with: dataUrl) { (data, response, error) in
            if error != nil {
                print("I am getting error")
                completion(nil)
            }
             guard let data = data else {
                print("I am getting something")
                completion(nil)
                return
            }
            completion(data)
        }.resume()
    }
    
}
