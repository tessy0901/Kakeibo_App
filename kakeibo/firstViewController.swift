//
//  ViewController.swift
//  kakeibo
//
//  Created by 手嶋慧太 on 2019/06/28.
//  Copyright © 2019 手嶋慧太. All rights reserved.
//

import UIKit

class firstViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    var productTitle:[String] = ["電子マネーチャージ","うどん","アマゾンギフトカード"]
    var productPrice:[String] = ["5000","360","2000"]
    var productCategory:[String] = ["交通費","学食","交遊費"]
    
    //カテゴリーの橋渡し配列
    var categoryList:[String] = ["食費","学食","交通費","交遊費","消耗品","その他"]
    
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
        
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if let indexPathForSelectedRow = productTable.indexPathForSelectedRow {
            productTable.deselectRow(at: indexPathForSelectedRow, animated: true)
        }
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
        cell.categoryLabel.text = ":"+productCategory[indexPath.row]
        
        cell.accessoryType = UITableViewCell.AccessoryType.disclosureIndicator
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        //tableView.estimatedRowHeight = 88 //セルの高さ
        return 88//UITableView.automaticDimension //自動設定
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath.row)
        performSegue(withIdentifier: "ToSecondVC", sender: nil)
    }
    override func prepare(for segue:UIStoryboardSegue, sender:Any?){
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
        productCategory.remove(at: indexPath.row)
        
        //tableViewCellの削除
        tableView.deleteRows(at: [indexPath], with: .automatic)
        
        productTable.reloadData()
    }
}

