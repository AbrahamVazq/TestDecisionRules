//
//  CustomedDataViewController.swift
//  TestDecisionRules
//
//  Created by 291732 on 08/09/22.
//

import UIKit

class CustomedDataViewController: UIViewController {
    
    @IBOutlet weak var lblTitle: UILabel!{
        didSet{self.lblTitle.textColor = .white }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    
    private func setView(WithUser usr: Usuario){
        
    }
    

}
