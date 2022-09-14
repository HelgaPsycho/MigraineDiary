//
//  MigraineEpisode+CoreDataProperties.swift
//  MigraineDiary
//
//  Created by Ольга Егорова on 14.09.2022.
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
    @NSManaged public var aura: Bool

}

extension MigraineEpisode : Identifiable {

}
