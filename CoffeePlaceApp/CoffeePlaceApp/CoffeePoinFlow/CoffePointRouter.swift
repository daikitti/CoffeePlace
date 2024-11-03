//
//  CoffePointRouter.swift
//  CoffeePlaceApp
//
//  Created by Havydope Diii on 02.11.2024.
//

import UIKit


class CoffePointRouter {
    
    weak var viewcontroller: CoffePointViewController?
    
    init(viewcontroller: CoffePointViewController? = nil) {
        self.viewcontroller = viewcontroller
    }
    
    func goDetailViewController(point: CoffePoint) {
        let controller =  DetailCoffeeAssembly().makeDetailCoffeeViewController(coffePoint: point)
        self.viewcontroller?.navigationController?.pushViewController(controller, animated: true)
    }
}
