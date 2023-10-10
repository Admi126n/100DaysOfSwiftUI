//
//  CheckoutView.swift
//  CupcakeCorner
//
//  Created by Adam Tokarski on 08/10/2023.
//

import SwiftUI

struct CheckoutView: View {
    @ObservedObject var order: Order
    @State private var alertTitle = ""
    @State private var alertMessage = ""
    @State private var showAlert = false
    
    var body: some View {
        ScrollView {
            VStack {
                AsyncImage(url: URL(
                    string: "https://hws.dev/img/cupcakes@3x.jpg"), scale: 3) { image in
                    
                    image
                        .resizable()
                        .scaledToFit()
                } placeholder: {
                    ProgressView()
                }
                .frame(height: 233)
                
                Text("Your total is \(order.item.cost, format: .currency(code: "USD"))")
                    .font(.title)
                
                Button("Place order") {
                    Task {
                        await placeOrder()
                    }
                }
                .padding()
            }
        }
        .navigationTitle("Check out")
        .navigationBarTitleDisplayMode(.inline)
        .alert(alertTitle, isPresented: $showAlert) {
            Button("OK") { }
        } message: {
            Text(alertMessage)
        }
    }
    
    func placeOrder() async {
        guard let encoded = try? JSONEncoder().encode(order) else {
            print("Failed to encode order")
            return
        }
        
        let url = URL(string: "https://reqres.in/api/cupkakes")!
        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        
        do {
            let (data, _) = try await URLSession.shared.upload(for: request, from: encoded)
            let decodedOrder = try JSONDecoder().decode(Order.self, from: data)
            alertTitle = "Thank You!"
            alertMessage = """
            Your order for \(decodedOrder.item.quantity) x \
            \(OrderItem.types[decodedOrder.item.type].lowercased()) cupcakes is on its way
            """
            showAlert = true
            
        } catch {
            alertTitle = "Something went wrong"
            alertMessage = "Check your internet connection"
            showAlert = true
            
            print("Checkout failed")
            print(error)
        }
    }
}

#Preview {
    CheckoutView(order: Order())
}
