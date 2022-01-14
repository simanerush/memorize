//
//  ThemeEditor.swift
//  Memorize-CS193p
//
//  Created by Serafima Nerush on 1/13/22.
//

import SwiftUI

struct ThemeEditor: View {
    
    @Binding var theme: Theme
    
    @Environment(\.presentationMode) var presentation
    
    var body: some View {
        Form {
            nameSection
            emojisSection
            pairsSection
            colorSection
        }
    }
    
    var nameSection: some View {
        Section(header: Text("Name")) {
            TextField("Name", text: $theme.name)
        }
    }
    
    @State private var emojisToAdd = ""
    
    var emojisSection: some View {
        Section(header: Text(" Add Emojis")) {
            TextField("", text: $emojisToAdd)
                .onChange(of: emojisToAdd) { emojis in
                    addEmojis(emojis)
                }
        }
    }
    
    @State private var numberOFPairsToAdd = ""
    var pairsSection: some View {
        Section(header: Text("Number of pairs")) {
            TextField("", text: $numberOFPairsToAdd)
                .onChange(of: numberOFPairsToAdd) { newValue in
                    if Int(newValue) != nil {
                        if Int(newValue)! <= theme.emojis.count {
                            theme.numberOfPairs = Int(newValue)!
                        }
                    }
                }
        }
    }
    
    @State private var colorToBeSet = Color(rgbaColor: RGBAColor(red: 1.0, green: 0.0, blue: 0.0, alpha: 1.0))
    var colorSection: some View {
        Section(header: Text("Theme color")) {
            ColorPicker("Theme Color", selection: $colorToBeSet)
                .onChange(of: colorToBeSet) { color in
                    theme.color = RGBAColor(red: colorToBeSet.components.red, green: colorToBeSet.components.green, blue: colorToBeSet.components.blue, alpha: colorToBeSet.components.opacity)
                }
        }
    }
    
     func addEmojis(_ emojis: String) {
        let noDuplicatesEmojis = emojis.removingDuplicateCharacters
        for emoji in noDuplicatesEmojis {
            if emoji.isEmoji {
                theme.emojis.append(String(emoji))
            }
        }
    }
}
