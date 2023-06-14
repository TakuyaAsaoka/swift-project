//
//  CellView.swift
//  CalenderApp
//
//  Created by AsaokaTakuya on 2023/06/13.
//

import SwiftUI

struct CellView: View {
  var day: Int
  var schedules: [String]
  var body: some View {
    VStack(spacing: 10) {
      ForEach(schedules, id: \.self) { schedule in
        NavigationLink(destination: EditScheduleView()) {
          Text("\(schedule)")
            .font(.largeTitle)
            .foregroundColor(.black)
            .frame(maxWidth: .infinity, minHeight: 80, alignment: .leading)
            .padding(.leading, 30)
            .background(Color(red:0.8, green:1, blue:1, opacity: 0.6))
        }
        .navigationTitle("\(day)日の予定")
        .navigationBarTitleDisplayMode(.inline)
      }
      NavigationLink(destination: AddScheduleView()) {
        Text("追加する")
          .font(.largeTitle)
          .foregroundColor(.black)
          .frame(maxWidth: .infinity, minHeight: 80, alignment: .leading)
          .padding(.leading, 30)
          .background(Color(red:0.8, green:1, blue:1, opacity: 0.6))
      }
      Spacer()
    }
    .padding()
  }
}

struct Cell_Previews: PreviewProvider {
    static var previews: some View {
      CellView(day: 12, schedules: ["用事1", "用事2"]).environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
