//
//  MapCollectionViewCell.swift
//  jphacks
//
//  Created by sekiya on 2019/10/20.
//  Copyright © 2019 sekiya. All rights reserved.
//

import UIKit
import MapKit
//import CoreLocation

class MapCollectionViewCell: UICollectionViewCell, MKMapViewDelegate {
    
    @IBOutlet weak var mapView: MKMapView!
//    var locationManager : CLLocationManager!
    let DEBUG = true
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
//        // locationManager設定
//        locationManager = CLLocationManager()
//        guard let locationManager = locationManager else { return }
//        //　locationManagerの権限をviewControllerに渡す
//        locationManager.delegate = self as? CLLocationManagerDelegate
//        // アプリ利用時に位置情報を取得する
//        locationManager.requestWhenInUseAuthorization()
//        let status = CLLocationManager.authorizationStatus()
//        if status == .authorizedWhenInUse {
//            locationManager.distanceFilter = 10
//            locationManager.startUpdatingLocation()
//        }
        // map設定
        mapView.delegate = self
        
        // 表示領域を設定
        setMapArea(lat: 34.685219, long: 135.199402)
    }
        
        /*
         * 地図の表示領域を変更
         */
        func setMapArea(lat: Double, long: Double) {
            // mapの中心
            let mapCenter = CLLocationCoordinate2D(latitude: lat, longitude: long)
            // mapの範囲
            let mapSpan = MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
            // mapの表示領域
            let region = MKCoordinateRegion(center: mapCenter, span: mapSpan)
            // 表示領域を変更
            mapView.setRegion(region, animated: false)
        }
        
        /*
         * 地図上にピンを刺す
         */
        func addPin(lat: Double, long: Double, title: String) {
            let annotation = MKPointAnnotation()
            // ピンの位置
            let locationCoordinate = CLLocationCoordinate2D(latitude: lat, longitude: long)
            annotation.coordinate = locationCoordinate
            // ラベル
            annotation.title = title
            // ピンを追加
            mapView.addAnnotation(annotation)
        }
        
        /*
         * ピン押下時の処理
         */
        func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
            if let annotation = view.annotation {
                if let title = annotation.title! {
                    print("Tapped \(title) pin")
                }
            }
        }
    }

//    extension MapTableViewCell: CLLocationManagerDelegate {
//        /*
//         * 現在地取得の際に呼ばれる関数
//         */
//        func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
//            let location = locations.first
//            let lat = location?.coordinate.latitude ?? 35.7020691
//            let long = location?.coordinate.longitude ?? 139.7753269
//
//            // 現在地近辺を表示
//            if (DEBUG == true) {
//                setMapArea(lat: 35.6815014, long: 139.7636097)
//            } else {
//                setMapArea(lat: lat, long: long)
//            }
//        }
//    }
