//
//  MainViewModel.swift
//  TangoTestApp
//
//  Created by Okzhetpes Valikhanov on 15.04.2022.
//

import Foundation

protocol MainViewModelDelegate: AnyObject {
    func productsFetched()
    func errorOccurred(message: String)
    func isFetching(_ value: Bool)
}

protocol MainViewModelType {
    var delegate: MainViewModelDelegate? { get set }
    var numberOfProduct: Int { get }
    func getData()
    func searchProducts(name: String)
    func cellViewModel(at index: Int) -> ProductInfoCellViewModel?
}

final class MainViewModel: MainViewModelType {
 
    private let service: ApiServicable
    
    private var productArray = [Product]()
    
    var numberOfProduct: Int {
        return productArray.count
    }
    
    weak var delegate: MainViewModelDelegate?
    
    init(service: ApiServicable) {
        self.service = service
    }
    
    func getData() {
        delegate?.isFetching(true)
        Task(priority: .userInitiated) {
            let result = await service.getProducts()
            defer {
                DispatchQueue.main.async {
                    self.delegate?.isFetching(false)
                }
            }
            switch result {
            case .success(let products):
                DispatchQueue.main.async {
                    self.productArray = products
                    self.delegate?.productsFetched()
                }
            case .failure(let error):
                DispatchQueue.main.async {
                    self.delegate?.errorOccurred(message: error.customMessage)
                }
            }
        }
    }
    
    func searchProducts(name: String) {
        delegate?.isFetching(true)
        Task(priority: .userInitiated) {
            let result = await service.searchProducts(name: name)
            defer {
                DispatchQueue.main.async {
                    self.delegate?.isFetching(false)
                }
            }
            switch result {
            case .success(let products):
                DispatchQueue.main.async {
                    self.productArray = products
                    self.delegate?.productsFetched()
                }
            case .failure(let error):
                DispatchQueue.main.async {
                    self.delegate?.errorOccurred(message: error.customMessage)
                }
          }
        }
    }
    
    func cellViewModel(at index: Int) -> ProductInfoCellViewModel? {
        guard index < productArray.count else { return nil }
        return ProductInfoCellViewModel(productData: productArray[index])
    }
    
}
