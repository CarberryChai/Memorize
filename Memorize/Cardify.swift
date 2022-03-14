//
//  Cardify.swift
//  Memorize
//
//  Created by 柴长林 on 2022/3/14.
//

import SwiftUI

struct Cardify: ViewModifier {
  var isFaceUp: Bool

  func body(content: Content) -> some View {
    let shape = RoundedRectangle(cornerRadius: CardConstants.cornerRadius)
    ZStack {
      if isFaceUp {
        shape.fill().foregroundColor(.white)
        shape.strokeBorder(lineWidth: CardConstants.lineWidth)
      } else {
        shape.fill()
      }
      content.opacity(isFaceUp ? 1 : 0)
    }
  }

  private struct CardConstants {
    static let cornerRadius: CGFloat = 15
    static let lineWidth: CGFloat = 3
  }
}


extension View {
  func cardify(isFaceUp: Bool) -> some View {
    self.modifier(Cardify(isFaceUp: isFaceUp))
  }
}
