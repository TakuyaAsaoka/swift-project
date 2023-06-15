//
//  BackColor.swift
//  ScheduleApp
//
//  Created by AsaokaTakuya on 2023/06/15.
//

import SwiftUI

struct BackColor: View {
  let month: Int

  private func createColor(r: Int, g: Int, b: Int, o: Double) -> some View {
    return Color(red: Double(r) / 255, green: Double(g)/255, blue: Double(b)/255, opacity: o).ignoresSafeArea()
  }

  var body: some View {
    switch month {
    case 1:
      return createColor(r: 255, g: 187, b: 187, o: 0.3)
    case 2:
      return createColor(r: 238, g: 221, b: 238, o: 0.5)
    case 3:
      return createColor(r: 221, g: 238, b: 221, o: 0.6)
    case 4:
      return createColor(r: 0, g: 170, b: 238, o: 0.2)
    case 5:
      return createColor(r: 255, g: 187, b: 221, o: 0.3)
    case 6:
      return createColor(r: 51, g: 204, b: 204, o: 0.3)
    case 7:
      return createColor(r: 255, g: 255, b: 187, o: 0.4)
    case 8:
      return createColor(r: 0, g: 153, b: 153, o: 0.2)
    case 9:
      return createColor(r: 255, g: 153, b: 0, o: 0.2)
    case 10:
      return createColor(r: 119, g: 0, b: 0, o: 0.3)
    case 11:
      return createColor(r: 221, g: 238, b: 221, o: 0.7)
    case 12:
      return createColor(r: 221, g: 238, b: 255, o: 0.9)
    default:
      return createColor(r: 255, g: 255, b: 255, o: 1)
    }
  }
}

struct BackColor_Previews: PreviewProvider {
  static var previews: some View {
    BackColor(month: 11)
  }
}
