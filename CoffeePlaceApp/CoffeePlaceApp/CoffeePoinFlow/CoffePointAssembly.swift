//
//  CoffePointAssembly.swift
//  CoffeePlaceApp
//
//  Created by Havydope Diii on 02.11.2024.
//

class CoffePointAssembly {
    
    func makeCoffePointViewController() -> CoffePointViewController {
        let vc = CoffePointViewController()
        let router = CoffePointRouter(viewcontroller: vc)
        let presenter = CoffePointPresenter(viewcontroller: vc, router: router)
        vc.presenter = presenter
        return vc
    }
}
