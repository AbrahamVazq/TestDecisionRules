//  ViewController.swift
//  TestDecisionRules
//  Created by 291732 on 06/09/22.

import UIKit

class ViewController: UIViewController {
    //MARK: - O U T L E T S
    @IBOutlet weak var imgDR: UIImageView!{ didSet{self.imgDR.layer.cornerRadius = 50}}
    @IBOutlet weak var vwContainer: UIView!{ didSet{ self.vwContainer.layer.cornerRadius = 15 }}
    @IBOutlet weak var btnLogin: UIButton!
    @IBOutlet weak var txfUser: UITextField!{
        didSet{
            self.txfUser.delegate = self
            self.txfUser.textColor = UIColor(red: 70/255, green: 0/255, blue: 225/255, alpha: 1)
        }
    }
    @IBOutlet weak var txfPass: UITextField!{
        didSet{
            self.txfPass.delegate = self
            self.txfPass.textColor = UIColor(red: 70/255, green: 0/255, blue: 225/255, alpha: 1)
        }
    }
    
    
    //MARK: - V A R I A B L E S
    var user: Usuario = Usuario()
    private var arrLogin: [DRLoginResponse] = []
    
    //MARK: - L I F E · C Y C L E
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    //MARK: - D E C I S I O N · R U L E S
    func loadServices(WithUser usr:String, andSsap ssap:String) {
        let ws: ServiceManager = ServiceManager()
        ws.loadServices(WithUser: usr, andSsap: ssap) { [weak self] resultado, error  in
            if resultado != nil{
                if let usr = resultado {
                    self?.user = self?.setInfoIn(UserWithResponse: usr) ?? Usuario()
                    DispatchQueue.main.async {
                        self?.performSegue(withIdentifier: "LoginToMainPage", sender: self)
                    }
                }
            }else{ self?.showSimpleAlert(WithMessage: error.debugDescription) }
        }
    }
    
    //MARK: - F U N C T I O N S
    func showSimpleAlert(WithMessage msg: String) {
        let alert = UIAlertController(title: "DecisionRules", message: msg , preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Aceptar", style: .default, handler: nil))
        self.present(alert, animated: true)
    }
    
    private func setInfoIn(UserWithResponse usr: DRLoginResponse) -> Usuario{
        var usrAux = Usuario()
        usrAux.strName = usr.nombre
        usrAux.urlBanner = usr.urlBanner
        usrAux.bhasPromo = usr.tienePromo
        usrAux.color = usr.color
        return usrAux
    }
    
    //MARK: - A C T I O N S
    @IBAction func goToLogin(_ sender: Any) {
        if txfUser.text == "" && txfPass.text == ""  {
            self.showSimpleAlert(WithMessage: "Ingresa los datos por favor")
        }else{
            loadServices(WithUser: txfUser.text ?? "", andSsap: txfPass.text ?? "")
        }
    }
    
    //MARK: - N A V I G A T I O N
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? CustomedDataViewController {
            destination.user = user }
    }
}

// MARK: - EXT -> UI · T E X T F I E L D · D E L E G A T E
extension ViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
    }
}
