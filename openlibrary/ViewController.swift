//
//  ViewController.swift
//  openlibrary
//
//  Created by Erick Rodriguez Ramos on 28/08/16.
//  Copyright © 2016 Erick Rodriguez Ramos. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var isbn: UITextField!
    
    @IBOutlet weak var titulo: UILabel!
    
    @IBOutlet weak var autores: UITextView!
    @IBAction func pedir(sender: AnyObject) {
        let urls="https://openlibrary.org/api/books?jscmd=data&format=json&bibkeys=ISBN:"+isbn.text!
        let url = NSURL(string: urls)
        let datos:NSData?=NSData(contentsOfURL: url!)
                 let texto = NSString(data:datos!,encoding: NSUTF8StringEncoding)
        if datos == nil {
            let alerta=UIAlertController(title: "Sin conexion", message: "No se puede conectar con el servidor", preferredStyle: .Alert)
            let accionError = UIAlertAction(title: "Error", style: .Default, handler: {
             accion in //..
            })
            alerta.addAction(accionError)
            self.presentViewController(alerta, animated: true, completion:nil)
        }else{
            if texto == "{}" {
                isbn.text="ISBN no encontrado"
                return
            }
        do {
            let json = try NSJSONSerialization.JSONObjectWithData(datos!, options: NSJSONReadingOptions.MutableLeaves)
            let dico1 = json as! NSDictionary
            let dico2 = dico1["ISBN:"+isbn.text!] as! NSDictionary
            self.titulo.text=dico2["title"] as! NSString as String
            self.autores.text=dico2["by_statement"] as! NSString as String
            //self.salida.text=texto! as String
        } catch _ {
            
        }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.isbn.delegate = self;
        // Do any additional setup after loading the view, typically from a nib.
    }
   

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }


}

