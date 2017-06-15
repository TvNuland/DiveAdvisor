//
//  CoreDataManager.swift
//  DiveAdvisor
//
//  Created by Ton on 2017-06-15.
//  Copyright © 2017 Ton van Nuland. All rights reserved.
//

import CoreData

enum CoreDataError: Error {
    case omdbRequest(details: String)
}

class CoredataManager {
    
    static let coreDataContainerName = "DiveAdvisor"
    static let sharedInstance = CoredataManager()
    
    private init() {
    }
    
    private lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer (name: coreDataContainerName)
        container.loadPersistentStores(completionHandler: {
            (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    private func saveContext() {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch  {
                let error = error as NSError
                fatalError ( "Unresolved error \(error), \(error.userInfo)") }
        }
    }
    
    func storeDiveDetails(for details: DiveDetails) {
        let context = persistentContainer.viewContext
        context.performAndWait {
            let detailsManagedObject = DiveDetails(context: context)
            detailsManagedObject.id = details.id
            detailsManagedObject.image = details.image
            detailsManagedObject.review = details.review
            detailsManagedObject.normalTemperature = details.normalTemperature
            detailsManagedObject.waterTemperature = details.waterTemperature
        }
        saveContext()
   }
    
    func deleteDiveDetails(for details: DiveDetails) {
        let context = persistentContainer.viewContext
        context.delete(details)
        saveContext()
    }
    
    func loadDiveDetails(for diveSiteID: Int) -> DiveDetails {
        let fetchRequest: NSFetchRequest<DiveDetails> = DiveDetails.fetchRequest()
        
        let predicate = NSPredicate(format: "\(#keyPath(DiveDetails.id)) == \(diveSiteID)")
        fetchRequest.predicate = predicate
        
        var fetchedDetails: [DiveDetails]?
        let context = persistentContainer.viewContext
        
        context.performAndWait {
            fetchedDetails = try? fetchRequest.execute()
        }
        return fetchedDetails!.first!
    }
}
