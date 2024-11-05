//
//  LoadingPresenter.swift
//  CoffeePlaceApp
//
//  Created by Havydope Diii on 31.10.2024.
//


class LoadingPresenter {
    weak var viewController: LoadingViewController?
    private let router: LoadingRouter
    
    init(viewController: LoadingViewController, router: LoadingRouter) {
        self.viewController = viewController
        self.router = router
    }
    
    func registrationAction(email: String, password: String){
        print("registrationAction")
        Task {
            do {
                try await APIService.shared.register(email: email, password: password)
                print("Registration successful")
                
                router.goToCoffeePoint()
            } catch let error as APIError {
                print("Registration failed: \(error.localizedDescription)")
            } catch {
                print("Unexpected error: \(error.localizedDescription)")
            }
        }
        
    }
    
    func loginAction(email: String, password: String){
        Task {
            do{
                try await APIService.shared.login(email: email, password: password)
                router.goToCoffeePoint()
            }catch let error as APIError{
                print("Login faled: \(error.localizedDescription)")
            }catch{
                print("Unexpected error: \(error.localizedDescription)")
            }
        }
    }
}
