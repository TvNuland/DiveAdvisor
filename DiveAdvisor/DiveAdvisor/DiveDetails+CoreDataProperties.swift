//
//  DiveDetails+CoreDataProperties.swift
//  DiveAdvisor
//
//  Created by Ton on 2017-06-15.
//  Copyright © 2017 ben smith. All rights reserved.
//

import Foundation
import CoreData


extension DiveDetails {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<DiveDetails> {
        return NSFetchRequest<DiveDetails>(entityName: "DiveDetails")
    }

    @NSManaged public var id: Int16
    @NSManaged public var image: NSObject?
    @NSManaged public var normalTemperature: Double
    @NSManaged public var review: String?
    @NSManaged public var waterTemperature: Double

}
