//
//  OrderRouter.swift
//  CoffeePlaceApp
//
//  Created by Havydope Diii on 03.11.2024.
//

class OrderRouter {
    var viewController: OrderViewController
    init(viewController: OrderViewController) {
        self.viewController = viewController
    }
    
    func goBack(){
        viewController.navigationController?.popViewController(animated: true)
    }
}
