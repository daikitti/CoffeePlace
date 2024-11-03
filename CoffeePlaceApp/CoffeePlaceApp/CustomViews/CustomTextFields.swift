//
//  CustomTextFields.swift
//  CoffeePlaceApp
//
//  Created by Havydope Diii on 01.11.2024.
//

import UIKit

enum textType{
    case email
    case password
}

class CustomTextField: UIView {
    
    private let backgroundView: UIView = {
        let view = UIView()
        view.backgroundColor = CustomColors.whiteBrown
        view.layer.cornerRadius = 15
        return view
    }()
    
    lazy var customTextField: UITextField = {
        let textField = UITextField()
        textField.font = .systemFont(ofSize: 15, weight: .semibold)
        textField.textColor = CustomColors.blackBrown
        textField.attributedPlaceholder = NSAttributedString(
            string: "",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.gray]
        )
        textField.delegate = self
        return textField
    }()
    
    
    private let separatorView: UIView = {
        let view = UIView()
        view.backgroundColor = CustomColors.blackBrown
        view.isHidden = true
        return view
    }()
    
    init(placeholder: String, type: textType ) {
        super.init(frame: .zero)
        addSubviews()
        setupConstraints()
        updateTextField(placeholder: placeholder, type: type)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


extension CustomTextField: Designable{
    func setupUP() {
        //
    }
    
    func addSubviews() {
        self.addSubview(backgroundView)
        
        [
            customTextField,
            separatorView
        ].forEach(self.backgroundView.addSubview)
    }
    
    func setupConstraints() {
        backgroundView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        customTextField.snp.makeConstraints { make in
            make.top.leading.trailing.equalTo(backgroundView).inset(10)
            make.bottom.equalTo(separatorView.snp.top).offset(-3)
        }
        
        separatorView.snp.makeConstraints { make in
            make.bottom.equalTo(backgroundView).inset(5)
            make.leading.trailing.equalTo(customTextField)
            make.height.equalTo(2)
        }
    }
    
    func updateTextField(placeholder: String, type: textType){
        
        switch type {
        case .email:
            self.customTextField.attributedPlaceholder = NSAttributedString(string: placeholder, attributes: [.foregroundColor: UIColor.lightGray])
            customTextField.keyboardType = .emailAddress
        case .password:
            customTextField.attributedPlaceholder = NSAttributedString(string: "****", attributes: [.foregroundColor: UIColor.lightGray])
            customTextField.isSecureTextEntry = true
            
        }
    }
    
}


extension CustomTextField: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder() // Закрываем клавиатуру
        return true
    }
}
