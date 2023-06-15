//
//  CellView.swift
//  ScheduleApp
//
//  Created by AsaokaTakuya on 2023/06/15.
//

import SwiftUI

struct CellView: View {
  var day: Int
  var schedules: [String]
  var backColor: BackColor
  var body: some View {
    ZStack {
      backColor
      VStack(spacing: 10) {
        ForEach(schedules, id: \.self) { schedule in
          NavigationLink(destination: EditScheduleView()) {
            Text("\(schedule)")
              .font(.largeTitle)
              .foregroundColor(.black)
              .frame(maxWidth: .infinity, minHeight: 80, alignment: .leading)
              .padding(.leading, 30)
              .background(.white)
              .cornerRadius(8)
              .overlay(
                RoundedRectangle(cornerRadius: 8)
                  .stroke(Color(red: 0.4, green: 0.4, blue: 0.4), lineWidth: 4)
              )
          }
        }
        NavigationLink(destination: AddScheduleView(backColor: backColor)) {
          Text("追加する")
            .font(.largeTitle)
            .foregroundColor(.black)
            .frame(maxWidth: .infinity, minHeight: 80, alignment: .leading)
            .padding(.leading, 30)
            .background(.white)
            .cornerRadius(8)
            .overlay(
              RoundedRectangle(cornerRadius: 8)
                .stroke(Color(red: 0.4, green: 0.4, blue: 0.4), lineWidth: 4)
            )
            .navigationTitle("\(day)日の予定")
            .navigationBarTitleDisplayMode(.inline)
        }
        Spacer()
      }
      .padding()
    }
  }
}

struct CellView_Previews: PreviewProvider {
  static var previews: some View {
    CellView(day: 12, schedules: ["用事1", "用事2"], backColor: BackColor(month: Calendar.current.component(.month, from: Date()))).environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
  }
}
