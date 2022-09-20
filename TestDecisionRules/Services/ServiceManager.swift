//  ServiceManager.swift
//  TestDecisionRules
//  Created by Moisés Abraham Vázquez Pérez on 08/09/22.

import Foundation

final class ServiceManager {
    //MARK: - B L O C K
    public typealias blkLogin = (DRLoginResponse?, NSError?) -> Void
    public typealias blkPromo = ([Promo]?, NSError?) -> Void
    
    
    //MARK: - V A R I A B L E S
    static let shared = ServiceManager ()
    private let strHost: String = "https://api.decisionrules.io/rule/solve/52c13b20-796f-7893-38b3-ca1252495f79/1"
    private let strHostBase: String = "https://api.decisionrules.io/rule/solve/"
    
    
    
    //MARK: -  F U N C T I O N S
    func loadServices(WithUser usr:String, andSsap ssap:String, completion: @escaping blkLogin) {
        let usuario = usr
        let pass = ssap
        
        let url = URL(string: strHost)!
        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("Bearer BGyRbnPhxqk5BYsP1g3zt0qRL5kIf13ul95jPRh8FH0C3f9YbcRHzdUrQbGqa4Az", forHTTPHeaderField: "Authorization")
        request.httpMethod = "POST"
        
        let parameters: [String: Any] = [ "data" : [
            "usuario": "\(usuario)",
            "contrasena": "\(pass)", "esNuevoIngreso": "false"] ]
        
        let jsonData =  try? JSONSerialization.data(withJSONObject: parameters)
        request.httpBody = jsonData
        
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            
            guard let data = data, let response = response as? HTTPURLResponse, error == nil else {
                print("error - response", error ?? URLError(.badServerResponse))
                return
            }
            
            guard (200 ... 299) ~= response.statusCode else {                  
                print("statusCode should be 2xx, but is \(response.statusCode)")
                print("response = \(response)")
                return
            }
            do {
                let loginResponse = try JSONDecoder().decode([DRLoginResponse].self, from: data)
                let first = loginResponse[0]
                let objRes: DRLoginResponse = DRLoginResponse(urlBanner: first.urlBanner, tienePromo: first.tienePromo, color: first.color, nombre: first.nombre)
                completion(objRes,nil)
            } catch {
                print(error)
                if let responseString = String(data: data, encoding: .utf8) {
                    print("responseString = \(responseString)")
                } else {
                    print("unable to parse response as string")
                }
            }
        }
        task.resume()
    }
    
    func loadPromotions(WithDate strFecha:String, completion: @escaping blkPromo) {
      
        
        let url = URL(string: strHostBase + "a67842ae-3383-cdc7-efea-dd5bea7c5103/1")!
        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("Bearer BGyRbnPhxqk5BYsP1g3zt0qRL5kIf13ul95jPRh8FH0C3f9YbcRHzdUrQbGqa4Az", forHTTPHeaderField: "Authorization")
        request.httpMethod = "POST"
        
        let parameters: [String: Any] = [ "data" : [
            "dateLogin": "\(strFecha)"] ]
        
        let jsonData =  try? JSONSerialization.data(withJSONObject: parameters)
        request.httpBody = jsonData
        
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            
            guard let data = data, let response = response as? HTTPURLResponse, error == nil else {
                print("error - response", error ?? URLError(.badServerResponse))
                return
            }
            
            guard (200 ... 299) ~= response.statusCode else {
                print("statusCode should be 2xx, but is \(response.statusCode)")
                print("response = \(response)")
                return
            }
            do {
                let loginResponse = try JSONDecoder().decode([Promo].self, from: data)
                completion(loginResponse,nil)
                
            } catch {
                print(error)
                if let responseString = String(data: data, encoding: .utf8) {
                    print("responseString = \(responseString)")
                } else {
                    print("unable to parse response as string")
                }
            }
        }
        task.resume()
    }
    
}
