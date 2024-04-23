//
//  CheckoutView.swift
//  CupcakeCorner
//
//  Created by MaćKo on 23/04/2024.
//

import SwiftUI

struct CheckoutView: View {
    @Bindable var order: Order

    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

#Preview {
    NavigationStack {
        CheckoutView(order: Order())
    }
}
