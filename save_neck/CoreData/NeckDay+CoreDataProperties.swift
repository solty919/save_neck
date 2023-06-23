//
//  NeckDay+CoreDataProperties.swift
//  save_neck
//
//  Created by Kazuki Hayashida on 2023/06/23.
//
//

import Foundation
import CoreData


extension NeckDay {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<NeckDay> {
        return NSFetchRequest<NeckDay>(entityName: "Entity")
    }

    @NSManaged public var latitude: Double
    @NSManaged public var date: Date?
    @NSManaged public var longitude: Double

}

extension NeckDay : Identifiable {

}
