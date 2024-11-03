//
//  LoadingRouter.swift
//  CoffeePlaceApp
//
//  Created by Havydope Diii on 31.10.2024.
//

import Foundation
import UIKit
class LoadingRouter{
    private let viewcontroller: LoadingViewController
    
    init(viewcontroller: LoadingViewController){
        self.viewcontroller = viewcontroller
    }
    
    func goToCoffeePoint(){
        DispatchQueue.main.async{
            let vc =  CoffePointAssembly().makeCoffePointViewController()
            let controller = UINavigationController(rootViewController:vc)
            controller.modalPresentationStyle = .fullScreen
            controller.navigationBar.isHidden = true
            self.viewcontroller.present(controller, animated: true)
        }
    }
}
