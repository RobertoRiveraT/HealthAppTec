//
//  DetalleReporteViewController.swift
//  HealthApp
//
//  Created by user191400 on 10/4/21.
//

import UIKit

class DetalleReporteViewController: UIViewController {

    var report:Report?
    var dataController = ReportsController()
    @IBOutlet var titleReport: UILabel!
    @IBOutlet weak var vacName: UILabel!
    @IBOutlet weak var dateLastVac: UILabel!
    @IBOutlet weak var numberDose: UILabel!
    @IBOutlet weak var headache: UISwitch!
    @IBOutlet weak var fever: UISwitch!
    @IBOutlet weak var bodyAches: UISwitch!
    @IBOutlet weak var nasalCongestion: UISwitch!
    @IBOutlet var other: UITextView!
    @IBOutlet var saveReportBtn: UIButton!
    @IBOutlet var cancelReportBtn: UIButton!
    var editando = false
    
    @IBOutlet var editBtn: UIBarButtonItem!
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        titleReport.text = report?.nombre
        vacName.text = report?.nombreVacuna
        dateLastVac.text = report?.fechaUltimaVacuna
        numberDose.text = String(report!.numeroDosis)
        headache.setOn(report!.dolorCabeza, animated: true)
        fever.setOn(report!.fiebre, animated: true)
        bodyAches.setOn(report!.cuerpoCortado, animated: true)
        nasalCongestion.setOn(report!.congestionNasal, animated: true)
        other.text = report?.otro
    }
    
    func buttons(editando:Bool){
        if editando{
            saveReportBtn.isHidden = false
            cancelReportBtn.isHidden = false
            editBtn.isEnabled = false
            headache.isUserInteractionEnabled = true
            fever.isUserInteractionEnabled = true
            bodyAches.isUserInteractionEnabled = true
            nasalCongestion.isUserInteractionEnabled = true
            other.isEditable = true
        }else{
            saveReportBtn.isHidden = true
            cancelReportBtn.isHidden = true
            editBtn.isEnabled = true
        }
    }
    
    @IBAction func editAction(_ sender: Any) {
        editando = !editando
        buttons(editando: editando)
    }
    
    
    
    
    @IBAction func saveRerpot(_ sender: UIButton) {
        editando = !editando
        buttons(editando: editando)
        let reportActualizado = Report(id: report!.id, nombre: titleReport.text!, nombreVacuna: vacName.text!, fechaUltimaVacuna: dateLastVac.text!, numeroDosis: Int(numberDose.text!)!, dolorCabeza: headache.isOn, fiebre: fever.isOn, cuerpoCortado: bodyAches.isOn, congestionNasal: nasalCongestion.isOn, otro: other.text!)
        // llamar a la BD con la actualizacion
        
        dataController.updateReports(reporteActualizado: reportActualizado){
            (resultado) in
                switch resultado{
                case .failure(let err):
                    self.displayError(e: err)
                case .success(let exito):
                    self.displayExito(exito: exito)
                }
        }
        let storyBoard = UIStoryboard(name: "Main", bundle:nil)
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "homePage") as! UIViewController
        nextViewController.modalPresentationStyle = .fullScreen
        self.present(nextViewController, animated:true, completion:nil)


    }
    
    
    func displayError(e:Error){
        DispatchQueue.main.async {
            let alerta =  UIAlertController(title: "Error de actualizacion", message: e.localizedDescription, preferredStyle: .alert)
            alerta.addAction(UIAlertAction(title: "Cerrar", style: .default, handler: nil))
            self.present(alerta, animated: true, completion: nil)
        }
    }
    
    func displayExito(exito:String){
        DispatchQueue.main.async {
            let alerta =  UIAlertController(title: "Actualizacion de registro", message: exito, preferredStyle: .alert)
            alerta.addAction(UIAlertAction(title: "Cerrar", style: .default, handler: nil))
            self.present(alerta, animated: true, completion: nil)
        }
    }
    
    @IBAction func cancelRaza(_ sender: UIButton) {
        editando = !editando
        buttons(editando: editando)
    
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
