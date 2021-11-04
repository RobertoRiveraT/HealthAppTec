//
//  agregarReportesViewController.swift
//  HealthApp
//
//  Created by user194251 on 11/3/21.
//

import UIKit

class agregarReportesViewController: UIViewController {

   let reporteControlador = ReportesControlador()
    
    @IBOutlet weak var nombreR: UITextField!
    
    @IBOutlet weak var vacunaNomb: UITextField!
    
    @IBOutlet weak var fecha: UITextField!
    
    @IBOutlet weak var numDosis: UITextField!
    
    @IBOutlet weak var dolorCabeza: UISwitch!
    
    @IBOutlet weak var fiebre: UISwitch!
    
    @IBOutlet weak var cuerpoCortado: UISwitch!
    
    @IBOutlet weak var Congnasal: UISwitch!
    
    @IBOutlet weak var otroEf: UITextView!
    
    
    
    @IBAction func registrarV(_ sender: UIButton) {
        
        var nuevoReporte = Report(from: Report as! Decoder, nombre: nombreR.text!, nombreVacuna:vacunaNomb.text!, fechaUltimaVacuna:fecha.text!, numeroDosis:numDosis.text!, dolorCabeza:dolorCabeza, fiebre:fiebre, cuerpoCortado:cuerpoCortado, Congnasal:Congnasal,otroEfecto: otroEf.text!)
        
        reporteControlador.insertReporte(nuevoReporte: nuevoReporte){
            
            }
        }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        

        
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
