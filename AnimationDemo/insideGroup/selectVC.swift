//
//  selectVC.swift
//  AnimationDemo
//
//  Created by Priyal on 18/11/24.
//

import UIKit

class selectVC: UIViewController {

    @IBOutlet weak var headerview: UIView!
    @IBOutlet weak var tblView: UITableView!
    var startingFrame: CGRect = .zero
    var endingFrame: CGRect = .zero
    override func viewDidLoad() {
        super.viewDidLoad()
        DispatchQueue.main.asyncAfter(deadline: .now()+1, execute: {
            self.tblView.dataSource = self
            self.tblView.delegate = self
            self.tblView.reloadData()
        })
       
        // Do any additional setup after loading the view.
    }
    
}
extension selectVC : UITableViewDelegate , UITableViewDataSource {
 
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(
            withIdentifier: "TblCell2", for: indexPath)
       
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.dismiss(animated: true)
      //  self.dismiss(animated: true)
    }
    
    
}
