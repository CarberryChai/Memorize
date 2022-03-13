//
//  memorizeGame.swift
//  Memorize
//
//  Created by 柴长林 on 2022/3/10.
//

import Foundation

struct MemorizeGame<CardContent: Equatable> {

  private(set) var cards: [Card]
  private var indexOfTheOneAndOnlyFaceUpCard: Int? {
    get { cards.indices.filter { cards[$0].isFaceUp }.oneAndOnly }
    set { cards.indices.forEach { cards[$0].isFaceUp = ($0 == newValue) } }
  }
  
  init(pairsOfCards: Int, getCardContent: (Int) -> CardContent) {
    cards = []
    for i in 0..<pairsOfCards {
      cards.append(Card(id: i * 2, content: getCardContent(i)))
      cards.append(Card(id: i * 2 + 1, content: getCardContent(i)))
    }
  }

  mutating func choose(_ card: Card) {
    guard let idx = cards.firstIndex(where: { $0.id == card.id }), !cards[idx].isFaceUp, !cards[idx].isMatched
      else { return }
    if let pontentialMatchIdx = indexOfTheOneAndOnlyFaceUpCard {
      if cards[idx].content == cards[pontentialMatchIdx].content {
        cards[idx].isMatched = true
        cards[pontentialMatchIdx].isMatched = true
      }
      cards[idx].isFaceUp = true
    } else {
      indexOfTheOneAndOnlyFaceUpCard = idx
    }
  }

  struct Card: Identifiable {
    let id: Int
    var isFaceUp = false
    var isMatched = false
    let content: CardContent
  }
}




extension Array {
  var oneAndOnly: Element? {
    return count == 1 ? first : nil
  }
}
