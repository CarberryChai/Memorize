//
//  EmojiMemorizeGame.swift
//  Memorize
//
//  Created by 柴长林 on 2022/3/10.
//

import Foundation
import Combine

final class EmojiMemorizeGame: ObservableObject {
  typealias Card = MemorizeGame<String>.Card
  
  private static let emojis = ["🍏", "🍎", "🍐", "🍊", "🍋", "🍌", "🍉", "🍇", "🍓", "🫐", "🍒", "🍑", "🥭", "🍍", "🥝", "🍅", "🍆", "🥑", "🥦", "🥬", "🌶", "🌽", "🥕", "🍠"]

  @Published private var model: MemorizeGame<String> = MemorizeGame(pairsOfCards: 4) { idx in
    EmojiMemorizeGame.emojis[idx]
  }

  var cards: [Card] {
    return model.cards
  }

  func choose(_ card: Card) {
    model.choose(card)
  }
}
