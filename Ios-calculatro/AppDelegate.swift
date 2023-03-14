//
//  AppDelegate.swift
//  Ios-calculatro
//
//  Created by rodoolfo gonzalez on 14-02-23.
//

import UIKit

 @main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    // creamos la ventana que es controlador princiopal de nuestra App.
    var window : UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        
        //Setup
        setupView()
        return true
    }
    
//MARK: - Private methods
    
    private func setupView(){
        //instanciamos una UIWindow que tenga la window tamaño completo de la pantalla
        window = UIWindow(frame: UIScreen.main.bounds)
        // instanciamos nuestro VC creado
        let kVc = HomeViewController()
        // decimos que nuestro controlador de vista principal es nuestro VC creado
        window?.rootViewController = kVc
        // decimos a nuestra ventana que se inicie y se muestre visible
        window?.makeKeyAndVisible()
    }
}

