//
//  LoadingAssembly.swift
//  CoffeePlaceApp
//
//  Created by Havydope Diii on 31.10.2024.
//


final class LoadingAssembly{
    func makeLoadingView() -> LoadingViewController{
        let vc = LoadingViewController()
        let router = LoadingRouter(viewcontroller: vc)
        let presenter = LoadingPresenter(viewController: vc, router: router)
        vc.presenter = presenter
        return vc
    }
    
}
