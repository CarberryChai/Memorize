//
//  ContentView.swift
//  Memorize
//
//  Created by 柴长林 on 2022/3/10.
//

import SwiftUI

struct Home: View {
  @ObservedObject var game = EmojiMemorizeGame()
  var body: some View {
    VStack {
      ScrollView {
        LazyVGrid(columns: Array(repeating: GridItem(.adaptive(minimum: 80)), count: 3)) {
          ForEach(game.cards) { card in
            Card(card: card).aspectRatio(2 / 3, contentMode: .fit)
              .onTapGesture {
              game.choose(card)
            }
          }
        }
      }
    }.padding()
  }
}


struct Card: View {
  let card: EmojiMemorizeGame.Card

  var body: some View {
    GeometryReader { proxy in
      let size = proxy.size
      ZStack {
        let shape = RoundedRectangle(cornerRadius: CardConstants.cornerRadius)
        if card.isFaceUp {
          shape.fill().foregroundColor(.white)
          shape.strokeBorder(lineWidth: CardConstants.lineWidth).foregroundColor(.red)
          Text(card.content).font(.system(size: min(size.width, size.height) * CardConstants.fontScale))
        } else if card.isMatched {
          shape.opacity(0)
        } else {
          shape.fill(.red)
        }
      }
    }
  }
  
  private struct CardConstants {
    static let cornerRadius: CGFloat = 20
    static let lineWidth: CGFloat = 3
    static let fontScale: CGFloat = 0.8
  }
}










struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    Home()
  }
}
