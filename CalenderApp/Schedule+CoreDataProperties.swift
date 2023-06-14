//
//  Schedule+CoreDataProperties.swift
//  CalenderApp
//
//  Created by AsaokaTakuya on 2023/06/13.
//
//

import Foundation
import CoreData


extension Schedule {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Schedule> {
        return NSFetchRequest<Schedule>(entityName: "Schedule")
    }

    @NSManaged public var title: String
    @NSManaged public var start: Date
    @NSManaged public var end: Date

}

extension Schedule : Identifiable {
  public var stringStart: String { dateFormatter(date: start) }
  public var stringEnd: String { dateFormatter(date: end) }
  public var stringStartDay: String { String(stringStart.split(separator: "/")[2]) }
  
  func dateFormatter(date: Date) -> String {
      let dateFormatter = DateFormatter()
      dateFormatter.dateFormat = "yyyy/MM/dd"
      dateFormatter.locale = Locale(identifier: "en_US_POSIX")
      dateFormatter.timeZone = TimeZone(identifier: "Asia/Tokyo")
      return dateFormatter.string(from: date)
  }
}
