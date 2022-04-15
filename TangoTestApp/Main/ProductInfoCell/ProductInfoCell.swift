//
//  ProductInfoCell.swift
//  TangoTestApp
//
//  Created by Okzhetpes Valikhanov on 15.04.2022.
//

import UIKit

final class ProductInfoCell: UITableViewCell {

    let productImageView: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFill
        return view
    }()
    
    let productNameLabel: UILabel = {
        let lbl = UILabel()
        lbl.font = .boldSystemFont(ofSize: 20)
        lbl.numberOfLines = 0
        return lbl
    }()
    
    let manufacturerNameLabel: UILabel = {
        let lbl = UILabel()
        lbl.font = .systemFont(ofSize: 15)
        return lbl
    }()
    
    let priceLabel: UILabel = {
        let lbl = UILabel()
        lbl.font = .systemFont(ofSize: 16)
        return lbl
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        setupViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        productImageView.image = nil
    }
    
    private func setupViews() {
        [productImageView, productNameLabel, manufacturerNameLabel, priceLabel].forEach({ contentView.addSubview($0) })
    }
    
    private func setupConstraints() {
        productImageView.anchor(top: contentView.topAnchor, leading: contentView.leadingAnchor, padding: .init(top: 16, left: 16, bottom: 16, right: 0), size: .init(width: 100, height: 100))
        productNameLabel.anchor(top: contentView.topAnchor, leading: productImageView.trailingAnchor, trailing: contentView.trailingAnchor, padding: .init(top: 16, left: 8, bottom: 0, right: 16))
        manufacturerNameLabel.anchor(top: productNameLabel.bottomAnchor, leading: productImageView.trailingAnchor, trailing: contentView.trailingAnchor, padding: .init(top: 4, left: 8, bottom: 0, right: 16))
        priceLabel.anchor(top: manufacturerNameLabel.bottomAnchor, leading: productImageView.trailingAnchor, bottom: contentView.bottomAnchor, trailing: contentView.trailingAnchor, padding: .init(top: 4, left: 8, bottom: 16, right: 16))

    }
    
}
