//
//  PreviewAuth.swift
//  CoffeePlaceApp
//
//  Created by Havydope Diii on 31.10.2024.
//

import UIKit


class PreviewAuth: UIView {
    private lazy var dayLabel: UILabel = {
        let label = UILabel()
        label.text = "Espresso - жизнь,\nа ты в ней буква 'K'"
        label.font = .systemFont(ofSize: 36 , weight: .bold)
        label.textColor = CustomColors.blackBrown
        label.numberOfLines = 3
        return label
    }()
    
    private lazy var studioLabel: UILabel = {
        let label = UILabel()
        label.text = "Seven Winds Coffee"
        label.font = .systemFont(ofSize: 15 , weight: .bold)
        label.textColor = CustomColors.blackBrown
        label.numberOfLines = 1
        return label
    }()
    
    override init(frame: CGRect) {
        super .init(frame: .zero)
        setupUP()
        addSubviews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension PreviewAuth:Designable{
    func setupUP() {
        //
    }
    
    func addSubviews() {
        [dayLabel,
         studioLabel].forEach(self.addSubview)
    }
    
    func setupConstraints() {
        dayLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview().offset(-80)
            make.leading.trailing.equalToSuperview().offset(20)
        }
        
        studioLabel.snp.makeConstraints { make in
            make.top.equalTo(dayLabel.snp.bottom).offset(20)
            make.trailing.equalToSuperview().inset(20)
        }
    }
    
}
