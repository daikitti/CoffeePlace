//
//  DetailCoffeePresenter.swift
//  CoffeePlaceApp
//
//  Created by Havydope Diii on 02.11.2024.
//

class DetailCoffeePresenter {
    weak var viewcontroller: DetailCoffeeViewController?
    var router: DetailCoffeeRouter
    let coffeePoint: CoffePoint
    init(viewcontroller: DetailCoffeeViewController? = nil, router: DetailCoffeeRouter, idCoffeePoint: CoffePoint) {
        self.viewcontroller = viewcontroller
        self.router = router
        self.coffeePoint = idCoffeePoint
    }
    
    func fetchMenuItems() {
        Task {
            do {
                let coffeePointsData = try await APIService.shared.getMenu(for: coffeePoint.id)
                await viewcontroller?.reloadView(coffePoint: coffeePointsData)
                
            } catch {
                print("Ошибка получения менюшек: \(error.localizedDescription)")
            }
        }
    }
    
    func goBack(){
        router.goBack()
    }
    
    func goPayOrder(orderCart: [MenuItem:Int]){
        router.goPayOrder(orderCart: orderCart)
    }
}

