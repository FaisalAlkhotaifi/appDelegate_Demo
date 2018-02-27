//
//  PersonName+CoreDataProperties.swift
//  appDelegate_Demo
//
//  Created by Faisal Alkhotaifi on 2/25/18.
//  Copyright © 2018 Faisal Alkhotaifi. All rights reserved.
//
//

import Foundation
import CoreData


extension PersonName {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<PersonName> {
        return NSFetchRequest<PersonName>(entityName: "PersonName")
    }

    @NSManaged public var name: String?

}
