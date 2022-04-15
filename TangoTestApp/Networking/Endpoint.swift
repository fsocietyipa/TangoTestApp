//
//  Endpoint.swift
//  TangoTestApp
//
//  Created by Okzhetpes Valikhanov on 15.04.2022.
//

import Foundation

protocol Endpoint {
    var baseURL: String { get }
    var path: String { get }
    var method: RequestMethod { get }
    var header: [String: String]? { get }
    var body: [String: String]? { get }
}

extension Endpoint {
    var baseURL: String {
        return "https://radiant-inlet-94783.herokuapp.com/"
    }
}
