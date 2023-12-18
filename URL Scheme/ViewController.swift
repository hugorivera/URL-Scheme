//
//  ViewController.swift
//  URL Scheme
//
//  Created by Hugo Francisco Rivera Quevedo on 17/12/23.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var label: UILabel!
    
    var viewController: UIViewController?

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        NotificationCenter.default.addObserver(self, selector: #selector(handleNotification(_:)), name: NSNotification.Name(NotificationsNames.colorNotification.rawValue), object: nil)
    }

    /// Funcion que maneja la notificacion que viene desde el NotificationCenter
    ///- Parameters:
    ///   - notification: Notification datos que vienen desde la notificacion
    @objc func handleNotification(_ notification: Notification) {
        if let data = notification.userInfo as? [String: Any] {
            createController(data: data)
        }
    }
    
    /// Crea un nuevo controlador, si es que ya existe uno lo cierra
    ///- Parameters:
    ///   - data: [String: Any] diccionario con los datos que vienen desde la url
    public func createController(data: [String: Any]) {
        guard let color = data["color"] as? String, let backgroundColor = Colors(rawValue: color) else { return }
        
        if viewController != nil {
            viewController?.dismiss(animated: true)
        }
        
        self.viewController = UIViewController()
        self.viewController?.view.backgroundColor = backgroundColor.setBackgroundColor()
        present(self.viewController ?? UIViewController(), animated: true)
        
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }

}

