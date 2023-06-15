//
//  MonthIcon.swift
//  ScheduleApp
//
//  Created by AsaokaTakuya on 2023/06/15.
//

import SwiftUI

struct MonthIcon: View {
  let month: Int
  var body: some View {
    Image("\(month)月")
      .resizable()
      .frame(width: 300, height: 150)
      .padding(.top, -20)
      .padding(.bottom, 10)
  }
}

struct MonthIcon_Previews: PreviewProvider {
  static var previews: some View {
    MonthIcon(month: 12)
  }
}
