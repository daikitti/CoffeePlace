//
//  OrderCell.swift
//  CoffeePlaceApp
//
//  Created by Havydope Diii on 03.11.2024.
//

import UIKit

protocol OrderCellDelegate {
    func addToPay(item:MenuItem)
    func deleteToPay(item:MenuItem)
}

//MARK: ячейка для выбранных товаров
class OrderCell: UICollectionViewCell {
    
    static let CellID = "OrderCell"
    
    private lazy var conteynirView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 25
        view.clipsToBounds = true
        return view
    }()
    
    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.text  = " "
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
    
    private lazy var priceLabel: UILabel = {
        let label = UILabel()
        label.text  = "500р"
        label.font = .systemFont(ofSize: 17, weight: .semibold)
        label.textColor = CustomColors.blackBrown
        label.textAlignment = .center
        return label
    }()
    
    private lazy var loader: UIActivityIndicatorView = {
        let view = UIActivityIndicatorView()
        view.color = CustomColors.blackBrown
        view.style = .medium
        view.hidesWhenStopped = true
        return view
    }()
    
    private lazy var addButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "addbutton"), for: .normal)
        button.addTarget(self, action: #selector(addButtonTapped), for: .touchUpInside)
        return button
    }()
    
    private lazy var deleteButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "deleteButton"), for: .normal)
        button.addTarget(self, action: #selector(deleteButtonTapped), for: .touchUpInside)
        return button
    }()
    
    private lazy var countPay : UILabel = {
        let label = UILabel()
        label.text = "0"
        label.font = .systemFont(ofSize: 16, weight: .regular)
        label.textColor = CustomColors.blackBrown
        label.textAlignment = .center
        return label
    }()
    
    var menuItem: MenuItem?
    var delegate: OrderCellDelegate?
    var count = 0{
        didSet{
            countPay.text = "\(count)x"
        }
    }
    override init(frame: CGRect) {
        super.init(frame: .zero)
        setupUP()
        addSubviews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configurate(with menuItem: MenuItem, count: Int) {
        self.menuItem = menuItem
        self.count = count
        coffeImage.setImage(from: menuItem.imageURL, withLoader: loader)
        nameLabel.text = menuItem.name
        priceLabel.text = "\(menuItem.price) р."
    }
    
    @objc func addButtonTapped() {
        guard let item = menuItem, count < 10 else {return}
        count += 1
        delegate?.addToPay(item: item)
    }
    
    @objc func deleteButtonTapped() {
        guard let item = menuItem , count >= 1 else {return}
        count -= 1
        delegate?.deleteToPay(item: item)
    }
    
}

extension OrderCell:Designable{
    func setupUP() {
        //
    }
    
    func addSubviews() {
        self.addSubview(conteynirView)
        
        [
            nameLabel,
            priceLabel,
            deleteButton,
            countPay,
            addButton,
            coffeImage,
            loader
        ].forEach(self.conteynirView.addSubview)
    }
    
    func setupConstraints() {
        conteynirView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        nameLabel.snp.makeConstraints { make in
            make.top.leading.equalTo(conteynirView).inset(20)
            make.trailing.equalTo(priceLabel.snp.leading).offset(10)
        }
        
        priceLabel.snp.makeConstraints { make in
            make.centerY.equalTo(nameLabel)
            make.trailing.equalTo(coffeImage.snp.leading).offset(-20)
            make.width.equalTo(80)
        }
        
        deleteButton.snp.makeConstraints { make in
            make.bottom.leading.equalTo(conteynirView).inset(5)
            make.height.width.equalTo(50)
        }
        countPay.snp.makeConstraints { make in
            make.leading.equalTo(deleteButton.snp.trailing).inset(5)
            make.centerY.equalTo(deleteButton)
            make.height.width.equalTo(50)
        }
        
        addButton.snp.makeConstraints { make in
            make.leading.equalTo(countPay.snp.trailing).inset(5)
            make.centerY.equalTo(deleteButton)
            make.height.width.equalTo(50)
        }
        
        coffeImage.snp.makeConstraints { make in
            make.bottom.trailing.top.equalTo(conteynirView).inset(5)
            make.width.equalTo(coffeImage.snp.height).multipliedBy(0.8)
        }
        
        loader.snp.makeConstraints { make in
            make.edges.equalTo(coffeImage)
        }
    }
}
