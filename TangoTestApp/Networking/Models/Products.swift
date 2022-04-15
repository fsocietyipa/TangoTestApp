//
//  Products.swift
//  TangoTestApp
//
//  Created by Okzhetpes Valikhanov on 15.04.2022.
//

import Foundation

struct Product: Codable {
    let id, sku, slug, productName: String
    let grossPrice: String
    let images: [Image]
    let manufacturer: Manufacturer

    enum CodingKeys: String, CodingKey {
        case id, sku, slug
        case productName = "product_name"
        case grossPrice = "gross_price"
        case images, manufacturer
    }
}

struct Image: Codable {
    let image: String
    let order: Int
}

struct Manufacturer: Codable {
    let slug, name: String
}

typealias Products = [Product]

