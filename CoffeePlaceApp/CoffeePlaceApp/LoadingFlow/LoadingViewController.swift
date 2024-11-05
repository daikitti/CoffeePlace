//
//  ViewController.swift
//  CoffeePlaceApp
//
//  Created by Havydope Diii on 31.10.2024.
//

import UIKit
import SnapKit

class LoadingViewController: UIViewController {
    
    private lazy var backgroundView: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "BackgroundImage")
        return view
    }()
    
    private lazy var loginFormView: LoginFormView = {
        let view = LoginFormView()
        return view
    }()
    
    private lazy var loginButton: UIButton = {
        let button  = UIButton()
        button.setTitle("Войти", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 18, weight: .bold)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = CustomColors.blackBrown
        button.layer.cornerRadius = 25
        button.addTarget(self, action: #selector(loginAction), for: .touchUpInside)
        return button
    }()
    
    private lazy var registerButton: UIButton = {
        let button  = UIButton()
        button.setTitle("Создать аккаунт", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 18, weight: .bold)
        button.setTitleColor(CustomColors.blackBrown, for: .normal)
        button.backgroundColor = .clear
        button.layer.cornerRadius = 25
        button.layer.borderWidth = 1
        button.layer.borderColor = CustomColors.blackBrown.cgColor
        button.addTarget(self, action: #selector(registerAction), for: .touchUpInside)
        return button
    }()
    
    
    var presenter: LoadingPresenter?
    private var typeLoginForm: LoaderType = .defaultType {
        didSet {
            loginFormView.updateLoginForm(with: self.typeLoginForm)
            updateLogRegButtons()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUP()
        addSubviews()
        setupConstraints()
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    
    @objc func loginAction(){
        guard typeLoginForm == .login else {
            typeLoginForm = .login
            return
        }
        
        guard let email = loginFormView.getEmail(),
              let password = loginFormView.getPassword()
        else {
            print("Email или password is empty")
            return
        }
        
        presenter?.loginAction(email: email, password: password)
    }
    
    @objc func registerAction(){
        guard typeLoginForm == .register else {
            typeLoginForm = .register
            return
        }
        guard let email = loginFormView.getEmail(),
              let password = loginFormView.getPassword(),
              let retryPassword = loginFormView.getRetryPassword(),
              password == retryPassword else {
            print("Passwords do not match")
            return
        }
        
        print(email ,password , retryPassword)
        presenter?.registrationAction(email: email, password: password)
    }
    
}

extension LoadingViewController:Designable{
    func setupUP() {
        //
    }
    
    func addSubviews() {
        [backgroundView,
         loginFormView,
         loginButton,
         registerButton,
        ].forEach(view.addSubview)
    }
    
    func setupConstraints() {
        backgroundView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        loginFormView.snp.makeConstraints { make in
            make.top.equalTo(view.snp.centerY).offset(-100)
            make.leading.trailing.equalToSuperview().inset(20)
            make.bottom.equalTo(loginButton.snp.top).offset(-30)
            make.height.greaterThanOrEqualTo(250) 
        }
        
        loginButton.snp.makeConstraints { make in
            make.bottom.equalTo(registerButton.snp.top).offset(-10)
            make.leading.trailing.equalToSuperview().inset(20)
            make.height.equalTo(50)
        }
        
        registerButton.snp.makeConstraints { make in
            make.bottom.equalTo(view.safeAreaLayoutGuide).inset(20)
            make.leading.trailing.equalToSuperview().inset(20)
            make.height.equalTo(50)
        }
    }
}


extension LoadingViewController{
    @objc func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            self.view.frame.origin.y = -keyboardSize.height / 2
        }
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        self.view.frame.origin.y = 0
    }
    
    func updateLogRegButtons() {
        switch typeLoginForm {
        case .defaultType: break;
        case .login:
            UIView.animate(withDuration: 0.3) {
                self.loginButton.transform = .init(scaleX: 1, y: 1)
                self.registerButton.transform = .init(scaleX: 0.8, y: 0.8)
                self.view.layoutIfNeeded()
            }
            
        case .register:
            UIView.animate(withDuration: 0.3) {
                self.registerButton.transform = .init(scaleX: 1, y: 1)
                self.loginButton.transform = .init(scaleX: 0.8, y: 0.8)
                self.view.layoutIfNeeded()
            }
        }
    }
    
    
}
