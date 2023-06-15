//
//  AddScheduleView.swift
//  ScheduleApp
//
//  Created by AsaokaTakuya on 2023/06/15.
//

import SwiftUI

struct AddScheduleView: View {
  @Environment(\.managedObjectContext) private var viewContext

  @State private var title: String = ""
  @State private var selectionStartDate: Date = Date()
  @State private var selectionEndDate: Date = Date()

  var backColor: BackColor
  var body: some View {
    ZStack {
      backColor
      Color(.white)
        .overlay(
          RoundedRectangle(cornerRadius: 8)
            .stroke(Color(red: 0.4, green: 0.4, blue: 0.4), lineWidth: 4)
        )
        .padding()
      VStack {
        TextField("タイトル", text: $title)
          .font(.largeTitle)
          .foregroundColor(.black)
          .frame(maxWidth: .infinity, minHeight: 80, alignment: .leading)
          .padding(.leading, 30)
          .background(.white)
          .cornerRadius(8)
          .padding()
        DatePicker("開始日時を選択", selection: $selectionStartDate)
          .padding()
          .environment(\.locale, Locale(identifier: "ja_JP"))
        DatePicker("終了日時を選択", selection: $selectionEndDate)
          .padding()
          .environment(\.locale, Locale(identifier: "ja_JP"))
        Button(action: {addSchedule()}) {
          Text("保存")
        }
        Spacer()
      }
      .padding()
    }
  }

  private func addSchedule() {
    let schedule = Schedule(context: viewContext)
    schedule.title = title
    schedule.start = selectionStartDate
    schedule.end = selectionEndDate

    try? viewContext.save()
  }
}

struct AddScheduleView_Previews: PreviewProvider {
    static var previews: some View {
      AddScheduleView(backColor: BackColor(month: Calendar.current.component(.month, from: Date()))).environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
