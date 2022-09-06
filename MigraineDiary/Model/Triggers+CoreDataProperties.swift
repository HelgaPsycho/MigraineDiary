//
//  Triggers+CoreDataProperties.swift
//  MigraineDiary
//
//  Created by Ольга Егорова on 06.09.2022.
//
//

import Foundation
import CoreData


extension Triggers {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Triggers> {
        return NSFetchRequest<Triggers>(entityName: "Triggers")
    }

    @NSManaged public var trigger: String?
    @NSManaged public var migrainEpisode: NSSet?

}

// MARK: Generated accessors for migrainEpisode
extension Triggers {

    @objc(addMigrainEpisodeObject:)
    @NSManaged public func addToMigrainEpisode(_ value: MigraineEpisode)

    @objc(removeMigrainEpisodeObject:)
    @NSManaged public func removeFromMigrainEpisode(_ value: MigraineEpisode)

    @objc(addMigrainEpisode:)
    @NSManaged public func addToMigrainEpisode(_ values: NSSet)

    @objc(removeMigrainEpisode:)
    @NSManaged public func removeFromMigrainEpisode(_ values: NSSet)

}

extension Triggers : Identifiable {

}
