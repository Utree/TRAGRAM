//
//  HomeViewController.swift
//  jphacks
//
//  Created by sekiya on 2019/10/19.
//  Copyright © 2019 sekiya. All rights reserved.
//

import UIKit
import Nuke
import Alamofire

//struct Res:Codable {
//    let name: String
//    let discription: String
//    let image_path: String
//}

class HomeViewController: UIViewController {
    @IBOutlet weak var flowLayout: UICollectionViewFlowLayout!
    @IBOutlet weak var collectionView: UICollectionView!
    
    //    データ
    var items = [Item(id:1,user_id:1,date:"2019-10-20T12:35:36.471362+09:00",text:"ぽーとたわー",img_url:"http://localhost:8000/media/api_v1/images/photo-1548712637-033b00ef9b4a.jpeg",map_lat:"34.6825550000",map_lon:"135.1866900000",like_cnt:0), Item(id:2,user_id:1,date:"2019-10-20T12:37:55.088348+09:00",text:"夜景　海",img_url:"http://localhost:8000/media/api_v1/images/photo-1559480671-4577ba1ea77b.jpeg",map_lat:"34.6730290000",map_lon:"135.2024280000",like_cnt:3)]
    
    var users = [User(account_name:"apple",password:"apple"), User(account_name:"aaaaaa",password:"aaaaaa"), User(account_name:"bbbbbbb",password:"bbbbbbb"), User(account_name:"cccccc",password:"ccccccc")]
    
    var selectedItemIndex = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        Alamofire.request("http://34.203.188.126:8000/v1/user/").response { response in
            let decoder = JSONDecoder()
            
            guard let data = response.data else { return }
            // json parse
            do {
                self.users = try decoder.decode([User].self, from: data)
            } catch {
                print(error)
            }

        }
        
        Alamofire.request("http://localhost:8000/v1/post/").response { response in
            let decoder = JSONDecoder()
            
            guard let data = response.data else { return }
        //            Jsonのパース
            do {
                self.items = try decoder.decode([Item].self, from: data)
                
                // データ更新
                self.collectionView.reloadData()
            } catch {
                print(error)
            }
        }

        // Do any additional setup after loading the view.
        collectionView.delegate = self
        collectionView.dataSource = self
        // スクロールを禁止
//        collectionView.isScrollEnabled = false
        
        // 横方向に並べていく
        flowLayout.scrollDirection = .vertical
        // 空白をなくす
        flowLayout.minimumLineSpacing = 0
        flowLayout.minimumInteritemSpacing = 0
        flowLayout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        
        // xibを登録
        let inib = UINib(nibName: "CollectionItem", bundle: nil)
        collectionView!.register(inib, forCellWithReuseIdentifier: "collectionItem")
        let mnib = UINib(nibName: "MapCollectionViewCell", bundle: nil)
        collectionView!.register(mnib, forCellWithReuseIdentifier: "mapCollectionItem")
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension HomeViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    /*
     * cellの個数
     */
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count+1
    }
    
    /*
     * 見た目の設定
     */
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.row == 0 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "mapCollectionItem", for: indexPath) as! MapCollectionViewCell
            
            // ピンを刺す
            for item in items {
                cell.addPin(lat: Double(item.map_lat)!, long: Double(item.map_lon)!, title: item.text)
            }
            
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "collectionItem", for: indexPath) as! ItemCollectionViewCell
            
            // 画像を設定
            Nuke.loadImage(with: URL(string: items[indexPath.row-1].img_url)!, into: cell.ImageItem)
            return cell
        }
    }
    
    /*
     * 押下時の処理
     */
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectedItemIndex = indexPath.row-1
        
        if indexPath.row != 0 {
            self.performSegue(withIdentifier: "showDetailSegue", sender: nil)
        }
    }
    
    /*
     * サイズを変更
     */
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if indexPath.row == 0 {
            return CGSize(width: 414.0, height: 500.0)
        } else {
            return CGSize(width: 207.0, height: 200.0)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        // ②Segueの識別子確認
        if segue.identifier == "showDetailSegue" {
            
            // ③遷移先ViewCntrollerの取得
            let nextView = segue.destination as! DetailViewController
        
            // ④値の設定
            nextView.Name = users[items[selectedItemIndex].user_id-1].account_name
            nextView.imagePath = items[selectedItemIndex].img_url
            nextView.descrip = items[selectedItemIndex].text
        }
    }
    
}
