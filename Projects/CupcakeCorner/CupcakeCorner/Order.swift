//
//  Order.swift
//  CupcakeCorner
//
//  Created by Adam Tokarski on 08/10/2023.
//

import SwiftUI

class Order: ObservableObject, Codable {
    private enum CodingKeys: CodingKey {
        case item
    }
    
    @Published var item = OrderItem()
    
    init() { }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        item = try container.decode(OrderItem.self, forKey: .item)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        try container.encode(item, forKey: .item)
    }
    
}

struct OrderItem: Codable {
    static let types = ["Vanilla", "Strawberry", "Chocolate", "Rainbow"]
    
    var type = 0
    var quantity = 3
    var specialRequestEnabled = false {
        didSet {
            if !specialRequestEnabled {
                extraFrosting = false
                addSprinkles = false
            }
        }
    }
    
    var extraFrosting = false
    var addSprinkles = false
    
    var name = ""
    var streetAddress = ""
    var city = ""
    var zip = ""
    
    var hasValidAddress: Bool {
        !(name.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty ||
        streetAddress.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty ||
        city.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty ||
        zip.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty)
    }
    
    var cost: Double {
        var cost = Double(quantity) * 2
        cost += (Double(type) / 2)
        
        if extraFrosting { cost += Double(quantity) }
        if addSprinkles { cost += (Double(quantity) / 2) }
        
        return cost
    }
}
