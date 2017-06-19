//
//  CoreDataManager.swift
//  DiveAdvisor
//
//  Created by Ton on 2017-06-15.
//  Copyright © 2017 Ton van Nuland. All rights reserved.
//

import CoreData

struct InterfaceDiveDetails {
    let id: Int16
    let image: NSObject?
    let normalTemperature: Double
    let review: String
    let waterTemperature: Double
    
    init(id: Int16, image: NSObject?, normalTemperature: Double, review: String, waterTemperature: Double) {
        self.id = id
        self.image = image
        self.normalTemperature = normalTemperature
        self.review = review
        self.waterTemperature = waterTemperature
    }
}

class CoreDataManager {
    
    private static let coreDataContainerName = "DiveAdvisor"
    static let sharedInstance = CoreDataManager()
    
    private init() {
    }
    
    private lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer (name: coreDataContainerName)
        container.loadPersistentStores(completionHandler: {
            (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error for CoreData container \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    private func saveContext() throws {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            try context.save()
        }
    }
    
    func storeDiveDetails(for details: InterfaceDiveDetails) throws {
        let context = persistentContainer.viewContext
        context.performAndWait {
            let detailsManagedObject = DiveDetails(context: context)
            detailsManagedObject.id = details.id
            detailsManagedObject.image = details.image
            detailsManagedObject.review = details.review
            detailsManagedObject.normalTemperature = details.normalTemperature
            detailsManagedObject.waterTemperature = details.waterTemperature
        }
        try saveContext()
    }
    
    func deleteDiveDetails(for details: DiveDetails) throws {
        let context = persistentContainer.viewContext
        context.delete(details)
        try saveContext()
    }
    
    func loadDiveDetails(for diveSiteID: Int) -> DiveDetails {
        let context = persistentContainer.viewContext
        let fetchRequest: NSFetchRequest<DiveDetails> = DiveDetails.fetchRequest()
        let predicate = NSPredicate(format: "\(#keyPath(DiveDetails.id)) == \(diveSiteID)")
        fetchRequest.predicate = predicate
        var fetchedDetails: [DiveDetails] = []
        context.performAndWait {
            do {
                fetchedDetails = try fetchRequest.execute()
            } catch let error as NSError {
                fatalError ("Unresolved error for CoreData fetchRequest \(error), \(error.userInfo)")
            }
        }
        return fetchedDetails.first!
    }

    typealias loadFavoritesResponse = ([DiveDetails]) -> Void
    
    func loadFavorites(onCompletion: @escaping ([DiveDetails]?) -> Void) {
        let context = persistentContainer.viewContext
        let fetchRequest: NSFetchRequest<DiveDetails> = DiveDetails.fetchRequest()
        let sortByID = NSSortDescriptor(key: #keyPath(DiveDetails.id), ascending: true)
        fetchRequest.sortDescriptors = [sortByID]
        context.perform {
            do {
                let favorites = try context.fetch(fetchRequest)
                onCompletion(favorites)
            } catch let error as NSError {
                fatalError ("Unresolved error for CoreData fetchRequest \(error), \(error.userInfo)")
            }
        }
    }
    
}
