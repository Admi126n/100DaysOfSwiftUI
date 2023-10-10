//
//  AddressView.swift
//  CupcakeCorner
//
//  Created by Adam Tokarski on 08/10/2023.
//

import SwiftUI

struct AddressView: View {
    @ObservedObject var order: Order
    
    var body: some View {
        Form {
            Section {
                TextField("Name", text: $order.item.name)
                TextField("Street address", text: $order.item.streetAddress)
                TextField("City", text: $order.item.city)
                TextField("Zip", text: $order.item.zip)
            }
            
            Section {
                NavigationLink {
                    CheckoutView(order: order)
                } label: {
                    Text("Check out")
                }
            }
            .disabled(!order.item.hasValidAddress)
        }
        .navigationTitle("Delivery details")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    AddressView(order: Order())
}
