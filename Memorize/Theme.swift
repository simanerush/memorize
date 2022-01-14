//
//  Theme.swift
//  Memorize-CS193p
//
//  Created by Serafima Nerush on 12/23/21.
//

import Foundation

struct Theme: Identifiable, Codable, Hashable {
    var name: String
    var emojis: [String]
    var numberOfPairs: Int
    var color: RGBAColor
    var id: Int
    
    func asString() -> String {
        let stringArr =  emojis.map { String($0) }
        return stringArr.joined(separator: "")
    }
}

class ThemeStore: ObservableObject {
    let name: String
    
    @Published var themes = [Theme]() {
        didSet {
            storeInUserDefaults()
        }
    }
    
    private var userDefaultsKey: String {
        "ThemeStore:" + name
    }
    private func storeInUserDefaults() {
        UserDefaults.standard.set(try? JSONEncoder().encode(themes), forKey: userDefaultsKey)
    }
    
    private func restoreUserDefaults() {
        if let jsonData = UserDefaults.standard.data(forKey: userDefaultsKey),
           let decodedThemes = try? JSONDecoder().decode(Array<Theme>.self, from: jsonData) {
            themes = decodedThemes
        }
    }
    
    init(named name: String) {
        self.name = name
        restoreUserDefaults()
        if themes.isEmpty {
            insertTheme(named: "Vehicles", emojis: ["🏎", "🚃", "🛻", "✈️", "⛵️", "🚕", "🚢", "🚘", "🚖", "🛴", "🚜", "🚐", "🚚", "🚎", "🛺", "🚔", "🚠", "🚈", "🚁", "🛥", "🛵", "🚲", "🏍", "🚙"], pairs: 9, color: RGBAColor(red: 1.0, green: 0.0, blue: 0.0, alpha: 1.0))
            insertTheme(named: "City", emojis: ["🎆", "🌆", "🏙", "🌁", "🌉", "🏗", "💒", "🏠", "🏨"], pairs: 7, color: RGBAColor(red: 0.0, green: 1.0, blue: 0.0, alpha: 1.0))
            insertTheme(named: "Science", emojis: ["⌚️", "💽", "☎️", "⏰", "🔌", "🧯", "🔋", "📺", "📟", "🎛", "🖥", "📲"], pairs: 4, color: RGBAColor(red: 0.0, green: 0.0, blue: 1.0, alpha: 1.0))
        } else {
            print("successfully loaded themes from UserDefaults: \(themes)")
        }
    }
    
    // MARK: - Intent(s)
    
    func theme(at index: Int) -> Theme {
        let safeIndex = min(max(index, 0), themes.count - 1)
        return themes[safeIndex]
    }
    
    @discardableResult
    func removeTheme(at index: Int) -> Int {
        if themes.count > 1, themes.indices.contains(index) {
            themes.remove(at: index)
        }
        return index % themes.count
    }
    
    func insertTheme(named name: String, emojis: [String], pairs: Int, color: RGBAColor, at index: Int = 0) {
        let unique = (themes.max(by: {$0.id < $1.id })?.id ?? 0) + 1
        let theme = Theme(name: name, emojis: emojis, numberOfPairs: pairs, color: color, id: unique)
        let safeIndex = min(max(index, 0), themes.count)
        themes.insert(theme, at: safeIndex)
    }
}


