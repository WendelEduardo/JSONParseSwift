//
//  ViewController.swift
//  ExemploIOSRest
//
//  Created by Usuário Convidado on 09/09/24.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var lblID: UILabel!
    @IBOutlet weak var lblData: UILabel!
    @IBOutlet weak var lblTitulo: UILabel!
    @IBOutlet weak var imgMinhaImagem: UIImageView!
    
    
    var session: URLSession?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


    @IBAction func exibir(_ sender: Any) {
        let config = URLSessionConfiguration.default
        
        session = URLSession(configuration: config)
        
        let url = URL(string: "https://xkcd.com/info.0.json")
        
        let task = session?.dataTask(with: url!, completionHandler: {
            data, response, error in
            
            let texto = self.retornarTitulo(data: data!){
                DispatchQueue.main.sync {
                    self.lblTitulo.text = texto
                }
            }
            print(texto!)
        })
        
        task?.resume()
    }
    
    
    func retornarTitulo(data: Data)->String?{
        
        var resposta:String?=nil
        
        do{
            let json = try JSONSerialization.jsonObject(with: data, options: []) as! [String:Any]
            
            if let retorno = json["title"] as? String{
                resposta = retorno
            }
            
        }catch let error as NSError{
            resposta = "Falha ao carregar \(error.localizedDescription)"
        }
        
        return resposta
        
    }
}

