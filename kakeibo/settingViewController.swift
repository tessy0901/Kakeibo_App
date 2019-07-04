//
//  settingViewController.swift
//  kakeibo
//
//  Created by 手嶋慧太 on 2019/07/04.
//  Copyright © 2019 手嶋慧太. All rights reserved.
//

import UIKit

class settingViewController: UIViewController {
    @IBOutlet weak var newCategory: UITextField!
    @IBOutlet weak var OKButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        OKButton.isEnabled = false
        // Do any additional setup after loading the view.
    }
    @IBAction func categoryEnter(_ sender: UITextField) {
        newCategory.text = sender.text
        
        OKButtonEnable()
    }
    func textFieldShouldReturn(prodictName: UITextField) -> Bool {
        newCategory.resignFirstResponder()
        OKButtonEnable()
        return true
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        newCategory.resignFirstResponder()
        
        OKButtonEnable()
    }
    func OKButtonEnable() {
        guard newCategory.text!.isEmpty else {
            return OKButton.isEnabled = true
        }
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
