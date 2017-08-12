var express = require("express");
var bodyParser = require("body-parser");
var app = express();

app.use(bodyParser.json());

let produtos = [];
let lastIndex = 1;

let criaProduto = function(nome, qtd, preco) {
    let produto = {};
    produto.id = lastIndex++;
    produto.nome = nome;
    produto.qtd = qtd;
    produto.preco = preco;
    return produto;
};

app.get('/produtos', function(req, res, next) {
    res.json(produtos);
});

app.get('/produtos/:id', function(req, res, next) {
    var encontraProduto = function(prod) {
        return prod.id == req.params.id;
    };
    var produto = produtos.find(encontraProduto);

    if ( produto ) {
        res.json( produto );   
    } else {
        res.status(404).send("Produto nao encontrado");
    }
});

app.post('/produtos', function(req, res, next) {
    console.log("Receiving a POST request");
    console.log(req.body);    

    if ( !req.body || !req.body.nome ) {
        res.status(500).send("Produto fornecido incorretamente");
        return;
    }
    let produtoEnviado = req.body;

    let produto = criaProduto( 
        produtoEnviado.nome ? produtoEnviado.nome : null,
        produtoEnviado.qtd ? produtoEnviado.qtd : null,
        produtoEnviado.preco ? produtoEnviado.preco : null
     );
     produtos.push(produto);

     res.json(produto);
});

app.put("/produtos/:id", function(req, res, next) {
    if ( !req.body || !req.body.nome ) {
        res.status(500).send("Produto fornecido incorretamente");
        return;
    }

    var encontraProduto = function(prod) {
        return prod.id == req.params.id;
    };
    var produto = produtos.find(encontraProduto);
    if (!produto) {
        res.status(404).send("Produto nao encontrado");
        return;
    }

    produto.nome = req.body.nome;
    produto.qtd = req.body.qtd;
    produto.preco = req.body.preco;

    res.json(produto);    
});

app.delete("/produtos/:id", function() {
    let index = -1;
    var encontraProduto = function(prod, i) {
        if ( prod.id == req.params.id ) {
            index = i;
            return true;
        }
        return false;
    };
    var existeProduto = produtos.some(encontraProduto);
    if (existeProduto) {
        produtos.splice(index, 1);
    } else {
        res.status(404).send("Produto nao encontrado");
        return;
    }
});

app.listen(3000, function() {
    console.log('Produtos Server started at port 3000')
});