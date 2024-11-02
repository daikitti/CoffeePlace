//
//  LoginForm.swift
//  CoffeePlaceApp
//
//  Created by Havydope Diii on 31.10.2024.
//

import UIKit



class LoginFormView: UIView {
    
    private let previewView: PreviewAuth = {
        let view = PreviewAuth()
        return view
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Авторизация"
        label.font = .systemFont(ofSize: 25, weight: .bold)
        label.textColor = CustomColors.blackBrown
        label.textAlignment = .center
        return label
    }()
    
    private let emailLabel: UILabel = {
        let label = UILabel()
        label.text = "Email"
        label.font = .systemFont(ofSize: 20, weight: .semibold)
        label.textColor = CustomColors.blackBrown
        label.textAlignment = .left
        return label
    }()
    
    private lazy var emailTextField: CustomTextField = {
        let textField = CustomTextField(placeholder: "nikita.ziganshin.2001@mail.ru", type: .email)
        return textField
    }()
    
    private let passwordLabel: UILabel = {
        let label = UILabel()
        label.text = "Пароль"
        label.font = .systemFont(ofSize: 20, weight: .semibold)
        label.textColor = CustomColors.blackBrown
        label.textAlignment = .left
        return label
    }()
    
    private let passwordTextField: CustomTextField = {
        let textField = CustomTextField(placeholder: "***", type: .password)
        return textField
    }()
    
    private let retryPasswordLabel: UILabel = {
        let label = UILabel()
        label.text = "Повторите пароль"
        label.font = .systemFont(ofSize: 20, weight: .semibold)
        label.textColor = CustomColors.blackBrown
        label.textAlignment = .left
        return label
    }()
    
    private let retryPasswordTextField: CustomTextField = {
        let textField = CustomTextField(placeholder: "***", type: .password)
        return textField
    }()
    
    override init(frame: CGRect) {
        super .init(frame: .zero)
        setupUP()
        addSubviews()
        setupConstraints()
        updateLoginForm(with: .defaultType)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func updateLoginForm(with type: LoaderType) {
        previewView.isHidden = (type != .defaultType)
        titleLabel.isHidden = (type == .defaultType)
        emailLabel.isHidden = (type == .defaultType)
        emailTextField.isHidden = (type == .defaultType)
        passwordLabel.isHidden = (type == .defaultType)
        passwordTextField.isHidden = (type == .defaultType)
        retryPasswordLabel.isHidden = (type != .register)
        retryPasswordTextField.isHidden = (type != .register)
        
        switch type {
        case .defaultType:
            break
        case .login:
            titleLabel.text = "Авторизация"
        case .register:
            titleLabel.text = "Регистрация"
        }
        
        UIView.animate(withDuration: 1.0, animations: {
            self.layoutIfNeeded()
        })
    }
    
}

extension LoginFormView: Designable{
    func setupUP() {
    }
    
    func addSubviews() {
        [   previewView,
            titleLabel,
            emailLabel,emailTextField,
            passwordLabel, passwordTextField,
            retryPasswordLabel, retryPasswordTextField
        ].forEach(self.addSubview)
    }
    
    func setupConstraints() {
        previewView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        titleLabel.snp.makeConstraints { make in
            make.leading.top.trailing.equalToSuperview().inset(10)
        }
        
        //Email
        emailLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(10)
            make.leading.trailing.equalToSuperview().inset(10)
        }
        
        emailTextField.snp.makeConstraints { make in
            make.top.equalTo(emailLabel.snp.bottom).offset(5)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(50)
        }
        
        //Password
        passwordLabel.snp.makeConstraints { make in
            make.top.equalTo(emailTextField.snp.bottom).offset(10)
            make.leading.trailing.equalToSuperview().inset(10)
            
        }
        
        passwordTextField.snp.makeConstraints { make in
            make.top.equalTo(passwordLabel.snp.bottom).offset(5)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(emailTextField)
        }
        
        //Retry Password
        retryPasswordLabel.snp.makeConstraints { make in
            make.top.equalTo(passwordTextField.snp.bottom).offset(10)
            make.leading.trailing.equalToSuperview().inset(10)
        }
        
        retryPasswordTextField.snp.makeConstraints { make in
            make.top.equalTo(retryPasswordLabel.snp.bottom).offset(5)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(emailTextField)
        }
    }
}

extension LoginFormView {
    func getEmail() -> String? {
        return emailTextField.customTextField.text
    }

    func getPassword() -> String? {
        return passwordTextField.customTextField.text
    }

    func getRetryPassword() -> String? {
        return retryPasswordTextField.customTextField.text
    }
}
