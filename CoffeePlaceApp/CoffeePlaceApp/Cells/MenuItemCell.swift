//
//  MenuItemCell.swift
//  CoffeePlaceApp
//
//  Created by Havydope Diii on 02.11.2024.
//

import UIKit


protocol MenuItemCellDelegate {
    func addToPay(item:MenuItem)
    func deleteToPay(item:MenuItem)
}

//MARK: ячейка для объекта в меню кофе-точки
class MenuItemCell: UICollectionViewCell{
    static let CellID = "MenuItemCell"
    
    private lazy var conteynirView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 15
        view.clipsToBounds = true
        return view
    }()
    
    private lazy var menuImage : UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFill
        return view
    }()
    
    private lazy var menuTitle : UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .regular)
        label.textColor = CustomColors.blackBrown
        label.textAlignment = .left
        return label
    }()
    
    private lazy var priceTitle : UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .medium)
        label.textColor = CustomColors.blackBrown
        label.textAlignment = .left
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
    
    var menuItem:MenuItem?
    var delegate:MenuItemCellDelegate?
    var count = 0{
        didSet{
            countPay.text = "\(count)"
            
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
    
    func configurate(with model: MenuItem) {
        self.menuItem = model
        menuImage.setImage(from: model.imageURL, withLoader: loader)
        menuTitle.text = model.name
        priceTitle.text = "\(model.price) р."
    }
    
    @objc func addButtonTapped() {
        guard let item = menuItem, count < 10 else {return}
        count += 1
        delegate?.addToPay(item: item)
    }
    @objc func deleteButtonTapped() {
        guard let item = menuItem , count > 0 else {return}
        count -= 1
        delegate?.deleteToPay(item: item)
    }
    
}
extension MenuItemCell: Designable{
    func setupUP() {
    }
    
    func addSubviews() {
        self.addSubview(conteynirView)
        [menuImage,
         menuTitle,
         priceTitle,
         addButton,
         deleteButton,
         countPay,
         loader].forEach(conteynirView.addSubview)
        
    }
    
    func setupConstraints() {
        conteynirView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        menuImage.snp.makeConstraints { make in
            make.top.leading.trailing.equalTo(conteynirView)
            make.height.equalTo(menuImage.snp.width).multipliedBy(1.1)
        }
        
        menuTitle.snp.makeConstraints { make in
            make.top.equalTo(menuImage.snp.bottom).offset(10)
            make.leading.trailing.equalTo(conteynirView).inset(8)
        }
        
        priceTitle.snp.makeConstraints { make in
            make.top.equalTo(menuTitle.snp.bottom).offset(10)
            make.leading.equalTo(conteynirView).inset(8)
        }
        
        addButton.snp.makeConstraints { make in
            make.bottom.trailing.equalTo(conteynirView).inset(5)
            make.height.width.equalTo(30)
        }
        
        countPay.snp.makeConstraints { make in
            make.trailing.equalTo(addButton.snp.leading).inset(5)
            make.centerY.equalTo(addButton)
            make.width.equalTo(40)
        }
        
        deleteButton.snp.makeConstraints { make in
            make.trailing.equalTo(countPay.snp.leading).inset(5)
            make.height.width.centerY.equalTo(addButton)
        }
        
        loader.snp.makeConstraints { make in
            make.edges.equalTo(menuImage)
        }
    }
}
