//
//  Activities.swift
//  iActivity
//
//  Created by Adam Tokarski on 05/10/2023.
//

import Foundation

class Activities: ObservableObject {
    @Published private(set) var activities: [ActivityItem] = [] {
        didSet {
            if let encoded = try? JSONEncoder().encode(activities) {
                UserDefaults.standard.set(encoded, forKey: "Activities")
            }
        }
    }
    
    init() {
        if let savedActivites = UserDefaults.standard.data(forKey: "Activities") {
            if let decodedItems = try? JSONDecoder().decode([ActivityItem].self, from: savedActivites) {
                self.activities = decodedItems
                return
            }
        }
        
        self.activities = []
    }
    
    func addActivity(_ activity: ActivityItem) {
        activities.append(activity)
    }
    
    func incrementCounter(for activity: ActivityItem) {
        let index = activities.firstIndex(of: activity)!
        activities[index].count += 1
    }
    
    func deleteActivity(_ activity: ActivityItem) {
        let index = activities.firstIndex(of: activity)!
        activities.remove(at: index)
    }
}
