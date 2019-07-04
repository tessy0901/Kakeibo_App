//
//  ViewController.swift
//  kakeibo
//
//  Created by 手嶋慧太 on 2019/06/28.
//  Copyright © 2019 手嶋慧太. All rights reserved.
//

import UIKit

class firstViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    var productTitle:[String] = ["test1","test2","test3"]
    var productPrice:[String] = ["1114514","191980","364364"]
    
    @IBOutlet weak var productTable: UITableView!
    @IBAction func reloadButton(_ sender: Any) { productTable.reloadData() }
    //tableへの値の追加 or 編集
    @IBAction func GoTofirstVC(_ segue : UIStoryboardSegue){
        guard let imputsource = segue.source as? secondViewController else {
            fatalError()
        }
        guard let tableText = imputsource.productName!.text else { return  }
        guard let tablePrice = imputsource.productPrice!.text else { return  }
        if imputsource.firstViewIndexPath != nil{
            productTitle[imputsource.firstViewIndexPath] = tableText
            productPrice[imputsource.firstViewIndexPath] = tablePrice
        }else {
            productTitle.append(tableText)
            productPrice.append(tablePrice)
        }
        productTable.reloadData()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        productTable.delegate = self
        productTable.dataSource = self
        productTable.register(UINib(nibName: "productCell", bundle: nil), forCellReuseIdentifier: "productCell")
        
        //セルの編集buttonの追加
        self.navigationController?.isNavigationBarHidden = false
        navigationItem.leftBarButtonItem = editButtonItem
        
        productTable.reloadData()
        // Do any additional setup after loading the view.
    }
    
    //tableView類の設定
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return productPrice.count
    }
    //カスタムセルの類い
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "productCell",for: indexPath) as! productCell
        
        cell.productLabel.text = productTitle[indexPath.row]
        cell.priceLabel.text = "¥"+productPrice[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //tableView.deselectRow(at: indexPath, animated: true)
        print(indexPath.row)
        performSegue(withIdentifier: "ToSecondVC", sender: nil)
    }
    override func prepare(for segue:UIStoryboardSegue, sender:Any?){
        //print(segue.identifier)
        if segue.identifier == "ToSecondVC" {
            let thisViewCellIndexPath = productTable.indexPathForSelectedRow
            //インスタンス化
            let secondViewController = segue.destination as! secondViewController
            //print(thisViewCellIndexPath!.row)
            //print(productTitle[thisViewCellIndexPath!.row])
            //print(productPrice[thisViewCellIndexPath!.row])
            secondViewController.reseaveName = productTitle[(thisViewCellIndexPath?.row)!]
            secondViewController.reseavePrice = productPrice[(thisViewCellIndexPath?.row)!]
            secondViewController.firstViewIndexPath = thisViewCellIndexPath!.row
        }
    }
    
    //edit系の設定
    override func setEditing(_ editing: Bool, animated: Bool) {
        //override前の処理を継続してさせる
        super.setEditing(editing, animated: animated)
        productTable.isEditing = editing
        
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        //dataを消してから
        productTitle.remove(at: indexPath.row)
        productPrice.remove(at: indexPath.row)
        
        //tableViewCellの削除
        tableView.deleteRows(at: [indexPath], with: .automatic)
        
        productTable.reloadData()
    }
}

