//
//  CoffePointPresenter.swift
//  CoffeePlaceApp
//
//  Created by Havydope Diii on 02.11.2024.
//


class CoffePointPresenter {
    var viewcontroller: CoffePointViewController?
    let router: CoffePointRouter
    
    init(viewcontroller: CoffePointViewController? , router: CoffePointRouter) {
        self.viewcontroller = viewcontroller
        self.router = router
    }
    
     func fetchLocations() {
           Task {
               do {
                   let coffeePointsData = try await APIService.shared.getCoffePoints()
                   print(coffeePointsData)
                   await viewcontroller?.reload(with: coffeePointsData)
               } catch {
                   print("Ошибка получения кофеен: \(error.localizedDescription)")
               }
           }
       }
    
    func goDetail(point:CoffePoint){
        router.goDetailViewController(point: point)
    }
    
}
