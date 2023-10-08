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
                TextField("Name", text: $order.name)
                TextField("Street address", text: $order.streetAddress)
                TextField("City", text: $order.city)
                TextField("Zip", text: $order.zip)
            }
            
            Section {
                NavigationLink {
                    CheckoutView(order: order)
                } label: {
                    Text("Check out")
                }
            }
            .disabled(!order.hasValidAddress)
        }
        .navigationTitle("Delivery details")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    AddressView(order: Order())
}
