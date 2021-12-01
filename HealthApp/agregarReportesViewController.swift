//
//  agregarReportesViewController.swift
//  HealthApp
//
//  Created by user194251 on 11/3/21.
//

import UIKit
import Vision

class agregarReportesViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

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
    
//	Para la galeria
	@IBOutlet weak var camaraBtn: UIButton!
	private let miPicker = UIImagePickerController()
	
    
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
        
			if !UIImagePickerController.isSourceTypeAvailable(.camera){
				camaraBtn.isHidden = true
			}
			miPicker.delegate = self
        
        // Do any additional setup after loading the view.
    }
    
	
	
	@IBAction func openCamera(_ sender: UIButton) {
		miPicker.sourceType = UIImagePickerController.SourceType.camera
		
		present(miPicker, animated: true, completion: nil)
		
	}
	
	
	@IBAction func openGalery(_ sender: UIButton) {
		miPicker.sourceType = UIImagePickerController.SourceType.photoLibrary
		present(miPicker, animated: true, completion: nil)
	}
	
	func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
		
		picker.dismiss(animated: true, completion: nil)
		print("Calling recognize text")
		recognizeText(image: info[UIImagePickerController.InfoKey.originalImage] as? UIImage)
	}
	
	func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
		picker.dismiss(animated: true, completion: nil)
	}
	
	
	
	private func recognizeText(image: UIImage?){
		guard let cgImage = image?.cgImage else {return}
		// Handler
		let handler = VNImageRequestHandler(cgImage: cgImage, options: [:])
		// Request
		let request = VNRecognizeTextRequest {request, error in
			guard let observations = request.results as? [VNRecognizedTextObservation],
						error == nil else{
				return
			}
			
			// Version 1
			//print(observations.compactMap({$0.topCandidates(1).first?.string}))
			//print("vacuna")
			//print(observations.compactMap({$0.topCandidates(1).first?.string})[27])
			self.vacunaNomb.text = observations.compactMap({$0.topCandidates(1).first?.string})[27]
			//print("fecha")
			//print(observations.compactMap({$0.topCandidates(1).first?.string})[21])
			self.fecha.text = observations.compactMap({$0.topCandidates(1).first?.string})[21]
			//print("nombre")
			//print(observations.compactMap({$0.topCandidates(1).first?.string})[13])
			self.numDosis.text = observations.compactMap({$0.topCandidates(1).first?.string})[13]

			
			// Version 2
			
		}
		// Processs
		do {
			try handler.perform([request])
		} catch {
			print(error)
		}
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
