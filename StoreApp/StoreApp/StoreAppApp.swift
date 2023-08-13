//
//  StoreAppApp.swift
//  StoreApp
//
//  Created by kirshi on 8/10/23.
//

import SwiftUI

@main
struct StoreAppApp: App {
    
    @StateObject private var storeModel = StoreController()
    
    var body: some Scene {
        WindowGroup {
            CategoryListScreen().environmentObject(storeModel)
        }
    }
}
