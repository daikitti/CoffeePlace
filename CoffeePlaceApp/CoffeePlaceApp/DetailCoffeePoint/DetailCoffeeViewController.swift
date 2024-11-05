//
//  DetailCoffeeViewController.swift
//  CoffeePlaceApp
//
//  Created by Havydope Diii on 02.11.2024.
//

import UIKit

class DetailCoffeeViewController: UIViewController {
    
    private lazy var titleLabel:UILabel = {
        let label = UILabel()
        label.text = ""
        label.font = .systemFont(ofSize: 25, weight: .bold)
        label.textAlignment = .left
        label.numberOfLines = 2
        label.textColor = CustomColors.blackBrown
        return label
    }()
    
    private lazy var backButton : UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "backButton"), for: .normal)
        button.addTarget(self, action: #selector(goBack), for: .touchUpInside)
        return button
    }()
    
    private lazy var menuCollection:UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let inset = 20
        layout.sectionInset = UIEdgeInsets(top: 20, left: CGFloat(inset), bottom: 0, right: CGFloat(inset))
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing =  10
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = .clear
        collectionView.showsVerticalScrollIndicator = false
        collectionView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        collectionView.register(MenuItemCell.self, forCellWithReuseIdentifier: MenuItemCell.CellID)
        return collectionView
    }()
    
    private lazy var bottomConteynir:UIView = {
        let view = UIView()
        return view
    }()
    
    private lazy var priceTtile:CustomPriceForm = {
        let view = CustomPriceForm()
        return view
    }()
    
    private lazy var goPayButton:UIButton = {
        let button = UIButton()
        button.setTitle("Перейти к оплате", for: .normal)
        button.setTitleColor(CustomColors.blackBrown, for: .normal)
        button.backgroundColor = .clear
        button.layer.borderColor = CustomColors.blackBrown.cgColor
        button.layer.borderWidth = 2
        button.layer.cornerRadius = 25
        button.addTarget(self, action: #selector(goPayOrder), for: .touchUpInside)
        return button
    }()
    
    
    
    var MenuCoffee: [MenuItem]?
    var presenter: DetailCoffeePresenter?
    var cart: [MenuItem: Int] = [:]
    
    override func viewDidLoad() {
        setupUP()
        addSubviews()
        setupConstraints()
        presenter?.fetchMenuItems()
    }
    
    @objc func goBack(){
        presenter?.goBack()
    }
    
    @objc func goPayOrder(){
        presenter?.goPayOrder(orderCart:self.cart)
    }
}

extension DetailCoffeeViewController: Designable{
    func setupUP() {
        view.backgroundColor = CustomColors.whiteBrown
    }
    
    func addSubviews() {
        [titleLabel,
         backButton,
         menuCollection,
         bottomConteynir].forEach(view.addSubview)
        
        bottomConteynir.addSubview(priceTtile)
        bottomConteynir.addSubview(goPayButton)
        
    }
    
    func setupConstraints() {
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).inset(20)
            make.centerX.equalToSuperview()
        }
        
        backButton.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(20)
            make.centerY.equalTo(titleLabel)
            make.height.width.equalTo(45)
        }
        
        menuCollection.snp.makeConstraints { make in
            make.top.equalTo(titleLabel).offset(40)
            make.leading.trailing.equalToSuperview()
            make.bottom.equalTo(bottomConteynir.snp.top)
        }
        
        bottomConteynir.snp.makeConstraints { make in
            make.leading.trailing.bottom.equalToSuperview()
            make.height.equalTo(100)
        }
        
        priceTtile.snp.makeConstraints { make in
            make.leading.top.equalTo(bottomConteynir).inset(15)
            make.height.equalTo(50)
            make.width.equalTo(80)
        }
        
        goPayButton.snp.makeConstraints { make in
            make.centerY.equalTo(priceTtile)
            make.leading.equalTo(priceTtile.snp.trailing).offset(10)
            make.trailing.equalTo(bottomConteynir).inset(10)
            make.height.equalTo(priceTtile)
        }
    }    
}

extension DetailCoffeeViewController : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return MenuCoffee?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MenuItemCell.CellID, for: indexPath) as! MenuItemCell
        guard let menuItem = MenuCoffee?[indexPath.row] else { return cell }
        cell.configurate(with: menuItem)
        cell.delegate = self
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = view.frame.width / 2.3
        let height = width * 1.5
        return CGSize(width: width, height: height)
    }
    
}

extension DetailCoffeeViewController{
    func reloadView(coffePoint: [MenuItem]){
        self.MenuCoffee = coffePoint
        titleLabel.text = presenter?.coffeePoint.name
        menuCollection.reloadData()
    }
}
extension DetailCoffeeViewController: MenuItemCellDelegate {
    func addToPay(item: MenuItem) {
        if let count = cart[item] {
            cart[item] = count + 1
        } else {
            cart[item] = 1
        }
        updateTotalPrice()
    }
    
    func deleteToPay(item: MenuItem) {
        if let count = cart[item], count > 1 {
            cart[item] = count - 1
        } else {
            cart.removeValue(forKey: item)
        }
        
        updateTotalPrice()
    }
    
    private func updateTotalPrice() {
        let totalPrice = cart.reduce(0) { result, dictItem in
            let (menuItem, itemCount) = dictItem
            return result + (menuItem.price * itemCount)
        }
        priceTtile.updatePrice(price: String(totalPrice))
        goPayButton.switchEnable(totalPrice: totalPrice)
        goPayButton.isEnabled = (totalPrice != 0)
    }
}


