//
//  AddScheduleView.swift
//  scheduleApp
//
//  Created by TakuyaAsaoka on 2023/06/12.
//

import SwiftUI

struct AddScheduleView: View {
  @Environment(\.managedObjectContext) private var viewContext
  @Environment(\.presentationMode) private var presentation
  // Reactのstateみたいに使える
  @State private var title: String = ""
  @State private var content: String = ""
  
  var body: some View {
    NavigationView {
      VStack {
        TextField("タイトル", text: $title)
          .font(.title2)
        TextField("内容", text: $content)
          .font(.body)
        // stateの挙動がわかりやすいように同じものを配置する。入力してみると何が起きているかわかる。
        TextField("タイトル", text: $title)
          .font(.title2)
        // バネみたいな役割で要素を配置できる
        Spacer()
      }
      .navigationTitle("新しいスケジュール")
      .navigationBarTitleDisplayMode(.inline)
      .toolbar {
        ToolbarItem(placement: .navigationBarTrailing) {
          Button(action: {addSchedule()}) {
            Text("保存")
          }
        }
      }
    }
  }
  
  private func addSchedule() {
    // 以下のイニシャライザの引数の意味がわからない…
    let schedule = Schedule(context: viewContext)
    schedule.title = title
    schedule.createdAt = Date()
    schedule.scheduledAt = Date()
    // 生成したインスタンスをCoreDataに保存
    try? viewContext.save()

    // 現在のViewを閉じる
    presentation.wrappedValue.dismiss()
  }
}

struct AddScheduleView_Previews: PreviewProvider {
  static var previews: some View {
    AddScheduleView()
  }
}
