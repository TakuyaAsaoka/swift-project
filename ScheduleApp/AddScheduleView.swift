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
  var body: some View {
    VStack {
      TextField("タイトル", text: $title)
        .font(.largeTitle)
        .foregroundColor(.black)
        .frame(maxWidth: .infinity, minHeight: 80, alignment: .leading)
        .padding(.leading, 30)
        .background(Color(red:0.8, green:1, blue:1, opacity: 0.6))
      DatePicker("開始日時を選択", selection: $selectionStartDate)
      DatePicker("終了日時を選択", selection: $selectionEndDate)
      Button(action: {addSchedule()}) {
        Text("保存")
      }
      Spacer()
    }
    .padding()
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
      AddScheduleView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
