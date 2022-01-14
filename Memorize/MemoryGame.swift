//
//  MemoryGame.swift
//  Memorize-CS193p
//
//  Created by Serafima Nerush on 12/8/21.
//

import Foundation

// CardContent can be any type that user wants it to be when initializing MemoryGame
// where statements makes CardContent conform to Equatable Protocol, which allows us to use comparison operator on this type
struct MemoryGame<CardContent> where CardContent: Equatable {
    private(set) var cards: Array<Card>
    
    private var indexOfOneAndOnlyFaceUpCard: Int?
    
    private var score = 0
    
    mutating func choose(_ card: Card) {
        if let index = indexOfOneAndOnlyFaceUpCard {
            cards[index].alreadySeen = true
        }
        // If such card exists
        if let chosenIndex = cards.firstIndex(where: { $0.id == card.id }), !cards[chosenIndex].isFaceUp,
            !cards[chosenIndex].isMatched {
            // If thre is only one face up card
            if let potentialMatchIndex = indexOfOneAndOnlyFaceUpCard {
                if cards[chosenIndex].content == cards[potentialMatchIndex].content {
                    cards[chosenIndex].isMatched = true
                    cards[potentialMatchIndex].isMatched = true
                    score += 2
                }
                indexOfOneAndOnlyFaceUpCard = nil
            } else {
                for index in cards.indices {
                    cards[index].isFaceUp = false
                }
                indexOfOneAndOnlyFaceUpCard = chosenIndex
            }
            if cards[chosenIndex].alreadySeen && !cards[chosenIndex].isMatched {
                score -= 1
            }
            cards[chosenIndex].isFaceUp.toggle()
        }
        
        print("chosenCard = \(cards)")
    }
    
    func getScore() -> Int {
        return self.score
    }

    init(numberOfPairsOfCards: Int, createCardContent: (Int) -> CardContent) {
        cards = Array<Card>()
        // add numberOfPairsOfCards times 2 cards to cards array
        for pairIndex in 0..<numberOfPairsOfCards {
            let content = createCardContent(pairIndex)
            cards.append(Card(content: content, id: pairIndex*2))
            cards.append(Card(content: content, id: pairIndex*2+1))
        }
        cards.shuffle()
    }
    
    struct Card: Identifiable {
        var isFaceUp: Bool = false
        var isMatched: Bool = false
        var content: CardContent
        var alreadySeen: Bool = false
        var id: Int
    }
}
