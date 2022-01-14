//
//  EmojiMemoryGameView.swift
//  Memorize-CS193p
//
//  Created by Serafima Nerush on 12/5/21.
//

import SwiftUI

struct EmojiMemoryGameView: View {
    
    // Listen for changes
    @ObservedObject var viewModel: EmojiMemoryGame
    
    var body: some View {
        VStack {
            HStack {
                Text("\(viewModel.theme.name)")
                Spacer()
                Text("Score: \(viewModel.score)")
            }
            .font(.system(size: 15, weight: .semibold, design: .monospaced))
            .padding()
            ScrollView {
                LazyVGrid(columns: [GridItem(.adaptive(minimum: 65))]) {
                    ForEach(viewModel.cards) { card in
                        CardView(card: card)
                            .aspectRatio(2/3, contentMode: .fit)
                            .onTapGesture {
                                viewModel.choose(card)
                            }
                    }
                }
            }
            .foregroundColor(Color(rgbaColor: viewModel.theme.color))
            .padding(.horizontal)
            
            HStack {
                Image(systemName: "sparkles")
                Button("New Game", action: {
                    viewModel.startNewGame()
                })
            }
            .font(.system(size: 20, weight: .semibold, design: .monospaced))
            .foregroundColor(.red)
        }
        .navigationBarTitleDisplayMode(.inline)
    }
}


struct CardView: View {
    let card: MemoryGame<String>.Card
    
    var body: some View {
        ZStack {
            let shape = RoundedRectangle(cornerRadius: 20)
            if card.isFaceUp {
                shape.fill().foregroundColor(.white)
                shape.strokeBorder(lineWidth: 3)
                Text(card.content).font(.largeTitle)
            } else if card.isMatched {
                shape.opacity(0)
            } else {
                shape.fill()
            }
        }
    }
}

























//struct EmojiMemoryGameView_Previews: PreviewProvider {
//    static var previews: some View {
//        let game = EmojiMemoryGame()
//        EmojiMemoryGameView(viewModel: game, theme: .constant(ThemeStore(named: "Preview").theme(at: 0)))
//            .preferredColorScheme(.light)
//            .previewInterfaceOrientation(.portrait)
//        
//    }
//}
