//
//  MenuTableViewController.swift
//  Resto json crud app
//
//  Created by Nando Septian Husni on 21/08/18.
//  Copyright © 2018 IMASTUDIO. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import AlamofireImage

class MenuTableViewController: UITableViewController {

    var data = [[String : String]]()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    func ambilData(){
        
        //ambil data
        Alamofire.request("http://192.168.20.133/server_resto/index.php/api/ambilMakanan").responseJSON { (responseData) in
            
            //get response
            let alljson = JSON(responseData.result.value as Any)
            
            let sukses = alljson["sukses"].boolValue
            
            if sukses {
                
                self.data = alljson["data"].arrayObject as! [[String : String]]
                //load table view
                self.tableView.reloadData()
            }
        }
        
    }
    override func viewDidAppear(_ animated: Bool) {
        
        ambilData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return data.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? TableViewCell

        
        let datas = data[indexPath.row]
        
        cell?.cellHarga.text = datas["menu_harga"]
        cell?.cellName.text = datas["menu_nama"]
        
        //load image using alamofire image
        Alamofire.request("http://192.168.20.133/picture/" + datas["menu_gambar"]!)
            .responseImage { (dataImage) in
                
                
                //ambil gambar
                let gambar = dataImage.data
                
                cell?.cellImg.image = UIImage(data: gambar!)
                
                
        }
        
        
        
        
        return cell!
    }
 

  
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
 

  
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            
            //get id
            let id = data[indexPath.row]["menu_id"]
            actionDelete(id: id!)
            
            // Delete the row from the data source
           // tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let story = UIStoryboard(name: "Main", bundle: Bundle.main)
        let update = story.instantiateViewController(withIdentifier: "update") as? UpdateViewController
        //passing data ke updateviewcontroller
        let datas = data[indexPath.row]
        update?.nameTampung = datas["menu_nama"]
        update?.priceTampung = datas["menu_harga"]
        update?.idTampung = datas["menu_id"]
        update?.stockTampung = datas["menu_stok"]
        
        //pindah
        show(update!, sender: self)
        
    }
    
    func actionDelete(id : String){
        let url = "http://192.168.20.133/server_resto/index.php/api/hapusMakanan/" + id

        Alamofire.request(url).responseJSON { (responseJson) in
            
            let json = JSON(responseJson.result.value as Any)
            let sukses = json["sukses"].boolValue
            if sukses {
                self.ambilData()
            }
            else{
            
                print("delete fail")
            }
        }
    }
  

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
