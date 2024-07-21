import Foundation
import CoreData
import UIKit

class CoreDataHelper {
    
    // MARK: - Core Data Stack
    static let shared = CoreDataHelper()
    
    private init() {}
    
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "DogsData")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    var context: NSManagedObjectContext {
        return persistentContainer.viewContext
    }
    
    // MARK: - Save Context
    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
    // MARK: - Generic CRUD Operations
    
    // Create
    func create<T: NSManagedObject>(entity: T.Type) -> T {
        let entityName = String(describing: entity)
        let entityObject = NSEntityDescription.insertNewObject(forEntityName: entityName, into: context) as! T
        return entityObject
    }
    
    // Read
    func fetch<T: NSManagedObject>(entity: T.Type, predicate: NSPredicate? = nil) -> [T] {
        let entityName = String(describing: entity)
        let fetchRequest = NSFetchRequest<T>(entityName: entityName)
        fetchRequest.predicate = predicate
        
        do {
            let fetchedResults = try context.fetch(fetchRequest)
            return fetchedResults
        } catch {
            print("Error fetching: \(error)")
            return []
        }
    }
    
    // Update
    func update() {
        saveContext()
    }
    
    // Delete
    func delete<T: NSManagedObject>(object: T) {
        context.delete(object)
        saveContext()
    }
}
