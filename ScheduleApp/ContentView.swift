//
//  ContentView.swift
//  ScheduleApp
//
//  Created by AsaokaTakuya on 2023/06/15.
//

import SwiftUI
import CoreData

struct ContentView: View {
  @Environment(\.managedObjectContext) private var viewContext

  @FetchRequest(
    entity: Schedule.entity(),
    sortDescriptors: [NSSortDescriptor(keyPath: \Schedule.start, ascending: true)],
    animation: .default)
  private var fetchedScheduleList: FetchedResults<Schedule>

  @State private var arrayScheduleText: [[String]] = Array(repeating:[], count: 31)

  private let today = Date()

  private let lastDay = {
    let calendar = Calendar(identifier: .gregorian)
    let comps = calendar.dateComponents([.year, .month], from: Date())
    let firstDay = calendar.date(from: comps)!
    let add = DateComponents(month: 1, day: -1)
    let lastDay = calendar.date(byAdding: add, to: firstDay)!
    let lastDayComponents = calendar.dateComponents([.year, .month, .day], from: lastDay)
    return lastDayComponents.day!
  }()

  private let firstDay: Date = {
    let calendar = Calendar(identifier: .gregorian)
    let comps = calendar.dateComponents([.year, .month], from: Date())
    return calendar.date(from: comps)!
  }()

  private let dayOfWeek: [String] = {
    var array: [String] = []
    let calendar = Calendar(identifier: .gregorian)
    let comps = calendar.dateComponents([.year, .month], from: Date())
    let firstDay = calendar.date(from: comps)!
    for i in 0..<7 {
      let add = DateComponents(day: i)
      let targetDay = dateOfWeekFormatter.string(from: calendar.date(byAdding: add, to: firstDay)!)
      array.insert(targetDay, at: i)
    }
    return array
  }()

  var body: some View {
    NavigationView {
      ZStack{
        Color(red: 0.2, green: 0.8, blue: 0.8, opacity: 0.3).ignoresSafeArea()
        VStack(spacing: 0) {
          Image("6月")
            .resizable()
            .frame(width: 300, height: 150)
          HStack(spacing: 0) {
            ForEach(dayOfWeek, id: \.self) { dayOfWeek in
              Rectangle()
                .stroke(Color(red: 0.3, green: 0.3, blue: 0.3, opacity: 1), lineWidth: 1)
                .frame(height: 30)
                .foregroundColor(.clear)
                .background(.white)
                .overlay(
                  Text(dayOfWeek)
                )
            }
          }
          ForEach(0..<(lastDay / 7 + 1), id: \.self) { num1 in
            HStack(spacing: 0) {
              ForEach(0..<7, id: \.self) { num2 in
                let day: Int = (7 * num1 + (num2 + 1))
                if day <= lastDay {
                  NavigationLink(destination: CellView(day:day, schedules: arrayScheduleText[day - 1])) {
                    Rectangle()
                      .stroke(Color(red: 0.3, green: 0.3, blue: 0.3, opacity: 1), lineWidth: 1)
                      .frame(height: 100)
                      .foregroundColor(.clear)
                      .background(.white)
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
                          // ここにスケジュールアイコンビューが入ってくる
                          VStack(spacing: 2) {
                            ForEach(fetchedScheduleList) { schedule in
                              if Int(schedule.stringStartDay)! == day {
                                ScheduleIcon(text: schedule.title)
                              }
                            }
                          }
                          Spacer()
                        }
                      )
                  }
                } else {
                  Rectangle()
                    .frame(height: 100)
                    .foregroundColor(.clear)
                }
              }
            }
          }
          Button("デバッグ", action: {
            //          for i in 0..<fetchedScheduleList.count {
            //            print(fetchedScheduleList[i])
            //          }
            //          createArrayScheduleText()
            print(dayOfWeek)
            print(firstDay)
            print(itemFormatter.dateStyle)
          })
          Spacer()
        }
        .padding(.top, -25)
        .padding(.horizontal)
        .navigationTitle("\(YMFormatter.string(from: today))")
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
      }.onChange(of: Array(fetchedScheduleList)) { newFetchedScheduleList in
        for i in 0..<newFetchedScheduleList.count {
          let startDay = Int(newFetchedScheduleList[i].stringStartDay)!
          arrayScheduleText[startDay - 1].insert(newFetchedScheduleList[i].title, at:arrayScheduleText[startDay - 1].count)
        }
      }
    }
  }
}


private let itemFormatter: DateFormatter = {
  let formatter = DateFormatter()
  formatter.dateStyle = .long
  formatter.timeStyle = .medium
  return formatter
}()

// めっちゃ便利！
private let YMFormatter: DateFormatter = {
  let formatter = DateFormatter()
  formatter.calendar = Calendar(identifier: .gregorian)
  formatter.locale = Locale(identifier: "ja_JP")
  formatter.timeZone = TimeZone(identifier:  "Asia/Tokyo")
  formatter.dateFormat = "yyyy年M月"
  return formatter
}()

private let dateOfWeekFormatter: DateFormatter = {
  let formatter = DateFormatter()
  formatter.calendar = Calendar(identifier: .gregorian)
  formatter.locale = Locale(identifier: "ja_JP")
  formatter.timeZone = TimeZone(identifier:  "Asia/Tokyo")
  formatter.dateFormat = "E"
  return formatter
}()

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
  }
}
