//
//  CoreDataHelper.swift
//  NoteApp
//
//  Created by Le Mai Viet Anh on 12/10/23.
//

import Foundation
import CoreData

public class CoreDataHelper: CoreDataHelperProtocol {
    
    // MARK: - Core Data stack

    lazy var persistentContainer: NSPersistentContainer = {
        /*
         The persistent container for the application. This implementation
         creates and returns a container, having loaded the store for the
         application to it. This property is optional since there are legitimate
         error conditions that could cause the creation of the store to fail.
        */
        let container = NSPersistentContainer(name: "NoteApp")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                 
                /*
                 Typical reasons for an error here include:
                 * The parent directory does not exist, cannot be created, or disallows writing.
                 * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                 * The device is out of space.
                 * The store could not be migrated to the current model version.
                 Check the error message to determine what the actual problem was.
                 */
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

    // MARK: - Core Data Saving support
    func saveChanges() throws {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            try context.save()
        }
    }
    
    public func getContext() -> NSManagedObjectContext {
        return persistentContainer.viewContext
    }
    
    public func getListData(entityName: String) throws -> [NSManagedObject] {
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: entityName)
        let entities = try persistentContainer.viewContext.fetch(fetchRequest)
        return entities
    }
    
    public func getListData(entityName: String, predicate: NSPredicate?, limit: Int?) throws -> [NSManagedObject] {
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: entityName)
        fetchRequest.predicate = predicate
        if let limit {
            fetchRequest.fetchLimit = limit
        }
        let entities = try persistentContainer.viewContext.fetch(fetchRequest)
        return entities
    }
    
    public func deleteData(entity: NSManagedObject) throws {
        persistentContainer.viewContext.delete(entity)
        try saveChanges()
    }
    
    public func saveContext(entity: NSManagedObject) throws {
        try saveChanges()
    }
    
    
}
