//
//  OfflineStorage.swift
//  Random
//
//  Created by Shayan Ali on 02.02.23.
//

import CoreData
import Foundation

/// A Core Data helper that hides away the details and just provides direct access to a `context` object and provides a `save()` method.
final class OfflineCacheStorage {
  /// The Singleton object to be used in the actual app.
  static let standard = OfflineCacheStorage()
  
  #if DEBUG
    /// An in-memory database access for faster tests that creates a new object on each call to start with empty data.
    static var test: OfflineCacheStorage { .init(inMemory: true) }
  #endif

  /// The persistent container providing access to different contexts, such as the `viewContext` or creating a `newBackgroundContext()`.
  private let container: NSPersistentContainer

  /// The default managed object Core Data context to be used. Returns a `viewContext` of the persistent container.
  var context: NSManagedObjectContext {
    container.viewContext
  }

  private init(
    inMemory: Bool = false
  ) {
    container = NSPersistentContainer(name: "Random")

    if inMemory {
      container.persistentStoreDescriptions.first!.url = URL(fileURLWithPath: "/dev/null")
    }

    container.loadPersistentStores { _, error in
      if let error = error as NSError? {
        // TODO: replace the fatal error with an error log once a proper Logger is established
        fatalError("Could not load Core Data persistent stores. Error \(error), \(error.userInfo)")
      }
    }
  }

  /// Saves the default managed object Core Data context if it has any changes. Use this, whenever you want to persist changes to the database.
  func save() {
    if context.hasChanges {
      do {
        try context.save()
      }
      catch {
        if let error = error as NSError? {
          // TODO: replace the fatal error with an error log once a proper Logger is established
          fatalError("Could not save context to Core Data. Error \(error), \(error.userInfo)")
        }
      }
    }
  }
}

