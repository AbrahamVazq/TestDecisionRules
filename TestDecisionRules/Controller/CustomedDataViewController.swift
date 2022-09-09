//  CustomedDataViewController.swift
//  TestDecisionRules
//  Created by 291732 on 08/09/22.

import UIKit

class CustomedDataViewController: UIViewController {
    //MARK: - O U T L E T S
    @IBOutlet weak var lblTitle: UILabel!{
        didSet{self.lblTitle.textColor = .white }
    }
    
    //MARK: - V A R I A B L E S
    var user: Usuario?
    
    //MARK: - L Y F E · C Y C L E
    override func viewDidLoad() {
        super.viewDidLoad()
        print("\n\n\t usuario  ---> \(user.debugDescription) \n")
        self.setScreen(fromUser: user ?? Usuario())
    }
    
    private func setScreen(fromUser usr: Usuario) {
        self.lblTitle.text = "Bienvenido (a) \(usr.strName ?? "")"
        self.view.backgroundColor = returnColor(WithUser: usr)
        
    }
    
    private func returnColor(WithUser usr: Usuario) -> UIColor {
        print(usr.color)
        switch usr.color {
        case "pink":
            return UIColor.systemPink
        case "brown":
            return UIColor.brown
        case "green":
            return UIColor.green
        case "orange":
            return UIColor.orange
        case "blue":
            return UIColor.blue
        case "red":
            return UIColor.red
        default:
            return UIColor.white
        }
    }
    
    
    //MARK: - F U N C T I O N S
    private func setView(WithUser usr: Usuario){
        
    }
    

}
