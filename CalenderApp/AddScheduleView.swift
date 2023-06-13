//
//  AddScheduleView.swift
//  CalenderApp
//
//  Created by AsaokaTakuya on 2023/06/14.
//

import SwiftUI
import CoreData

struct AddScheduleView: View {
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
      Spacer()
    }
    .padding()
  }
}

struct AddScheduleView_Previews: PreviewProvider {
    static var previews: some View {
      AddScheduleView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
