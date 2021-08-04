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
  
  //1
  static let sharedManager = CoreDataManager()
  //2.
  private init() {} // Prevent clients from creating another instance.
  
  //3
  lazy var persistentContainer: NSPersistentContainer = {
    
    let container = NSPersistentContainer(name: "tawk")
    
    
    container.loadPersistentStores(completionHandler: { (storeDescription, error) in
      
      if let error = error as NSError? {
        fatalError("Unresolved error \(error), \(error.userInfo)")
      }
    })
    return container
  }()
  
  //4
  func saveContext () {
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
//    func executeRequest(request: NSFetchRequest<NSManagedObject>) -> Array<NSManagedObject> {
//        var result : [NSManagedObject] = []
//        do {
//            result = try CoreDataManager.sharedManager.persistentContainer.viewContext.fetch(request)
//            return request
//            } catch let error as NSError {
//              print("Could not fetch. \(error), \(error.userInfo)")
//            }
//    }
}

