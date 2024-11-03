//
//  CustomPriceForm.swift
//  CoffeePlaceApp
//
//  Created by Havydope Diii on 02.11.2024.
//

import UIKit

class CustomPriceForm: UIView{
    
    private lazy var conteynirView: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        view.clipsToBounds = true
        view.layer.cornerRadius = 25
        view.layer.borderWidth = 1
        view.layer.borderColor = CustomColors.blackBrown.cgColor
        return view
    }()
    
    
    private lazy var priceTitle: UILabel = {
        let label = UILabel()
        label.text = "0 p"
        label.textColor = CustomColors.blackBrown
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 16, weight: .regular)
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        setupUP()
        addSubviews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func updatePrice(price: String){
        priceTitle.text = price + " р"
    }
    
}
extension CustomPriceForm: Designable{
    func setupUP() {
    }
    
    func addSubviews() {
        self.addSubview(conteynirView)
        conteynirView.addSubview(priceTitle)
    }
    
    func setupConstraints() {
        conteynirView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        priceTitle.snp.makeConstraints { make in
            make.edges.equalTo(conteynirView).inset(5)
        }
    }
    
    
}
