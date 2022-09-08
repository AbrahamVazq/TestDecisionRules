//  ViewController.swift
//  TestDecisionRules
//  Created by 291732 on 06/09/22.

import UIKit

class ViewController: UIViewController {
    //MARK: - O U T L E T S
    @IBOutlet weak var imgDR: UIImageView!{
        didSet{self.imgDR.layer.cornerRadius = 50}
    }
    @IBOutlet weak var vwContainer: UIView!{
        didSet{ self.vwContainer.layer.cornerRadius = 15 }
    }
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
    
    //MARK: - L I F E · C Y C L E
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    //MARK: - D E C I S I O N · R U L E S
    func loadServices(WithUser usr:String, andSsap ssap:String) {
        let url = URL(string: "https://api.decisionrules.io/rule/solve/52c13b20-796f-7893-38b3-ca1252495f79/1")!
        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("Bearer BGyRbnPhxqk5BYsP1g3zt0qRL5kIf13ul95jPRh8FH0C3f9YbcRHzdUrQbGqa4Az", forHTTPHeaderField: "Authorization")
        request.httpMethod = "POST"

        let parameters: [String: Any] = [ "data" : [
                        "usuario": "\(usr)",
                        "contrasena": "\(ssap)", "esNuevoIngreso": "false"] ]
        
        let jsonData =  try? JSONSerialization.data(withJSONObject: parameters)
        request.httpBody = jsonData
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, let response = response as? HTTPURLResponse, error == nil else { // check for fundamental networking error
                print("error - response", error ?? URLError(.badServerResponse))
                return
            }
            
            guard (200 ... 299) ~= response.statusCode else {                    // check for http errors
                print("statusCode should be 2xx, but is \(response.statusCode)")
                print("response = \(response)")
                return
            }
            
            do {
                if let json = try JSONSerialization.jsonObject(with: data, options: [.allowFragments]) as? [String : Any] {
                    print("Info Json \(json)")
                } else {
                    let str = String(decoding: data, as: UTF8.self)
                    print("\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n str ----> \(str) \n\n\n\n\n\n\n\n\n\n\n\n\n\n\n")
                    print("No hay datos - - - - \(data) - \(str)")
                    
                }
                
            } catch {
                print(error) // parsing error
                if let responseString = String(data: data, encoding: .utf8) {
                    print("responseString = \(responseString)")
                } else {
                    print("unable to parse response as string")
                }
            }
        }
        task.resume()
    }
    
    
    //MARK: - F U N C T I O N S
    func showSimpleAlert() {
        let alert = UIAlertController(title: "DecisionRules", message: "Ingresa los datos por favor", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Aceptar", style: .default, handler: nil))
        self.present(alert, animated: true) 
    }
    
    
    //MARK: - V A L I D A T I O N S

    
    //MARK: - A C T I O N S
    @IBAction func goToLogin(_ sender: Any) {
        
        if txfUser.text == "" && txfPass.text == ""  {
            self.showSimpleAlert()
        }else{
            loadServices(WithUser: txfUser.text ?? "", andSsap: txfPass.text ?? "")
        }
        
    }
    
}

extension ViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
    }
}
