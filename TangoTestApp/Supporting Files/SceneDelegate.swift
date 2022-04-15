//
//  SceneDelegate.swift
//  TangoTestApp
//
//  Created by Okzhetpes Valikhanov on 15.04.2022.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        self.window = UIWindow(windowScene: windowScene)
        let apiService = ApiService()
        let viewModel: MainViewModel = .init(service: apiService)
        let mainVC = MainViewController(viewModel: viewModel)
        let nc = UINavigationController(rootViewController: mainVC)
        self.window?.rootViewController = nc
        self.window?.makeKeyAndVisible()
    }
    
}

