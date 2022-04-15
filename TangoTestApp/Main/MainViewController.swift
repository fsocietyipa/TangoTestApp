//
//  MainViewController.swift
//  TangoTestApp
//
//  Created by Okzhetpes Valikhanov on 15.04.2022.
//

import UIKit

protocol MainViewControllerType {
    func setDelegeates()
    func setActions()
    func setupViews()
    func setupConstraints()
    func showError(message: String)
}

final class MainViewController: UIViewController, MainViewControllerType, Loadable {
    
    private var viewModel: MainViewModelType
    
    private let mainView = MainView()
    
    private let searchController: UISearchController = {
        let sc = UISearchController(searchResultsController: nil)
        sc.obscuresBackgroundDuringPresentation = false
        sc.searchBar.placeholder = String(localized: "enter_product_name")
        return sc
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupConstraints()
        setDelegeates()
        setActions()
    }
    
    init(viewModel: MainViewModelType) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setDelegeates() {
        viewModel.delegate = self
        viewModel.getData()
        mainView.tableView.delegate = self
        mainView.tableView.dataSource = self
        searchController.searchResultsUpdater = self
        searchController.delegate = self
    }
    
    func setActions() {
        guard let refreshControl = mainView.tableView.refreshControl else { return }
        refreshControl.addTarget(self, action: #selector(refreshData), for: .valueChanged)
    }
    
    func setupViews() {
        view.backgroundColor = .white
        title = String(localized: "products_title")
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.searchController = searchController
        [mainView].forEach({ view.addSubview($0) })
    }
    
    func setupConstraints() {
        mainView.fillSafeSuperView()
    }
    
    func showError(message: String) {
        let alertController = UIAlertController(title: String(localized: "error"), message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: String(localized: "ok"), style: .default))
        self.present(alertController, animated: true)
    }
    
    @objc func refreshData() {
        viewModel.getData()
        mainView.tableView.refreshControl?.endRefreshing()
        UIView.animate(withDuration: 0.8, animations: {
            self.mainView.tableView.contentOffset = CGPoint.zero
        })
    }
}

extension MainViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfProduct
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as? ProductInfoCell else { return UITableViewCell() }
        let cellViewModel = viewModel.cellViewModel(at: indexPath.row)
        cell.productNameLabel.text = cellViewModel?.productName
        cell.manufacturerNameLabel.text = cellViewModel?.manufacturerName
        cell.priceLabel.text = cellViewModel?.price
        if let imageUrlString = cellViewModel?.imageUrlString {
            ImageLoader.sharedLoader.imageForUrl(urlString: imageUrlString, completionHandler:{(image: UIImage?, url: String) in
                cell.productImageView.image = image
            })
        }
        return cell
    }
}

extension MainViewController: MainViewModelDelegate {
    func productsFetched() {
        mainView.tableView.reloadData()
    }
    
    func errorOccurred(message: String) {
        showError(message: message)
    }
    
    func isFetching(_ value: Bool) {
        self.setLoader(isFetching: value)
    }
}

extension MainViewController: UISearchResultsUpdating, UISearchControllerDelegate {
    func updateSearchResults(for searchController: UISearchController) {
        guard let name = searchController.searchBar.text else { return }
        if name.isEmpty {
            viewModel.getData()
        } else {
            viewModel.searchProducts(name: name)
        }
    }
    
    func didDismissSearchController(_ searchController: UISearchController) {
        viewModel.getData()
    }

}
