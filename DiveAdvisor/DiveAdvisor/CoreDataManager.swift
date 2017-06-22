//
//  CoreDataManager.swift
//  DiveAdvisor
//
//  Created by Ton on 2017-06-15.
//  Copyright © 2017 Ton van Nuland. All rights reserved.
//

import Foundation
import CoreData

enum LoadDiveDetailsResults {
    case success(DiveDetails)
    case notFound
}

struct InterfaceDiveDetails {
    var id: Int16
    var name: String?
    var country: String?
    var ocean: String?
    var imageURL: String?
    var review: String?
    var latitude: Double
    var longitude: Double
    
    init(id: Int16, name: String, country: String, ocean: String, imageURL: String, review: String, latitude: Double, longitude: Double) {
        self.id = id
        self.name = name
        self.country = country
        self.ocean = ocean
        self.imageURL = imageURL
        self.review = review
        self.latitude = latitude
        self.longitude = longitude
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
    
    //  MARK: Store CoreData entity DiveDetails
    func storeDiveDetails(for details: InterfaceDiveDetails) throws {
        let context = persistentContainer.viewContext
        context.performAndWait {
            let detailsManagedObject = DiveDetails(context: context)
            detailsManagedObject.id = details.id
            detailsManagedObject.name = details.name
            detailsManagedObject.country = details.country
            detailsManagedObject.ocean = details.ocean
            detailsManagedObject.imageURL = details.imageURL
            detailsManagedObject.review = details.review
            detailsManagedObject.latitude = details.latitude
            detailsManagedObject.longitude = details.longitude
        }
        try saveContext()
    }
    
    //  MARK: Delete CoreData entity DiveDetails
    func deleteDiveDetails(for diveSiteID: Int) throws {
        let context = persistentContainer.viewContext
        let result = loadDiveDetails(for: diveSiteID)
        switch result {
        case .success(let loadDetail):
            context.delete(loadDetail)
            try saveContext()
        case .notFound:
            break
        }
    }
    
    //  MARK: Load CoreData entity DiveDetails
    func loadDiveDetails(for diveSiteID: Int) -> LoadDiveDetailsResults {
        let context = persistentContainer.viewContext
        let fetchRequest: NSFetchRequest<DiveDetails> = DiveDetails.fetchRequest()
        let predicate = NSPredicate(format: "\(#keyPath(DiveDetails.id)) == \(diveSiteID)")
        fetchRequest.predicate = predicate
        var fetchedDetails: [DiveDetails] = []
        context.performAndWait {
            do {
                fetchedDetails = try fetchRequest.execute()
            } catch let error as NSError {
                fatalError("Unresolved error for CoreData fetchRequest \(error), \(error.userInfo)")
            }
        }
        if fetchedDetails.isEmpty {
            return .notFound
//        } else if fetchedDetails.count != 1 {
//            fatalError("CoreData fetchRequest not unique for id: \(diveSiteID)")
        } else {
            return .success(fetchedDetails.first!)
        }
    }
    
    //  MARK: Load all CoreData entities DiveDetails sorted by id
    func loadFavoriteDiveDetails(onCompletion: @escaping ([DiveDetails]) -> Void) {
        let context = persistentContainer.viewContext
        let fetchRequest: NSFetchRequest<DiveDetails> = DiveDetails.fetchRequest()
        let sortByID = NSSortDescriptor(key: #keyPath(DiveDetails.id), ascending: true)
        fetchRequest.sortDescriptors = [sortByID]
        context.perform {
            do {
                let favorites = try context.fetch(fetchRequest)
                onCompletion(favorites)
            } catch let error as NSError {
                fatalError("Unresolved error for CoreData fetchRequest \(error), \(error.userInfo)")
            }
        }
    }
    
}
