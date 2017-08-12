//
//  Product.swift
//  testerest
//
//  Created by Andrei on 7/17/17.
//  Copyright © 2017 Andrei. All rights reserved.
//

import Foundation


class Product {

    private var _id : Int = -1
    private var _nome : String = ""
    private var _qtd : Int = 0
    private var _preco: Double = 0.00
    
    init(id: Int, nome: String, qtd: Int, preco : Double) {
        self._id = id
        self._nome = nome
        self._qtd = qtd
        self._preco = preco
    }
    
    var id : Int {
        set { _id = newValue }
        get { return _id }
    }
    
    var nome : String {
        set { _nome = newValue }
        get { return _nome }
    }
    
    var qtd : Int {
        set { _qtd = newValue }
        get { return _qtd }
    }
    
    var preco : Double {
        set { _preco = newValue }
        get { return _preco }
    }
    
    

}
