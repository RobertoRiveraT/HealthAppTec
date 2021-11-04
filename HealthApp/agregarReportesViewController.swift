//
//  agregarReportesViewController.swift
//  HealthApp
//
//  Created by user194251 on 11/3/21.
//

import UIKit

class agregarReportesViewController: UIViewController {

   let reporteControlador = ReportsController()
    
    @IBOutlet weak var nombreR: UITextField!
    
    @IBOutlet weak var vacunaNomb: UITextField!
    
    @IBOutlet weak var fecha: UITextField!
    
    @IBOutlet weak var numDosis: UITextField!
    
    @IBOutlet weak var dolorCabeza: UISwitch!
    
    @IBOutlet weak var fiebre: UISwitch!
    
    @IBOutlet weak var cuerpoCortado: UISwitch!
    
    @IBOutlet weak var Congnasal: UISwitch!
    
    @IBOutlet weak var otroEf: UITextView!
    
    
    
	@IBAction func crearReporte(_ sender: UIButton) {
		let nuevoReporte = Report(nombre: nombreR.text!, nombreVacuna: vacunaNomb.text!, fechaUltimaVacuna: fecha.text!, numeroDosis: Int(numDosis.text!)!, dolorCabeza: dolorCabeza.isOn, fiebre: fiebre.isOn, cuerpoCortado: cuerpoCortado.isOn, congestionNasal: Congnasal.isOn, otro:otroEf.text!)
	
        reporteControlador.insertReporte(nuevoReporte: nuevoReporte){
            (resultado) in
            switch resultado{
            case .success(let exito):
                self.displayExito(exito: exito)
            case .failure(let err):
                self.displayError(e: err)
            }
        }

		
	}
    
    func displayError(e:Error){
        DispatchQueue.main.async {
            let alerta =  UIAlertController(title: "Error de creación en BD", message: e.localizedDescription, preferredStyle: .alert)
            alerta.addAction(UIAlertAction(title: "Cerrar", style: .default, handler: self.terminacion))
            self.present(alerta, animated: true, completion: nil)

        }
    }
    func displayExito(exito:String ){
        DispatchQueue.main.async {
            let alerta =  UIAlertController(title: "Reporte creada en BD", message: exito, preferredStyle: .alert)
            alerta.addAction(UIAlertAction(title: "Cerrar", style: .default, handler: self.terminacion))
            self.present(alerta, animated: true, completion: nil)
           
        }
    }
    
    func terminacion(alert: UIAlertAction!){
        self.presentingViewController?.dismiss(animated: true, completion: nil)
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
