//
//  DetailCoffeeRouter.swift
//  CoffeePlaceApp
//
//  Created by Havydope Diii on 02.11.2024.
//


class DetailCoffeeRouter {
    var viewcontroller: DetailCoffeeViewController
    init(viewcontroller: DetailCoffeeViewController) {
        self.viewcontroller = viewcontroller
    }
    func goBack(){
        viewcontroller.navigationController?.popViewController(animated: true)
    }
}
