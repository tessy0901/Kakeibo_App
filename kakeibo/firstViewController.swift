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
    var productCategory:[String] = ["学食","交通費","交通費"]
    
    //カテゴリーの橋渡し配列
    var categoryList:[String] = ["食費","学食","交通費","test1","tset2"]
    
    @IBOutlet weak var productTable: UITableView!
    @IBAction func reloadButton(_ sender: Any) { productTable.reloadData() }
    //tableへの値の追加 or 編集
    @IBAction func GoTofirstVC(_ segue : UIStoryboardSegue){
        guard let inputsource = segue.source as? secondViewController else {
            return
        }
        guard let tableText = inputsource.productName!.text else { return  }
        guard let tablePrice = inputsource.productPrice!.text else { return  }
        guard let tableCategory = inputsource.inputCategory else { return }
        if inputsource.firstViewIndexPath != nil{
            productTitle[inputsource.firstViewIndexPath] = tableText
            productPrice[inputsource.firstViewIndexPath] = tablePrice
            productCategory[inputsource.firstViewIndexPath] = tableCategory
        }else {
            productTitle.append(tableText)
            productPrice.append(tablePrice)
            productCategory.append(tableCategory)
        }
        productTable.reloadData()
    }
    @IBAction func SettingToFirst(_ segue: UIStoryboardSegue) {
        guard let inputCategory = segue.source as? settingViewController else{
            return
        }
        categoryList.append(inputCategory.newCategory.text!)
        print("FVC:")
        for i in categoryList{
            print(i)
        }
        //let secondViewController: UIViewController = self.storyboard?.instantiateViewController(withIdentifier: "secondViewController") as! secondViewController
        
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
        print("veiwDidLoad")
        for i in productCategory{
            print(i)
        }
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
        //インスタンス化
        let secondViewController = segue.destination as! secondViewController
        
        secondViewController.categoryList.removeAll()
        for i in categoryList {
            secondViewController.categoryList.append(i)
            print(i)
        }
        print(productCategory.count)
        print(secondViewController.categoryList.count)
        if segue.identifier == "ToSecondVC" {
            let thisViewCellIndexPath = productTable.indexPathForSelectedRow
            //print(thisViewCellIndexPath!.row)
            //print(productTitle[thisViewCellIndexPath!.row])
            //print(productPrice[thisViewCellIndexPath!.row])
            secondViewController.reseaveName = productTitle[(thisViewCellIndexPath?.row)!]
            secondViewController.reseavePrice = productPrice[(thisViewCellIndexPath?.row)!]
            secondViewController.firstViewIndexPath = thisViewCellIndexPath!.row
            //secondViewController.categoryList.append(contentsOf: productCategory)
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
        productCategory.remove(at: indexPath.row)
        
        //tableViewCellの削除
        tableView.deleteRows(at: [indexPath], with: .automatic)
        
        productTable.reloadData()
    }
}

