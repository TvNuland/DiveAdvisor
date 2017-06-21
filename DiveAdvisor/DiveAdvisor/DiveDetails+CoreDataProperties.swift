//
//  DiveDetails+CoreDataProperties.swift
//  DiveAdvisor
//
//  Created by Ton on 2017-06-21.
//  Copyright © 2017 ben smith. All rights reserved.
//

import Foundation
import CoreData


extension DiveDetails {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<DiveDetails> {
        return NSFetchRequest<DiveDetails>(entityName: "DiveDetails")
    }

    @NSManaged public var id: Int16
    @NSManaged public var name: String?
    @NSManaged public var review: String?
    @NSManaged public var ocean: String?
    @NSManaged public var imageURL: String?
    @NSManaged public var country: String?
    @NSManaged public var latitude: Double
    @NSManaged public var longitude: Double

}
