//
//  Locale+Extensions.swift
//  StoreApp
//
//  Created by kirshi on 8/12/23.
//

import Foundation

extension Locale {
    static var currentCode: String {
        Locale.current.currency?.identifier ?? "USD"
    }
}
