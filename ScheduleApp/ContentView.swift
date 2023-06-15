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
  @State private var arrayScheduleText2: [String:[String:[[String]]]] = [:]

  @State private var today = Date()

  @State private var lastDay: Int = 0
  @State private var dayOfWeek: [String] = []
  @State private var backColor: BackColor = BackColor(month: Calendar.current.component(.month, from: Date()))
  @State private var arrayScheduleTextOfYear: [String: [[String]]] = [:]
  @State private var arrayScheduleTextOfMonth: [[String]] = []
  @State private var arrayScheduleTextOfDay: [String] = []

  init() {
    _lastDay = State(initialValue: calculateLastDay(date: today))
    _dayOfWeek = State(initialValue: calculateDayOfWeek(date: today))
    _backColor = State(initialValue: BackColor(month: calendar.component(.month, from: today)))
  }

  private let calendar = Calendar(identifier: .gregorian)

  private func calculateMonth(n: Int) {
    let add = DateComponents(month: n)
    today = Calendar.current.date(byAdding: add, to: today)!
  }

  private func calculateLastDay(date: Date) -> Int {
    let comps = self.calendar.dateComponents([.year, .month], from: date)
    let firstDay = self.calendar.date(from: comps)!
    let add = DateComponents(month: 1, day: -1)
    let lastDay = self.calendar.date(byAdding: add, to: firstDay)!
    let lastDayComponents = calendar.dateComponents([.year, .month, .day], from: lastDay)
    return lastDayComponents.day!
  }

  private func calculateDayOfWeek(date: Date) -> [String] {
    var result: [String] = []
    let comps = calendar.dateComponents([.year, .month], from: date)
    let firstDay = calendar.date(from: comps)!
    for i in 0..<7 {
      let add = DateComponents(day: i)
      let targetDay = dateOfWeekFormatter.string(from: calendar.date(byAdding: add, to: firstDay)!)
      result.insert(targetDay, at: i)
    }
    return result
  }

  private func createArrayScheduleText1() {
    var array: [[String]] = Array(repeating:[], count: 31)
    for i in 0..<fetchedScheduleList.count {
      let startDay = Int(fetchedScheduleList[i].arrayStart[2])!
      array[startDay - 1].insert(fetchedScheduleList[i].title, at:array[startDay - 1].count)
    }
    arrayScheduleText = array
  }

  private func createArrayScheduleText2() -> [String:[String:[[String]]]] {
    var result: [String:[String:[[String]]]] = [:]
    for i in 0..<fetchedScheduleList.count {
      let schedule: Schedule = fetchedScheduleList[i]
      if !result.keys.contains(String(schedule.arrayStart[0])) {
        result[schedule.arrayStart[0]] = [:]
      }
      if !result[String(schedule.arrayStart[0])]!.keys.contains(String(schedule.arrayStart[1])) {
        result[schedule.arrayStart[0]]![schedule.arrayStart[1]] = Array(repeating:[], count: 31)
      }

      let startDay = Int(schedule.arrayStart[2])!
      result[schedule.arrayStart[0]]![schedule.arrayStart[1]]![startDay - 1].insert(schedule.title, at:result[schedule.arrayStart[0]]![schedule.arrayStart[1]]![startDay - 1].count)
    }
    print(result)
    return result
  }

  var body: some View {
    NavigationView {
      ZStack{
        backColor
        VStack(spacing: 0) {
          MonthIcon(month: calendar.component(.month, from: today))
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
                  NavigationLink(destination: CellView(day: day, schedules: arrayScheduleText[day - 1], backColor: backColor)) {
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
                              if Int(schedule.arrayStart[2])! == day {
                                ScheduleIcon(text: schedule.title)
                              }
                            }
                            //ForEach(arrayScheduleTextOfMonth[day - 1]) { title in
                              //ScheduleIcon(text: title)
                            //}
//                            for i in 0..<arrayScheduleTextOfMonth[day - 1].count {
                              // Text(String(arrayScheduleTextOfMonth[15][0]))
//                            }
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
          Spacer()
        }
        .padding(.horizontal)
        .navigationTitle("\(YMFormatter.string(from: today))")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
          ToolbarItem(placement: .navigationBarLeading) {
            Button(action: { calculateMonth(n: -1) }) {
              Image(systemName: "chevron.backward")
            }
          }
          ToolbarItem(placement: .navigationBarTrailing) {
            Button(action: { calculateMonth(n: 1) }) {
              Image(systemName: "chevron.forward")
            }
          }
        }
      }
      .onAppear {
        createArrayScheduleText1()
        arrayScheduleText2 = createArrayScheduleText2()
        arrayScheduleTextOfYear = arrayScheduleText2[String(calendar.component(.year, from: today))]!
        print(arrayScheduleTextOfYear)
        arrayScheduleTextOfMonth = arrayScheduleTextOfYear[String(calendar.component(.month, from: today))]!
        print(arrayScheduleTextOfMonth)
      }
      .onChange(of: Array(fetchedScheduleList)) { newFetchedScheduleList in
        for i in 0..<newFetchedScheduleList.count {
          let startDay = Int(newFetchedScheduleList[i].arrayStart[2])!
          arrayScheduleText[startDay - 1].insert(newFetchedScheduleList[i].title, at:arrayScheduleText[startDay - 1].count)
        }
      }
      .onChange(of: today) { newToday in
        lastDay = calculateLastDay(date: newToday)
        dayOfWeek = calculateDayOfWeek(date: newToday)
        backColor = BackColor(month: calendar.component(.month, from: today))
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
