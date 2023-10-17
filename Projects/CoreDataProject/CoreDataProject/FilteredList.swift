//
//  FilteredList.swift
//  CoreDataProject
//
//  Created by Adam Tokarski on 16/10/2023.
//

import CoreData
import SwiftUI

struct FilteredList<T: NSManagedObject, Content: View>: View {
    @FetchRequest var fetchRequest: FetchedResults<T>
    let content: (T) -> Content
    
    var body: some View {
        List(fetchRequest, id: \.self) { item in
            self.content(item)
        }
    }
    
    init(filterKey: String, _ predicate: PredicateOperator, filterValue: String, sortDescriptor: [SortDescriptor<T>], @ViewBuilder content: @escaping (T) -> Content) {
        let predicate = predicate.rawValue
        
        _fetchRequest = FetchRequest<T>(sortDescriptors: sortDescriptor, predicate: NSPredicate(format: "%K \(predicate) %@", filterKey, filterValue))
        
        self.content = content
    }
}
