//
//  DetailCoffeeAssembly.swift
//  CoffeePlaceApp
//
//  Created by Havydope Diii on 02.11.2024.
//

final class DetailCoffeeAssembly {
    
    func makeDetailCoffeeViewController(coffePoint: CoffePoint) -> DetailCoffeeViewController {
        let vc = DetailCoffeeViewController()
        let router = DetailCoffeeRouter(viewcontroller: vc)
        let presenter = DetailCoffeePresenter(viewcontroller: vc, router: router, idCoffeePoint: coffePoint)
        vc.presenter = presenter
        return vc
    }
}
