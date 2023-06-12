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

    @NSManaged public var createdAt: Date?
    @NSManaged public var scheduledAt: Date?
    @NSManaged public var title: String?
    @NSManaged public var content: String?

}

extension Schedule : Identifiable {

}
