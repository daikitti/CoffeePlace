//
//  CoffePointCell.swift
//  CoffeePlaceApp
//
//  Created by Havydope Diii on 02.11.2024.
//

import UIKit


class CoffePointCell: UICollectionViewCell {
    
    static let CellID = "CoffePointCell"
    private lazy var conteynirView: UIView = {
        let view = UIView()
        view.backgroundColor = CustomColors.whiteBrown
        view.layer.cornerRadius = 25
        view.clipsToBounds = true
        return view
    }()
    
    private lazy var distanceLabel: UILabel = {
        let label = UILabel()
        label.text  = "500 м от вас"
        label.font = .systemFont(ofSize: 13, weight: .regular)
        label.textColor = CustomColors.blackBrown
        label.textAlignment = .left
        return label
    }()
    
    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.text  = "COFFEE LIKE"
        label.font = .systemFont(ofSize: 23, weight: .bold)
        label.textColor = CustomColors.blackBrown
        label.textAlignment = .left
        label.numberOfLines = 2
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.8
        return label
    }()
    
    private lazy var coffeImage: UIImageView = {
    let imageView = UIImageView()
        imageView.image = UIImage(named: "testImage")
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 15
        imageView.clipsToBounds = true
        return imageView
    }()
    
    var coffePoint: CoffePoint?
    override init(frame: CGRect) {
        super.init(frame: .zero)
        setupUP()
        addSubviews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configurateCell(with coffePoint: CoffePoint) {
        self.coffePoint = coffePoint
        nameLabel.text = coffePoint.name
        distanceLabel.text = GpsManager.shared.getDistanceToPoint(point: coffePoint.point)
        coffeImage.image = UIImage(named: coffePoint.name)
    }
    
    
}

extension CoffePointCell: Designable{
    func setupUP() {
    }
    
    func addSubviews() {
        self.addSubview(conteynirView)

        [
            nameLabel,
            distanceLabel,
            coffeImage
        ].forEach(self.conteynirView.addSubview)
    }
    
    func setupConstraints() {
        conteynirView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    
        
        nameLabel.snp.makeConstraints { make in
            make.centerY.equalTo(conteynirView)
            make.leading.equalTo(conteynirView).inset(15)
            make.trailing.equalTo(coffeImage.snp.leading).offset(-10)
            make.height.equalTo(50)
        }
        
        distanceLabel.snp.makeConstraints { make in
            make.bottom.equalTo(nameLabel.snp.top).offset(0)
            make.leading.trailing.equalTo(nameLabel)
        }
        
        coffeImage.snp.makeConstraints { make in
            make.top.trailing.bottom.equalTo(conteynirView).inset(10)
            make.width.equalTo(coffeImage.snp.height).multipliedBy(0.9)
        }
    }    
}
