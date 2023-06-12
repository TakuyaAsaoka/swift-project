//
//  Schedule+CoreDataProperties.swift
//  scheduleApp
//
//  Created by TakuyaAsaoka on 2023/06/12.
//
//

import Foundation
import CoreData


extension Schedule {
    
    @nonobjc public class func fetchRequest() -> NSFetchRequest<Schedule> {
        return NSFetchRequest<Schedule>(entityName: "Schedule")
    }
    
    // 非null対策
    @NSManaged public var title: String { title ?? "" }
    @NSManaged public var createdAt: Date { createdAt ?? Date() }
    @NSManaged public var scheduledAt: Date { scheduledAt ?? Date() }

}

extension Schedule : Identifiable {
    public var stringCreatedAt: String { dateFormatter(date: createdAt) }
    public var stringScheduledAt: String { dateFormatter(date: scheduledAt) }
    
    func dateFormatter(date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy/MM/dd"
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.timeZone = TimeZone(identifier: "Asia/Tokyo")
        return dateFormatter.string(from: date)
    }
}
