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
    AspectVGrid(items: game.cards, aspectRatio: 2/3) { card in
      Card(card: card).aspectRatio(2 / 3, contentMode: .fit)
        .padding(4)
        .onTapGesture {
          game.choose(card)
        }
    }.padding(.horizontal)
      .foregroundColor(.red)
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
          shape.strokeBorder(lineWidth: CardConstants.lineWidth)
          Pie(startAngle: Angle(degrees: -90), endAngle: Angle(degrees: 30))
            .padding(5).opacity(0.5)
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
    static let cornerRadius: CGFloat = 15
    static let lineWidth: CGFloat = 3
    static let fontScale: CGFloat = 0.7
  }
}










struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    Home()
  }
}
