//
//  Country.swift
//  RestCountries
//
//  Created by erika.talberga on 15/11/2023.
//

import Foundation


struct Name: Codable {
    let common, official:String?
}

struct Country: Codable {
    let name: Name
}
