//
//  Device+CoreDataProperties.swift
//  CoreDataTutorialSeries
//
//  Created by Avalgate Team on 14/02/19.
//  Copyright © 2019 iOS Dev. All rights reserved.
//
//

import Foundation
import CoreData


extension Device {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Device> {
        return NSFetchRequest<Device>(entityName: "Device")
    }

    @NSManaged public var name: String?
    @NSManaged public var version: String?
    @NSManaged public var company: String?

}
