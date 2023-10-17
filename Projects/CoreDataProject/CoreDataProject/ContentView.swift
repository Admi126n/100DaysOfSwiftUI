//
//  ContentView.swift
//  CoreDataProject
//
//  Created by Adam Tokarski on 15/10/2023.
//

import CoreData
import SwiftUI

// \.self is based on hash value of struct/object. Used struct has to conform to Hashable
// hash calculated twice: first in first app run and then second after relaunching app can have different values

struct ContentView: View {
    //    @FetchRequest(sortDescriptors: [], predicate:
    //                    NSPredicate(format: "universe == %@", "Star Wars")
    //    ) var ships: FetchedResults<Ship>
    
    @Environment(\.managedObjectContext) var moc
//    @FetchRequest(sortDescriptors: []) var countries: FetchedResults<Country>
//    
//    var body: some View {
//        VStack {
//            List {
//                ForEach(countries, id: \.self) { country in
//                    Section(country.wrappedFullName) {
//                        ForEach(country.candyArray, id: \.self) { candy in
//                            Text(candy.wrappedName)
//                        }
//                    }
//                }
//            }
//            
//            Button("Add examples") {
//                let candy1 = Candy(context: moc)
//                candy1.name = "Mars"
//                candy1.origin = Country(context: moc)
//                candy1.origin?.shortName = "UK"
//                candy1.origin?.fullName = "United Kingdom"
//                
//                let candy2 = Candy(context: moc)
//                candy2.name = "KitKat"
//                candy2.origin = Country(context: moc)
//                candy2.origin?.shortName = "UK"
//                candy2.origin?.fullName = "United Kingdom"
//                
//                let candy3 = Candy(context: moc)
//                candy3.name = "Toblerone"
//                candy3.origin = Country(context: moc)
//                candy3.origin?.shortName = "CH"
//                candy3.origin?.fullName = "Switzerland"
//                
//                try? moc.save()
//            }
//        }
//    }
    
    
        @State private var lastNameFilter = "A"
        var body: some View {
            VStack {
                FilteredList(filterKey: "lastName", .beginsWith, filterValue: lastNameFilter, sortDescriptor: [SortDescriptor(\Singer.firstName)]) { (singer: Singer) in
                    Text("\(singer.wrappedFirstName) \(singer.wrappedLastName)")
                }
    
                Button("Add examples") {
                    let taylor = Singer(context: moc)
                    taylor.firstName = "Taylor"
                    taylor.lastName = "Swift"
    
                    let ed = Singer(context: moc)
                    ed.firstName = "Ed"
                    ed.lastName = "Sheeran"
    
                    let adele = Singer(context: moc)
                    adele.firstName = "Adele"
                    adele.lastName = "Adkins"
                    
                    let bob = Singer(context: moc)
                    bob.firstName = "Bob"
                    bob.lastName = "Awalski"
    
                    try? moc.save()
                }
    
                Button("Show A") {
                    lastNameFilter = "A"
                }
    
                Button("Show S") {
                    lastNameFilter = "S"
                }
            }
        }
}

#Preview {
    ContentView()
}
