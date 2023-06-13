//
//  ContentView.swift
//  CalenderApp
//
//  Created by AsaokaTakuya on 2023/06/13.
//

import SwiftUI
import CoreData

struct ContentView: View {
  @Environment(\.managedObjectContext) private var viewContext

  @FetchRequest(
    sortDescriptors: [NSSortDescriptor(keyPath: \Schedule.start, ascending: true)],
    animation: .default)
  private var schedules: FetchedResults<Schedule>
  
  let dayOfWeek = ["日","月","火","水","木","金","土"]

  var body: some View {
    NavigationView {
      VStack(spacing: 0) {
        HStack(spacing: 0) {
          ForEach(dayOfWeek, id: \.self) { dayOfWeek in
            Rectangle()
              .stroke(Color(red: 0.3, green: 0.3, blue: 0.3, opacity: 1), lineWidth: 1)
              .frame(height: 30)
              .foregroundColor(.clear)
              .overlay(
                Text(dayOfWeek)
              )
          }
        }
        ForEach(1..<6, id: \.self) { num1 in
          HStack(spacing: 0) {
            ForEach(1..<8, id: \.self) { num2 in
              let day: Int = (7 * (num1 - 1) + num2)
              NavigationLink(destination: CellView(day:day)) {
                Rectangle()
                  .stroke(Color(red: 0.3, green: 0.3, blue: 0.3, opacity: 1), lineWidth: 1)
                  .frame(height: 100)
                  .foregroundColor(.clear)
                  .overlay(
                    VStack {
                      HStack {
                        Text("\(day)")
                          .font(.system(size:18).bold())
                          .foregroundColor(.black)
                          .padding(.top, 4)
                          .padding(.leading, 6)
                        Spacer()
                      }
                      // ここにコンテンツが入ってくる
                      Spacer()
                    }
                  )
              }
            }
          }
        }
        Spacer()
      }
      .padding(.top, 30)
      .padding(.horizontal)
      .navigationTitle("2023年6月")
      .navigationBarTitleDisplayMode(.inline)
      .toolbar {
        ToolbarItem(placement: .navigationBarLeading) {
          Button(action: {}) {
            Image(systemName: "chevron.backward")
          }
        }
        ToolbarItem(placement: .navigationBarTrailing) {
          Button(action: {}) {
            Image(systemName: "chevron.forward")
          }
        }
      }
    }
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
  }
}
