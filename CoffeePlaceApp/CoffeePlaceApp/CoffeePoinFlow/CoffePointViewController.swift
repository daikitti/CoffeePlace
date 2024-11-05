//
//  CoffePointViewController.swift
//  CoffeePlaceApp
//
//  Created by Havydope Diii on 01.11.2024.
//


import UIKit

protocol CoffePointProtocol{
    func reload(with data: [CoffePoint])
}

class CoffePointViewController:UIViewController{
    
    private lazy var titleLabel:UILabel = {
        let label = UILabel()
        label.text = "Ближайшие \nкофейни"
        label.font = .systemFont(ofSize: 25, weight: .bold)
        label.textAlignment = .left
        label.numberOfLines = 2
        label.textColor = CustomColors.blackBrown
        return label
    }()
    
    private lazy var listButton:UIButton = {
        let button = UIButton()
        button.setTitle("Списком", for: .normal)
        button.setTitleColor(CustomColors.whiteBrown, for: .normal)
        button.backgroundColor = CustomColors.blackBrown
        button.layer.cornerRadius = 20
        button.addTarget(self, action: #selector(listButtonTapped), for: .touchUpInside)
        return button
    }()
    
    private lazy var mapButton:UIButton = {
        let button = UIButton()
        button.setTitle("На картe", for: .normal)
        button.setTitleColor(CustomColors.blackBrown, for: .normal)
        button.backgroundColor = .clear
        button.layer.cornerRadius = 20
        button.layer.borderWidth = 2
        button.layer.borderColor = CustomColors.blackBrown.cgColor
        button.addTarget(self, action: #selector(mapButtonTapped), for: .touchUpInside)
        return button
    }()
    
    private lazy var coffePointCollection:UICollectionView = {
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
        collectionView.register(CoffePointCell.self, forCellWithReuseIdentifier: CoffePointCell.CellID)
        collectionView.backgroundColor = CustomColors.blackBrown
        collectionView.isHidden = true
        return collectionView
    }()
    
    private lazy var mapView: CustomMapView = {
        let view = CustomMapView()
        view.isHidden = true
        view.delegate = self
        return view
    }()
    
    private lazy var Hstack: UIStackView = {
        let stack = UIStackView()
        stack.spacing = 10
        stack.axis = .horizontal
        stack.distribution = .fillProportionally
        return stack
    }()
    
    var coffeePoints:[CoffePoint]?
    var presenter: CoffePointPresenter?
    var isMapViewActive: Bool = false{
        didSet{
            updateView()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUP()
        addSubviews()
        setupConstraints()
    }
    
    
    @objc func mapButtonTapped() {
        isMapViewActive = true
        guard let points = coffeePoints else { return }
        mapView.setupMapView(with: points)
    }
    
    
    @objc func listButtonTapped() {
        guard isMapViewActive else { return }
        isMapViewActive = false
        
    }
    
    func updateView() {
        mapView.isHidden = !isMapViewActive
        coffePointCollection.isHidden = isMapViewActive
        switch isMapViewActive{
        case true:
            mapButton.switchEnable(totalPrice: 1)
            listButton.switchEnable(totalPrice: 0)
        case false:
            mapButton.switchEnable(totalPrice: 0)
            listButton.switchEnable(totalPrice: 1)
        }
        
        
    }
    
}
extension CoffePointViewController:Designable{
    func setupUP() {
        view.backgroundColor = CustomColors.whiteBrown
        presenter?.fetchLocations()
    }
    
    func addSubviews() {
        [titleLabel,
         Hstack,
         coffePointCollection,
         mapView
        ].forEach(view.addSubview)
        
        [listButton,
         mapButton].forEach(Hstack.addArrangedSubview)
    }
    
    func setupConstraints() {
        titleLabel.snp.makeConstraints { make in
            make.top.leading.equalTo(view.safeAreaLayoutGuide).inset(20)
        }
        
        Hstack.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(20)
            make.leading.trailing.equalToSuperview().inset(20)
            make.height.equalTo(40)
        }
        
        coffePointCollection.snp.makeConstraints { make in
            make.top.equalTo(Hstack.snp.bottom).offset(20)
            make.leading.trailing.bottom.equalToSuperview()
        }
        
        mapView.snp.makeConstraints { make in
            make.top.equalTo(Hstack.snp.bottom).offset(20)
            make.leading.trailing.bottom.equalToSuperview()
        }
        
        
    }
    
    
}

extension CoffePointViewController : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return coffeePoints?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CoffePointCell.CellID, for: indexPath) as! CoffePointCell
        guard let coffepoint = coffeePoints?[indexPath.row] else {return cell}
        cell.configurateCell(with: coffepoint)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.frame.width * 0.9
        let height = collectionView.frame.height / 5
        return CGSize(width: width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let pointItem = coffeePoints?[indexPath.row] else {return}
        presenter?.goDetail(point: pointItem)
    }
    
}

extension CoffePointViewController:CoffePointProtocol{
    func reload(with data: [CoffePoint]){
        self.coffeePoints = data
        self.coffePointCollection.reloadData()
        coffePointCollection.isHidden = false
    }
}

extension CoffePointViewController:MapViewDelegate {
    func tappToMapMark(to point: CoffePoint) {
        presenter?.goDetail(point: point)
    }
}


