//
//  DataStoreManager.swift
//  MigraineDiary
//
//  Created by Ольга Егорова on 09.09.2022.
//

import Foundation
import CoreData

class DataStoreManager {
    // MARK: - Core Data stack
    
    
    
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "MigraineDiary")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

 
lazy var blankViewContext: NSManagedObjectContext = {
print ("======================= blankViewContext func===========================")
    return persistentContainer.viewContext
        
    }()
    
    lazy var  tableViewContext: NSManagedObjectContext = {
        print  ("======================= tableViewContext func===========================")
        return persistentContainer.viewContext
    }()

lazy var backgroundContext: NSManagedObjectContext = {
    return persistentContainer.newBackgroundContext()
    } ()
    
// MARK: - CRUD -
    
    //  CREATE AND SAVE
    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
                print(" ================== saveContext func ===================")
            } catch {
                context.rollback()
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
    // READ
    
    func obtainMigraineEpisode () throws -> [MigraineEpisode] {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName : "MigraineEpisode")

        if let migraineEpisodes = try tableViewContext.fetch(fetchRequest) as? [MigraineEpisode],
           !migraineEpisodes.isEmpty {
            return migraineEpisodes
        } else {
            print ("DataStroreManager.obtainMigraineEpisode ERROR")
            throw DataStoreManagerErrors.emptyDataBase
        }
    }
    
   

    //UPDATE
    
    //DELETE
    
    func obtainAndRemoveOneMigraineEpisode (date: Date) throws {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "MigraineEpisode")
        fetchRequest.predicate = NSPredicate(format: "date = %@", date as CVarArg)
        
        if let migraineEpisodes = try tableViewContext.fetch(fetchRequest) as? [MigraineEpisode]
            {
            guard let migraineEpisode = migraineEpisodes.first else {return}
            tableViewContext.delete(migraineEpisode)
            
            try tableViewContext.save()
       
            
            
            
        }
    }
}

// MARK: - DataStoreManagerErrors -
enum DataStoreManagerErrors: Error {
    case emptyDataBase
    case cantSaveDelete
}