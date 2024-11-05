//
//  OrderViewController.swift
//  CoffeePlaceApp
//
//  Created by Havydope Diii on 03.11.2024.
//

import UIKit

class OrderViewController: UIViewController {
    
    private lazy var titleLabel:UILabel = {
        let label = UILabel()
        label.text = "Ваш заказ"
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
    
    private lazy var orderCollection:UICollectionView = {
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
        collectionView.register(OrderCell.self, forCellWithReuseIdentifier: OrderCell.CellID)
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
        button.setTitle("Оплатить", for: .normal)
        button.setTitleColor(CustomColors.whiteBrown, for: .normal)
        button.backgroundColor = CustomColors.green
        button.layer.cornerRadius = 25
        return button
    }()
    
    var orderCart: [(MenuItem, Int)] = []{
        didSet{
            checkOrderCart()
            updateTotalPrice()
        }
    }
    var presenter: OrderPresenter?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUP()
        addSubviews()
        setupConstraints()
    }
    
    
    @objc func goBack(){
        presenter?.goBack()
    }
}


extension OrderViewController: Designable{
    func setupUP() {
        view.backgroundColor = CustomColors.whiteBrown
        if let orderCart = presenter?.cardOrder {
            self.orderCart = Array(orderCart)
        }
    }
    
    func addSubviews() {
        [titleLabel,
         backButton,
         orderCollection,
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
        
        orderCollection.snp.makeConstraints { make in
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

extension OrderViewController : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return orderCart.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: OrderCell.CellID, for: indexPath) as! OrderCell
        let order = orderCart[indexPath.row]
        cell.configurate(with: order.0, count: order.1)
        cell.delegate = self
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.frame.width * 0.9
        let height = collectionView.frame.height / 5
        return CGSize(width: width, height: height)
    }
    
}


extension OrderViewController:OrderCellDelegate{
    func addToPay(item: MenuItem) {
        if let index = orderCart.firstIndex(where: { $0.0.id == item.id }) {
            orderCart[index].1 += 1
        }
        updateTotalPrice()
    }
    
    func deleteToPay(item: MenuItem) {
        if let index = orderCart.firstIndex(where: { $0.0.id == item.id }) {
            if orderCart[index].1 > 1 {
                orderCart[index].1 -= 1  
            } else {
                orderCart.remove(at: index)  // Удаляем товар, если количество становится 0
                orderCollection.deleteItems(at: [IndexPath(row: index, section: 0)]) // Удаляем ячейку
            }
        }
        updateTotalPrice()
        
    }
    
    
    private func updateTotalPrice() {
        let totalPrice = orderCart.reduce(0) { result, dictItem in
            let (menuItem, itemCount) = dictItem
            return result + (menuItem.price * itemCount)
        }
        priceTtile.updatePrice(price: String(totalPrice))
    }
    
    private func checkOrderCart() {
        if orderCart.isEmpty {
            presenter?.goBack()
        }
    }
}
