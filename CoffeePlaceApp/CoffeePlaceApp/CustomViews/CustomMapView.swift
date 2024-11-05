//
//  CustomMapView.swift
//  CoffeePlaceApp
//
//  Created by Havydope Diii on 03.11.2024.
//
import UIKit
import YandexMapsMobile

protocol MapViewDelegate{
    func tappToMapMark(to point: CoffePoint)
}

class CustomMapView: UIView {
    
    private var mapViewConteynyr: YMKMapView = YMKMapView()
    
    // Кнопка для приближения
    private lazy var zoomInButton: UIButton = {
        let button = UIButton()
        button.setTitle("+", for: .normal)
        button.backgroundColor = UIColor.white
        button.setTitleColor(.black, for: .normal)
        button.layer.cornerRadius = 25
        button.layer.borderWidth = 1
        button.addTarget(self, action: #selector(zoomIn), for: .touchUpInside)
        return button
    }()
    
    // Кнопка для отдаления
    private lazy var zoomOutButton: UIButton = {
        let button = UIButton()
        button.setTitle("-", for: .normal)
        button.backgroundColor = .white
        button.setTitleColor(.black, for: .normal)
        button.layer.borderWidth = 1
        button.layer.cornerRadius = 25
        button.addTarget(self, action: #selector(zoomOut), for: .touchUpInside)
        return button
    }()
    
    
    var delegate: MapViewDelegate?
    override init(frame: CGRect) {
        super.init(frame: .zero)
        setupUP()
        addSubviews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupMapView(with points: [CoffePoint]) {
        let map = mapViewConteynyr.mapWindow.map
        let mapObjects = map.mapObjects
        
        guard !points.isEmpty else { return }
        
        for point in points {
            let coffeeMarker = mapObjects.addPlacemark()
            let location = YMKPoint(latitude: Double(point.point.latitude)!, longitude: Double(point.point.longitude)!)
            coffeeMarker.geometry = location
            coffeeMarker.setIconWith(UIImage(named: "coffepoinMArker")!)
            coffeeMarker.setTextWithText(point.name, style: YMKTextStyle(size: 15,
                                                                         color: CustomColors.whiteBrown,
                                                                         outlineWidth: 2,
                                                                         outlineColor: CustomColors.blackBrown,
                                                                         placement: .bottom,
                                                                         offset: 5,
                                                                         offsetFromIcon: true,
                                                                         textOptional: false))
            
            coffeeMarker.addTapListener(with: self)
            coffeeMarker.userData = point
        }
        
        
        // Устанавливаем камеру на первую кофе-точку
        let firstPoint = points[0]
        let initialLocation = YMKPoint(latitude: Double(firstPoint.point.latitude)!, longitude: Double(firstPoint.point.longitude)!)
        let cameraPosition = YMKCameraPosition(target: initialLocation, zoom: 8, azimuth: 0, tilt: 0)
        map.move(with: cameraPosition, animation: YMKAnimation(type: .linear, duration: 1))
    }
    
    // MARK: - Actions
    
    @objc private func zoomIn() {
        let map = mapViewConteynyr.mapWindow.map
        map.move(with: YMKCameraPosition(target: map.cameraPosition.target, zoom: map.cameraPosition.zoom +  1, azimuth: 0, tilt: 0), animation: YMKAnimation(type: .smooth, duration: 1))
    }
    
    @objc private func zoomOut() {
        let map = mapViewConteynyr.mapWindow.map
        map.move(with: YMKCameraPosition(target: map.cameraPosition.target, zoom: map.cameraPosition.zoom - 1, azimuth: 0, tilt: 0), animation: YMKAnimation(type: .smooth, duration: 1))
    }
    
    
}

extension CustomMapView: Designable {
    func setupUP() {
        //
    }
    
    func addSubviews() {
        self.addSubview(mapViewConteynyr)
        self.addSubview(zoomInButton)
        self.addSubview(zoomOutButton)
    }
    
    func setupConstraints() {
        mapViewConteynyr.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        zoomInButton.snp.makeConstraints { make in
            make.centerY.trailing.equalToSuperview().inset(20)
            make.width.height.equalTo(50)
        }
        
        zoomOutButton.snp.makeConstraints { make in
            make.top.equalTo(zoomInButton.snp.bottom).offset(10)
            make.centerX.equalTo(zoomInButton)
            make.width.height.equalTo(50)
        }
    }
}

extension CustomMapView:YMKMapObjectTapListener{
    func onMapObjectTap(with mapObject: YMKMapObject, point: YMKPoint) -> Bool {
        if let coffeePoint = mapObject.userData as? CoffePoint {
            //тап по маркеру
            delegate?.tappToMapMark(to: coffeePoint)
        }
        return true
    }
    
    
}
