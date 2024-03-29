//
//  secondViewController.swift
//  kakeibo
//
//  Created by 手嶋慧太 on 2019/06/28.
//  Copyright © 2019 手嶋慧太. All rights reserved.
//

import UIKit

class secondViewController: UIViewController, UITextFieldDelegate{
    
    @IBOutlet weak var productName: UITextField!
    @IBOutlet weak var productPrice: UITextField!
    @IBOutlet weak var OKButton: UIButton!
    @IBOutlet weak var categoryPicker: UIPickerView!
    
    var reseaveName:String!
    var reseavePrice:String!
    var firstViewIndexPath:Int!
    var inputCategory:String!
    
    var categoryList:[String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        productName.delegate = self
        productPrice.delegate = self
        // ピッカー設定
        categoryPicker.delegate = self
        categoryPicker.dataSource = self
        categoryPicker.showsSelectionIndicator = true

        OKButton.isEnabled = false
        
        productName!.text = reseaveName
        productPrice!.text = reseavePrice
        // Do any additional setup after loading the view.
        print("SVC")
        for i in categoryList {
            print(i)
        }
        
        print(categoryList.count)
    }
    @IBAction func nameEnter(_ sender: UITextField) {
        productName.text = sender.text
        OKButtonEnable()
    }
    @IBAction func priceEnter(_ sender: UITextField) {
        productPrice.text = sender.text
        OKButtonEnable()
    }
    func OKButtonEnable() {
        /*if productName.text != nil && productPrice.text != nil {
            OKButton.isEnabled = true
        }else {
            OKButton.isEnabled = false
        }*/
        guard productName.text!.isEmpty || productPrice.text!.isEmpty else {
            return OKButton.isEnabled = true
        }
    }
    
    func textFieldShouldReturn(prodictName: UITextField) -> Bool {
        prodictName.resignFirstResponder()
        OKButtonEnable()
        return true
    }
    func textFieldShouldReturn(productPrice: UITextField) -> Bool {
        productPrice.resignFirstResponder()
        OKButtonEnable()
        return true
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        productName.text = productName.text
        productPrice.text = productPrice.text
        OKButtonEnable()
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

extension secondViewController: UIPickerViewDataSource, UIPickerViewDelegate{
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return categoryList.count
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return categoryList[row]
    }
    
    
     // ドラムロール選択時
     func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
     inputCategory = categoryList[row]
     }
 
    
}

