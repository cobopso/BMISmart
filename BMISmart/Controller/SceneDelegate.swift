//
//  SceneDelegate.swift
//  BMISmart
//
//  Created by Nguyễn Hữu Khánh on 26/03/2021.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let myWindow = (scene as? UIWindowScene) else { return }
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.windowScene = myWindow
        
        let nav = UINavigationController(rootViewController: HomeVC())
        window?.rootViewController = nav
        window?.makeKeyAndVisible()
    }


}

