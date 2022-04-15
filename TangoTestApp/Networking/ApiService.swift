//
//  ApiService.swift
//  TangoTestApp
//
//  Created by Okzhetpes Valikhanov on 15.04.2022.
//

import Foundation

protocol ApiServicable {
    func getProducts() async -> Result<Products, RequestError>
    func searchProducts(name: String) async -> Result<Products, RequestError>
}

struct ApiService: HTTPClient, ApiServicable {
    func getProducts() async -> Result<Products, RequestError> {
        return await sendRequest(endpoint: ApiEndpoint.getProducts, responseModel: Products.self)
    }
    
    func searchProducts(name: String) async -> Result<Products, RequestError> {
        return await sendRequest(endpoint: ApiEndpoint.searchProducts(name: name), responseModel: Products.self)
    }
    
}
