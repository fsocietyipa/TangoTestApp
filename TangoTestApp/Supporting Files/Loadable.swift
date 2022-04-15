//
//  Loadable.swift
//  TangoTestApp
//
//  Created by Okzhetpes Valikhanov on 15.04.2022.
//

import UIKit

protocol Loadable {
    func setLoader(isFetching: Bool)
}

extension Loadable where Self: UIViewController {
    func setLoader(isFetching: Bool) {
        if isFetching {
            self.view.subviews.forEach { (subview) in
                if subview is UIActivityIndicatorView {
                    self.view.isUserInteractionEnabled = true
                    subview.removeFromSuperview()
                }
            }
            let activityIndicator = UIActivityIndicatorView(style: .large)
            activityIndicator.startAnimating()
            self.view.addSubview(activityIndicator)
            activityIndicator.center = self.view.center
            self.view.isUserInteractionEnabled = false
        } else {
            self.view.subviews.forEach { (subview) in
                if subview is UIActivityIndicatorView {
                    self.view.isUserInteractionEnabled = true
                    subview.removeFromSuperview()
                }
            }
        }
    }
}
