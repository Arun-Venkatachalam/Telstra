//
//  CountryModel.swift
//  TelstraDemo
//
//  Created by Arun.V on 20/12/19.
//  Copyright © 2019 Arun.V. All rights reserved.
//

import Foundation

struct RowDetail: Decodable {
    let title: String?
    let description: String?
    let imageHref: String?
}

struct Country: Decodable {
    let title: String
    let rows: [RowDetail]
}

