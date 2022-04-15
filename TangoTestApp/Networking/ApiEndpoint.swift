//
//  ItemLoader.swift
//  TangoTestApp
//
//  Created by Okzhetpes Valikhanov on 15.04.2022.
//

import Foundation

enum ApiEndpoint {
    case getProducts
    case searchProducts(name: String)
}

extension ApiEndpoint: Endpoint {
    var path: String {
        switch self {
        case .getProducts:
            return "products"
        case .searchProducts(let name):
            let trimmedName = name.trimmingCharacters(in: .whitespacesAndNewlines)
            return "products?name=\(trimmedName)"
        }
    }

    var method: RequestMethod {
        switch self {
        case .getProducts, .searchProducts:
            return .get
        }
    }

    var header: [String: String]? {
        switch self {
        case .getProducts, .searchProducts:
            return [
                "Content-Type": "application/json;charset=utf-8"
            ]
        }
    }
    
    var body: [String: String]? {
        switch self {
        case .getProducts, .searchProducts:
            return nil
        }
    }
}








