//
//  CoreDataManager.swift
//  tawk
//
//  Created by Adnan Munir on 31/07/2021.
//

import Foundation
import CoreData
import UIKit

class CoreDataManager {
  
  static let sharedManager = CoreDataManager()
    lazy var backgroundContext : NSManagedObjectContext = {
        return persistentContainer.newBackgroundContext()
    }()
    
  private init() {} // Prevent clients from creating another instance.
  
  lazy var persistentContainer: NSPersistentContainer = {
    
    let container = NSPersistentContainer(name: "tawk")
    
    container.viewContext.automaticallyMergesChangesFromParent = true
    container.loadPersistentStores(completionHandler: { (storeDescription, error) in
      
      if let error = error as NSError? {
        fatalError("Unresolved error \(error), \(error.userInfo)")
      }
    })
    return container
  }()
  
  //4
  func saveContext () {
//
    let context = CoreDataManager.sharedManager.persistentContainer.viewContext
    if context.hasChanges {
      do {
        try context.save()
      } catch {
        // Replace this implementation with code to handle the error appropriately.
        // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
        let nserror = error as NSError
        fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
      }
    }
  }
    
    func saveBackgroundContext() {
        do {
           try backgroundContext.save()
        } catch {
            let nserror = error as NSError
            fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
        }
    }
}

