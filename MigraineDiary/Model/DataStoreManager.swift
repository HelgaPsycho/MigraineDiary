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

lazy var backgroundContext: NSManagedObjectContext = {
    return persistentContainer.newBackgroundContext()
    } ()
    
// MARK: - CRUD
    
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
    
    //UPDATE
    
    //DELETE
}
