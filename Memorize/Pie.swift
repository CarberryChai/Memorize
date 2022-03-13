//
//  Pie.swift
//  Memorize
//
//  Created by 柴长林 on 2022/3/13.
//

import SwiftUI

struct Pie: Shape {
  var startAngle: Angle
  var endAngle: Angle
  let clockwise = false
  
  func path(in rect: CGRect) -> Path {
    var p = Path()
    let center = CGPoint(x: rect.midX, y: rect.midY)
    let radius = min(rect.width, rect.height) / 2
    let startPoint = CGPoint(x: center.x + radius * CGFloat(cos(startAngle.radians)), y: center.y + radius * CGFloat(sin(endAngle.radians)))

    p.move(to: center)
    p.addLine(to: startPoint)
    p.addArc(center: center, radius: radius, startAngle: startAngle, endAngle: endAngle, clockwise: !clockwise)
    p.addLine(to: center)
    
    return p
  }
}

