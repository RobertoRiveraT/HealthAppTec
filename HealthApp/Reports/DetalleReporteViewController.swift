//
//  DetalleReporteViewController.swift
//  HealthApp
//
//  Created by user191400 on 10/4/21.
//

import UIKit

class DetalleReporteViewController: UIViewController {

    var report:Report?
    @IBOutlet var titleReport: UILabel!
    @IBOutlet weak var vacName: UILabel!
    @IBOutlet weak var dateLastVac: UILabel!
    @IBOutlet weak var numberDose: UILabel!
    @IBOutlet weak var headache: UISwitch!
    @IBOutlet weak var fever: UISwitch!
    @IBOutlet weak var bodyAches: UISwitch!
    @IBOutlet weak var nasalCongestion: UISwitch!
    @IBOutlet var other: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        titleReport.text = report?.nombre
        vacName.text = report?.nombreVacuna
        dateLastVac.text = report?.fechaUltimaVacuna
        numberDose.text = String(report!.numeroDosis)
        headache.setOn(report!.dolorCabeza, animated: true)
        fever.setOn(report!.fiebre, animated: true)
        bodyAches.setOn(report!.dolorCabeza, animated: true)
        nasalCongestion.setOn(report!.congestionNasal, animated: true)
        other.text = report?.otro
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
