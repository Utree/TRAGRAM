//
//  MapTableViewCell.swift
//  jphacks
//
//  Created by sekiya on 2019/10/19.
//  Copyright © 2019 sekiya. All rights reserved.
//

import UIKit
import MapKit

class MapTableViewCell: UITableViewCell, MKMapViewDelegate {

    @IBOutlet weak var map: MKMapView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        map.delegate = self
        
        // mapの中心
        let mapCenter = CLLocationCoordinate2D(latitude: 34.685219, longitude: 135.199402)
        // mapの範囲
        let mapSpan = MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
        // mapの表示領域
        let region = MKCoordinateRegion(center: mapCenter, span: mapSpan)
        // 表示領域を変更
        map.setRegion(region, animated: false)
        
        // ピンを刺す
        addPin()
    }
    
    /*
     * 地図上にピンを刺す
     */
    func addPin() {
        let annotation = MKPointAnnotation()
        // ピンの位置
        let locationCoordinate = CLLocationCoordinate2D(latitude: 34.685219, longitude: 135.199402)
        annotation.coordinate = locationCoordinate
        // ラベル
        annotation.title = "JPHACKS 神戸会場"
        // ピンを追加
        map.addAnnotation(annotation)
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

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
