//
//  AddressView.swift
//  CupcakeCorner
//
//  Created by MaćKo on 23/04/2024.
//

import SwiftUI

struct AddressView: View {
    @Bindable var order: Order

    var body: some View {
        Form {
            Section {
                TextField("Name", text: $order.address.name)
                TextField("Street Address", text: $order.address.street)
                TextField("City", text: $order.address.city)
                TextField("Zip", text: $order.address.zip)
            }

            Section {
                NavigationLink("Check out") {
                    CheckoutView(order: order)
                }
            }
            .disabled(order.hasValidAddress == false)
        }
        .navigationTitle("Delivery details")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    NavigationStack {
        AddressView(order: Order())
    }
}
