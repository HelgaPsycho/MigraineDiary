//
//  Medication+CoreDataProperties.swift
//  MigraineDiary
//
//  Created by Ольга Егорова on 06.09.2022.
//
//

import Foundation
import CoreData


extension Medication {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Medication> {
        return NSFetchRequest<Medication>(entityName: "Medication")
    }

    @NSManaged public var drugAndDose: String?
    @NSManaged public var migraineEpisode: NSSet?

}

// MARK: Generated accessors for migraineEpisode
extension Medication {

    @objc(addMigraineEpisodeObject:)
    @NSManaged public func addToMigraineEpisode(_ value: MigraineEpisode)

    @objc(removeMigraineEpisodeObject:)
    @NSManaged public func removeFromMigraineEpisode(_ value: MigraineEpisode)

    @objc(addMigraineEpisode:)
    @NSManaged public func addToMigraineEpisode(_ values: NSSet)

    @objc(removeMigraineEpisode:)
    @NSManaged public func removeFromMigraineEpisode(_ values: NSSet)

}

extension Medication : Identifiable {

}
