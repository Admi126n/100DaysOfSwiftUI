//
//  ContentView.swift
//  CupcakeCorner
//
//  Created by Adam Tokarski on 07/10/2023.
//

import SwiftUI

struct ContentView: View {
    @StateObject var order = Order()
    
    var body: some View {
        NavigationStack {
            Form {
                Section {
                    Picker("Select your cake type", selection: $order.item.type) {
                        ForEach(OrderItem.types.indices, id: \.self) {
                            Text(OrderItem.types[$0])
                        }
                    }
                    .pickerStyle(.menu)
                    
                    Stepper("Number of cakes: \(order.item.quantity)", value: $order.item.quantity, in: 2...20)
                }
                
                Section {
                    Toggle("Any special requests?", isOn: $order.item.specialRequestEnabled.animation())
                    
                    if order.item.specialRequestEnabled {
                        Toggle("Add extra frosting", isOn: $order.item.extraFrosting)
                        
                        Toggle("Add extra sprinkles", isOn: $order.item.addSprinkles)
                    }
                }
                
                Section {
                    NavigationLink {
                        AddressView(order: order)
                    } label: {
                        Text("Delivery details")
                    }
                }
            }
            .navigationTitle("Cupcake Corner")
        }
    }
}

#Preview {
    ContentView()
}
