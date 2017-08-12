//
//  CreateViewController.swift
//  testerest
//
//  Created by Andrei on 7/9/17.
//  Copyright © 2017 Andrei. All rights reserved.
//

import UIKit

class CreateViewController : UIViewController {


    @IBOutlet weak var inputName: UITextField!
    
    @IBOutlet weak var inputQtd: UITextField!
    
    @IBOutlet weak var inputPreco: UITextField!
    
    override func viewDidLoad() {
    }
    
    @IBAction func salvarButtonClicked(_ sender: Any) {
        let nome : String = inputName.text!
        var qtd = 0
        var preco = 0.00
        if let qtdText = inputQtd.text {
            qtd = (qtdText.isEmpty) ? 0 : Int(qtdText)!
        }
        
        if let precoText = inputPreco.text {
            preco = (precoText.isEmpty) ? 0.00 : Double(precoText)!
        }
        
        let dict = ["nome": nome, "qtd": qtd, "preco": preco] as [String:Any]

        do{
            if let jsonData = try? JSONSerialization.data(withJSONObject: dict, options: .prettyPrinted) {
                let url = URL(string: "http://localhost:3000/produtos")
                var request = URLRequest(url: url!)
                request.httpMethod = "POST"
                request.addValue("application/json", forHTTPHeaderField: "Content-Type")
                request.httpBody = jsonData
                print(String(data: request.httpBody!, encoding: .utf8)!)
                let session = URLSession.shared
                
                let task = session.dataTask(with: request){ data, response, error in
                    if error != nil {
                        print(error!)
                    }
                }
                task.resume()
            }

        }
        
    }
    
    @IBAction func cancelarButtonClicked(_ sender: Any) {
    }

}
