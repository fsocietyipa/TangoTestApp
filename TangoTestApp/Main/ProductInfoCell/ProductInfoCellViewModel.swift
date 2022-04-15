//
//  ProductInfoCellViewModel.swift
//  TangoTestApp
//
//  Created by Okzhetpes Valikhanov on 15.04.2022.
//

import Foundation
import UIKit

final class ProductInfoCellViewModel {
    private let productData: Product
    
    var imageUrlString: String? {
        return productData.images.first?.image
    }
    
    var productName: String {
        return productData.productName
    }
    
    var manufacturerName: String {
        return productData.manufacturer.name
    }
    
    var price: String {
        return productData.grossPrice
    }
    
    init(productData: Product) {
        self.productData = productData
    }
}
