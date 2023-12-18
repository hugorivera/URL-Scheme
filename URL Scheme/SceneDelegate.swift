//
//  SceneDelegate.swift
//  URL Scheme
//
//  Created by Hugo Francisco Rivera Quevedo on 17/12/23.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    var global_nav_controller: UINavigationController?
    
    func scene(_ scene: UIScene, openURLContexts URLContexts: Set<UIOpenURLContext>) {
        guard let url = URLContexts.first?.url else {
            return
        }
        
        if url.scheme == "firstsuccess" || url.scheme == "secondsuccess" {
            let data = handleScheme(url: url)
            NotificationCenter.default.post(name: NSNotification.Name(NotificationsNames.colorNotification.rawValue), object: nil, userInfo: data)
        }
    }
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        
        guard let _ = (scene as? UIWindowScene) else { return }
        
        if let urlContext = connectionOptions.urlContexts.first {
            let url = urlContext.url

            if url.scheme == "firstsuccess" {
                let data = handleScheme(url: url)
                if let color = data["color"] as? String, let _ = Colors(rawValue: color) {
                    let first_vc = ViewController.init()
                    global_nav_controller = UINavigationController(rootViewController: first_vc)
                    window?.rootViewController = global_nav_controller
                    window?.makeKeyAndVisible()
                    first_vc.createController(data: data)
                }
            }
        }
    }
    
    /// Funcion que procesa una url y extrae los datos de la query
    ///- Parameters:
    ///   - url: URL
    ///   - Returns: [String: Any] diccionario con los datos de la query
    func handleScheme(url: URL) -> [String: Any]{
        guard let components = NSURLComponents(url: url, resolvingAgainstBaseURL: true),
            let params = components.queryItems else {
                print("Invalid URL")
                return [:]
        }
        
        if let data = params.first(where: { $0.name == "color" })?.value {
            let info = ["color": data]
            return info
        } else {
            return [:]
        }
    }

    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }

    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
    }


}

