//
//  ViewController.swift
//  testerest
//
//  Created by Andrei on 7/9/17.
//  Copyright © 2017 Andrei. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    
    
    @IBOutlet weak var produtosTableView: UITableView!
    
    var produtos : [Product] = []
    var produtosFetched = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        produtosTableView.delegate = self
        produtosTableView.dataSource = self
        
        loadProdutos()
    }
    
    func loadProdutos() {
        let url = URL(string: "http://localhost:3000/produtos")

        let task = URLSession.shared.dataTask(with: url!, completionHandler:{ (data, response, error) in
            if error != nil {
                print(error! as Any)
            }
            
            if data != nil {
                do {
                    let products = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.mutableContainers) as! [[String:Any]]
                    
                    DispatchQueue.main.async {
                        products.forEach({jsonProd in
                            let product = Product(id: jsonProd["id"] as! Int, nome: jsonProd["nome"] as! String, qtd: jsonProd["qtd"] as! Int, preco: jsonProd["preco"] as! Double)
                            print(product.nome)
                            self.produtos.append(product)
                            self.produtosTableView.reloadData()
                        })
                    }
                } catch {
                    print("Error")
                }
            }
        })
        task.resume()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return produtos.count;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = produtos[indexPath.row].nome
        return cell
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func goToAddProduct(_ sender: Any) {
        performSegue(withIdentifier: "toAddProductSegue", sender: nil)
    }

}

