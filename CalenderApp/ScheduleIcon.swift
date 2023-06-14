//
//  ScheduleIcon.swift
//  CalenderApp
//
//  Created by AsaokaTakuya on 2023/06/14.
//


import SwiftUI

struct ScheduleIcon: View {
  let text: String
  var body: some View {
    HStack {
      Text(text)
        .padding(.horizontal, 4)
        .frame(maxWidth: .infinity, alignment: .leading)
        .lineLimit(1)
        .font(.system(size: 8).bold())
        .foregroundColor(.white)
        .background(Color(.blue))
    }
    .padding(.horizontal, 4)
  }
}

struct ScheduleIcon_Previews: PreviewProvider {
  static var previews: some View {
    ScheduleIcon(text: "健康診断")
  }
}
