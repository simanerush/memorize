//
//  Memorize_CS193pApp.swift
//  Memorize-CS193p
//
//  Created by Serafima Nerush on 12/5/21.
//

import SwiftUI

@main
struct Memorize_CS193pApp: App {
    @StateObject var themeStore = ThemeStore(named: "Default")
    
    var body: some Scene {
        WindowGroup {
            ThemeChooser(store: themeStore)
            
        }
    }
}
