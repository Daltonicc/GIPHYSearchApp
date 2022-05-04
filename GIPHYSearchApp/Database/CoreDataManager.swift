//
//  CoreDataManager.swift
//  GIPHYSearchApp
//
//  Created by 박근보 on 2022/05/03.
//

import Foundation
import CoreData

final class CoreDataManager {

    static let shared: CoreDataManager = CoreDataManager()

    private init() {}

    var container: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "GIFData")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

    var context: NSManagedObjectContext {
        return self.container.viewContext
    }

    func fetchData<T: NSManagedObject>(request: NSFetchRequest<T>) -> [T] {
        do {
            let fetchResult = try self.context.fetch(request)
            return fetchResult
        } catch {
            print(error.localizedDescription)
            return []
        }
    }

    @discardableResult func saveGIFItem(item: GIFItem?) -> Bool {

        let entity = NSEntityDescription.entity(forEntityName: "GIFFavoriteItem", in: self.context)
        if let entity = entity {
            let managedObject = NSManagedObject(entity: entity, insertInto: self.context)

            managedObject.setValue(true, forKey: "isFavorite")
            managedObject.setValue(item.user.name, forKey: "username")
            managedObject.setValue(item.user.avatarURL, forKey: "avatarURL")
            managedObject.setValue(item.id, forKey: "id")
            managedObject.setValue(item.images.original.url, forKey: "originalURL")
            managedObject.setValue(item.images.original.height, forKey: "originalHeight")
            managedObject.setValue(item.images.preview.url, forKey: "previewURL")

            do {
                try self.context.save()
                return true
            } catch {
                return false
            }
        } else {
            return false
        }
    }

    @discardableResult func deleteGIFItem(object: NSManagedObject) -> Bool {
        self.context.delete(object)
        do {
            try self.context.save()
            return true
        } catch {
            return false
        }
    }
}
