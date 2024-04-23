//
//  Order.swift
//  CupcakeCorner
//
//  Created by MaćKo on 23/04/2024.
//

import Foundation

@Observable
class Order: Codable {
    enum CodingKeys: String, CodingKey {
            case _type = "type"
            case _quantity = "quantity"
            case _specialRequestEnabled = "specialRequestEnabled"
            case _extraFrosting = "extraFrosting"
            case _addSprinkles = "addSprinkles"
            case _address = "address"
        }

    static let types = ["Vanilla", "Strawberry", "Chocolate", "Rainbow"]

    var type = 0
    var quantity = 3

    var specialRequestEnabled = false {
        didSet {
            if specialRequestEnabled == false {
                extraFrosting = false
                addSprinkles = false
            }
        }
    }
    var extraFrosting = false
    var addSprinkles = false

    struct Address: Codable {
        var name = ""
        var street = ""
        var city = ""
        var zip = ""
    }

    var address = Address() {
        didSet {
            if let encodedAddress = try? JSONEncoder().encode(address) {
                UserDefaults.standard.setValue(encodedAddress, forKey: "Address")
            }
        }
    }

    var hasValidAddress: Bool {
        if address.name.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty || address.street.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty || address.city.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty || address.zip.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
            return false
        }

        return true
    }

    var cost: Decimal {
        // $2 per cake
        var cost = Decimal(quantity) * 2

        // complicated cakes cost more
        cost += Decimal(type) / 2

        // $1/cake for sprinkles
        if addSprinkles {
            cost += Decimal(quantity)
        }

        // $0.5/cake for sprinkles
        if addSprinkles {
            cost += Decimal(quantity) * 0.5
        }

        return cost
    }

    init() {
        if let savedAddress = UserDefaults.standard.data(forKey: "Address") {
            if let decodedAddress = try? JSONDecoder().decode(Address.self, from: savedAddress) {
                address = decodedAddress

                return
            }
        }

        address = Address()
    }
}
