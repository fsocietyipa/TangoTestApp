//
//  MainView.swift
//  TangoTestApp
//
//  Created by Okzhetpes Valikhanov on 15.04.2022.
//

import UIKit

final class MainView: UIView {

    let tableView: UITableView = {
        let tv = UITableView()
        tv.register(ProductInfoCell.self, forCellReuseIdentifier: "cell")
        tv.refreshControl = UIRefreshControl()
        return tv
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupViews() {
        [tableView].forEach({ self.addSubview($0) })
    }
    
    func setupConstraints() {
        tableView.fillSuperView()
    }
    
}
