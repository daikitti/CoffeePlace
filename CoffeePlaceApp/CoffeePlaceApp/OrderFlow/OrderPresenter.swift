//
//  OrderPresenter.swift
//  CoffeePlaceApp
//
//  Created by Havydope Diii on 03.11.2024.
//

class OrderPresenter{
    weak var viewContoller: OrderViewController?
    var router: OrderRouter?
    var cardOrder: [MenuItem:Int]
    
    init(viewContoller: OrderViewController? = nil, router: OrderRouter? = nil, cardOrder: [MenuItem : Int]) {
        self.viewContoller = viewContoller
        self.router = router
        self.cardOrder = cardOrder
    }
    
    func goBack(){
        router?.goBack()
    }
  
}
