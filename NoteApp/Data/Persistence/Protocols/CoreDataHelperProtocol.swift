//
//  CoreDataHelperProtocol.swift
//  NoteApp
//
//  Created by Le Mai Viet Anh on 12/10/23.
//

import Foundation
import CoreData

public protocol CoreDataHelperProtocol {
    func getContext() -> NSManagedObjectContext
    func getListData(entityName: String) throws -> [NSManagedObject]
    func getListData(entityName: String, predicate: NSPredicate?, limit: Int?, sort: NSSortDescriptor?) throws -> [NSManagedObject]
    func deleteData(entity: NSManagedObject) throws
    func saveContext(entity: NSManagedObject) throws
    
}
