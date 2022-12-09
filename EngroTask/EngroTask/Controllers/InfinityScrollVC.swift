//
//  InfinityScrollVC.swift
//  EngroTask
//
//  Created by Suman Guntuka on 09/12/22.
//

import UIKit

class InfinityScrollVC: UIViewController {

    @IBOutlet weak var newsTable: UITableView!
    var isLoading = false
    var newItemArray = [String]()
    var appleCompanyLatestNews = "Apple is the largest technology company by revenue (totaling US$365.8 billion in 2021) and, as of June 2022, is the world's biggest company by market capitalization, the fourth-largest personal computer vendor by unit sales and second-largest mobile phone manufacturer. Apple unveiled the third-generation iPhone SE with 5G and an A15 chip, the fifth-generation iPad Air with M1 chip and 5G, the Mac mini/Mac Pro hybrid called the Mac Studio with new high-end M1 Ultra chip, and the Studio Display, a new 27-inch 5K display that's priced at $1,599."
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Apple Company India."
        self.navigationController?.navigationBar.tintColor = UIColor.black

        let tableViewLoadingCellNib = UINib(nibName: "ActivityLoader", bundle: nil)
        self.newsTable.register(tableViewLoadingCellNib, forCellReuseIdentifier: "ActivityLoader")
        loadData()
    }
    func loadData() {
        self.isLoading = false
        for i in 1...40 {
            newItemArray.append("\(i). \(self.appleCompanyLatestNews)")
           }
        
        DispatchQueue.main.async {
          self.newsTable.reloadData()
        }
        
       }
    
   func loadMoreData() {
       
        if !self.isLoading {
            self.isLoading = true
            let start = self.newItemArray.count
            let end = start + 10
            DispatchQueue.global().asyncAfter(deadline: .now() + .seconds(1)) {
                for i in start...end {
                    self.newItemArray.append("\(i). \(self.appleCompanyLatestNews)")
                }
                DispatchQueue.main.async {
                    self.newsTable.reloadData()
                    self.isLoading = false
                }
            }
        }
       
    }
}
    
extension InfinityScrollVC : UITableViewDelegate,UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return newItemArray.count
                } else if section == 1 {
                    return 1
                } else {
                    return 0
                }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
        if indexPath.section == 0 {
        let cell = tableView.dequeueReusableCell(withIdentifier: "NewsCell", for: indexPath) as! NewsCell
            cell.newLbl.text = newItemArray[indexPath.row]
            return cell
        } else {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ActivityLoader", for: indexPath) as! ActivityLoader
            cell.loadActivity.startAnimating()
            return cell
        }
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if indexPath.section == 0 {
            return UITableView.automaticDimension
            } else {
                return 20
            }
       }
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        if indexPath.row == newItemArray.count - 10, !isLoading {
            loadMoreData()
        }
      }
    }
    
    
    

