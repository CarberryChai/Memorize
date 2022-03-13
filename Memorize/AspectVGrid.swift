//
//  AspectVGrid.swift
//  Memorize
//
//  Created by 柴长林 on 2022/3/13.
//

import SwiftUI

struct AspectVGrid<Item: Identifiable, Content: View>: View {
  var items: [Item]
  var aspectRatio: CGFloat
  var content: (Item) -> Content
  
  init(items: [Item], aspectRatio: CGFloat, @ViewBuilder content: @escaping (Item) -> Content) {
    self.items = items
    self.aspectRatio = aspectRatio
    self.content = content
  }
  
  var body: some View {
    GeometryReader { proxy in
      VStack { // vstack is a flexible container
        let width: CGFloat = withThatFits(itemCount: items.count, in: proxy.size, itemAspectRatio: aspectRatio)
        LazyVGrid(columns: [adaptiveGridItem(width: width)], spacing: 0) {
          ForEach(items) { item in
            content(item).aspectRatio(aspectRatio, contentMode: .fit)
              .onTapGesture {
                print(width)
              }
          }
        }
        Spacer(minLength: 0)
      }
    }
  }
  
  private func adaptiveGridItem(width: CGFloat) -> GridItem {
    var gridItem = GridItem(.adaptive(minimum: width))
    gridItem.spacing = 0
    return gridItem
  }
  
  private func withThatFits(itemCount: Int, in size: CGSize, itemAspectRatio: CGFloat) -> CGFloat {
    var columnCount = 1
    var rowCount = itemCount
    repeat {
      let itemWidth = size.width / CGFloat(columnCount)
      let itemHeight = itemWidth / itemAspectRatio
      if CGFloat(rowCount) * itemHeight < size.height {
        break
      }
      columnCount += 1
      rowCount = (itemCount + (columnCount - 1)) / columnCount
    } while columnCount < itemCount
    if columnCount > itemCount {
      columnCount = itemCount
    }
    return floor(size.width / CGFloat(columnCount))
  }
}
