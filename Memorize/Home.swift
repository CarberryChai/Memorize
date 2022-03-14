//
//  ContentView.swift
//  Memorize
//
//  Created by 柴长林 on 2022/3/10.
//

import SwiftUI

struct Home: View {
  @ObservedObject var game = EmojiMemorizeGame()
  @State var show = false
  var body: some View {
    VStack {
      gameCards
      HStack {
        Button("shuffle") {
          withAnimation(.spring()) {
            game.shuffle()
          }
        }
      }
    }.padding()
  }
  
  var gameCards: some View {
    AspectVGrid(items: game.cards, aspectRatio: 2 / 3) { card in
      if card.isMatched && !card.isFaceUp {
        Color.clear
      } else {
        Card(card: card).aspectRatio(2 / 3, contentMode: .fit)
          .padding(4)
          .onTapGesture {
            game.choose(card)
          }
      }
    }.foregroundColor(.red)
  }
}


struct Card: View {
  let card: EmojiMemorizeGame.Card

  var body: some View {
    GeometryReader { proxy in
      let size = proxy.size
      ZStack {
        Pie(startAngle: Angle(degrees: -90), endAngle: Angle(degrees: 30))
          .padding(5).opacity(0.5)
        Text(card.content).font(.system(size: min(size.width, size.height) * CardConstants.fontScale))
          .rotationEffect(Angle.degrees(card.isMatched ? 360 : 0))
          .animation(.linear(duration: 1).repeatForever(autoreverses: false), value: card.isMatched)
      }.cardify(isFaceUp: card.isFaceUp)
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
    Group {
      Home().preferredColorScheme(.light)
    }
  }
}
