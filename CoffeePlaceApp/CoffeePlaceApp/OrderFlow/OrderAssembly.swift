//
//  OrderAssembly.swift
//  CoffeePlaceApp
//
//  Created by Havydope Diii on 03.11.2024.
//

class OrderAssembly{
    func makeOrderView(cartOrder: [MenuItem:Int]) -> OrderViewController{
        let vc = OrderViewController()
        let router = OrderRouter(viewController: vc)
        let presenter = OrderPresenter(viewContoller: vc, router: router, cardOrder: cartOrder)
        vc.presenter = presenter
        return vc
    }
    
}
