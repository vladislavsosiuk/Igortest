//
//  DataPost+CoreDataProperties.swift
//  
//
//  Created by air on 30.09.17.
//
//

import Foundation
import CoreData


extension DataPost {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<DataPost> {
        return NSFetchRequest<DataPost>(entityName: "DataPost")
    }

    @NSManaged public var id: Int32
    @NSManaged public var userId: Int32
    @NSManaged public var title: String?
    @NSManaged public var body: String?

}
