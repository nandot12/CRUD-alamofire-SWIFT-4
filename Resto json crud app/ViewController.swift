//
//  ViewController.swift
//  Resto json crud app
//
//  Created by Nando Septian Husni on 21/08/18.
//  Copyright © 2018 IMASTUDIO. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class ViewController: UIViewController {

    @IBOutlet weak var etStock: UITextField!
    @IBOutlet weak var etPrice: UITextField!
    @IBOutlet weak var etName: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func insertServer(_ sender: Any) {
        //check textfield kosong apa enggak
        
        if etStock.text == "" && etPrice.text == "" && etName.text == "" {
            
            //tampilin alert
            alert(title: "Informasi", msg: "tidak boleh kosong")
            
            
        }
        else {
            //end point
            let url = "http://192.168.20.133/server_resto/index.php/api/tambahMakanan"
            //declare params
            let params : [String : String] = ["name" : etName.text!,
                          "price" : etPrice.text!,
                          "stok" : etStock.text!]
            
            
            //send request
            
            Alamofire.request(url, method: .post, parameters: params, encoding: URLEncoding.httpBody, headers: nil).responseJSON { (responseInsert) in
                
                //get response
                let json = JSON(responseInsert.result.value as Any)
                let pesan = json["pesan"].stringValue
                let sukses = json["sukses"].boolValue
                
                //check response
                if sukses {
                    
                    //pindah k menu resto
                    self.navigationController?.popToRootViewController(animated: true)
                }
                else {
                    self.alert(title: "informasi", msg: pesan)
                }
                
                
            }
            
            
            
            
            
            
        }
    }
    
    func alert(title : String , msg : String){
        let alert = UIAlertController(title: title, message: msg, preferredStyle: .alert)
        let action = UIAlertAction(title: "ok", style: .default, handler: nil)
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
}

