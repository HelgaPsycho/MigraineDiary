//
//  MigraineEpisode+CoreDataProperties.swift
//  MigraineDiary
//
//  Created by Ольга Егорова on 06.09.2022.
//
//

import Foundation
import CoreData


extension MigraineEpisode {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<MigraineEpisode> {
        return NSFetchRequest<MigraineEpisode>(entityName: "MigraineEpisode")
    }

    @NSManaged public var date: Date?
    @NSManaged public var dutation: String?
    @NSManaged public var intensity: Int16
    @NSManaged public var intensityAfterMadication: Int16
    @NSManaged public var medication: String?
    @NSManaged public var triggers: String?
    @NSManaged public var drug: NSSet?
    @NSManaged public var trigger: NSSet?

}

// MARK: Generated accessors for drug
extension MigraineEpisode {

    @objc(addDrugObject:)
    @NSManaged public func addToDrug(_ value: Medication)

    @objc(removeDrugObject:)
    @NSManaged public func removeFromDrug(_ value: Medication)

    @objc(addDrug:)
    @NSManaged public func addToDrug(_ values: NSSet)

    @objc(removeDrug:)
    @NSManaged public func removeFromDrug(_ values: NSSet)

}

// MARK: Generated accessors for trigger
extension MigraineEpisode {

    @objc(addTriggerObject:)
    @NSManaged public func addToTrigger(_ value: Triggers)

    @objc(removeTriggerObject:)
    @NSManaged public func removeFromTrigger(_ value: Triggers)

    @objc(addTrigger:)
    @NSManaged public func addToTrigger(_ values: NSSet)

    @objc(removeTrigger:)
    @NSManaged public func removeFromTrigger(_ values: NSSet)

}

extension MigraineEpisode : Identifiable {

}
