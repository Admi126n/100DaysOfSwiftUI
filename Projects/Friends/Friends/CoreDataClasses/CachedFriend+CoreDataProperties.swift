//
//  CachedFriend+CoreDataProperties.swift
//  Friends
//
//  Created by Adam Tokarski on 19/10/2023.
//
//

import Foundation
import CoreData


extension CachedFriend {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CachedFriend> {
        return NSFetchRequest<CachedFriend>(entityName: "CachedFriend")
    }

    @NSManaged public var id: String?
    @NSManaged public var name: String?
    @NSManaged public var origin: CachedUser?

    var wrappedName: String {
        name ?? "Unknown name"
    }
    
}

extension CachedFriend : Identifiable {

}
