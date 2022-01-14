//
//  EmojiMemoryGame.swift
//  Memorize-CS193p
//
//  Created by Serafima Nerush on 12/9/21.
//

// A ViewModel file, so we import SwiftUI
import SwiftUI

// Observable object publishes changes and announces it to the world
class EmojiMemoryGame: ObservableObject {
    
    // like global, but local to this namespace
    static func createMemoryGame(with theme: Theme) -> MemoryGame<String> {
        MemoryGame<String>(numberOfPairsOfCards: theme.numberOfPairs)  { pairIndex in
            theme.emojis[pairIndex] }
    }
    
    // private: only the ViewModel can access model
    // set: can look but can't change
    
    // Any time model changes, viewmodel will let the view know
    @Published private(set) var model: MemoryGame<String>
    
    public var theme: Theme
    
    init(with theme: Theme) {
        self.theme = theme
        self.model = EmojiMemoryGame.createMemoryGame(with: theme)
    }
    
    var cards: Array<MemoryGame<String>.Card> {
        return model.cards
    }
    
    var score: Int {
        return model.getScore()
    }
    
    // MARK: - Intent(s)
    
    func choose(_ card: MemoryGame<String>.Card) {
//        // Something changed
//        objectWillChange.send()
        model.choose(card)
    }
    
    func startNewGame() {
        model = EmojiMemoryGame.createMemoryGame(with: self.theme)
    }
}
