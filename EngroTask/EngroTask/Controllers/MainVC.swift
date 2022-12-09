//
//  MainVC.swift
//  EngroTask
//
//  Created by Suman Guntuka on 09/12/22.
//

import UIKit

class MainVC: UIViewController {

    @IBOutlet weak var multipleFileBtn: UIButton!
    @IBOutlet weak var infinityBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        cosmoticChanges();
    }
   func cosmoticChanges(){
       multipleFileBtn.layer.cornerRadius = 21
       multipleFileBtn.layer.borderWidth = 1
       multipleFileBtn.layer.borderColor = UIColor.tintColor.cgColor
       infinityBtn.layer.cornerRadius = 21
       infinityBtn.layer.borderWidth = 1
       infinityBtn.layer.borderColor = UIColor.tintColor.cgColor
    }

    @IBAction func multipleFileBtnAction(_ sender: Any) {
        let uploadVC = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "MultipleFilesVC") as? MultipleFilesVC
        self.navigationController?.pushViewController(uploadVC!, animated: true)
        
    }
    @IBAction func infinityScrollBtnAction(_ sender: Any) {
        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "InfinityScrollVC") as? InfinityScrollVC
        self.navigationController?.pushViewController(vc!, animated: true)
    }
}
