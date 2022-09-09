//  CustomedDataViewController.swift
//  TestDecisionRules
//  Created by 291732 on 08/09/22.

import UIKit

class CustomedDataViewController: UIViewController {
    //MARK: - O U T L E T S
    @IBOutlet weak var lblTitle: UILabel!{
        didSet{self.lblTitle.textColor = .white }
    }
    
    @IBOutlet weak var lblDescription: UILabel!{
        didSet{self.lblDescription.textColor = .white}
    }
    
    @IBOutlet weak var tblProducts: UITableView! {
        didSet{
            self.tblProducts.delegate = self
            self.tblProducts.dataSource = self
            self.tblProducts.layer.cornerRadius = 15
            self.tblProducts.register(ProductsTableViewCell.nib, forCellReuseIdentifier: ProductsTableViewCell.identifier)
        }
    }
    
    //MARK: - V A R I A B L E S
    var user: Usuario?
    
    //MARK: - L Y F E · C Y C L E
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "baz x DecisionRules"
        self.lblTitle.text = "Hola \(user?.strName ?? "Hola de nuevo!!!") !!!"
        self.setScreen(fromUser: user ?? Usuario())
    }
    
    private func setScreen(fromUser usr: Usuario) {
        self.view.backgroundColor = returnColor(WithUser: usr)
        var msg:String =  ""
        returnSeason(FromUser: usr) != "" ? (msg = "Ya estamos en \(returnSeason(FromUser: usr)) aprovecha las ofertas que tenemos para ti! ") : (msg = "Tenemos los mejors productos! ")
        self.lblDescription.text = msg
    }
    
    func returnSeason(FromUser usr: Usuario) -> String{
        switch usr.color{
        case "spring":
            return "Primavera"
        case "summer":
            return "Verano"
        case "autumn":
            return "Otoño"
        case "winter":
            return "Invierno"
        default:
            return ""
        }
    }
    
    private func returnColor(WithUser usr: Usuario) -> UIColor {
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
        case "spring":
            return UIColor(red: 98/255, green: 119/255, blue: 83/255, alpha: 1)
        case "summer":
            return UIColor(red: 247/255, green: 187/255, blue: 18/255, alpha: 1)
        case "autumn":
            return UIColor(red: 186/255, green: 137/255, blue: 93/255, alpha: 1)
        case "winter":
            return UIColor(red: 108/255, green: 200/255, blue: 236/255, alpha: 1)
        default:
            return UIColor.white
        }
    }
    
    
    //MARK: - F U N C T I O N S
    private func setView(WithUser usr: Usuario){
        
    }
    

}

extension CustomedDataViewController: UITableViewDelegate & UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ProductsTableViewCell.identifier, for: indexPath) as? ProductsTableViewCell ?? ProductsTableViewCell()
        return cell
    }
    
    
}
