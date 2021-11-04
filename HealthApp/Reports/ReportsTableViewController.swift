//
//  ReportsTableViewController.swift
//  HealthApp
//
//  Created by user191400 on 10/4/21.
//

import UIKit

class ReportsTableViewController: UITableViewController, UISearchResultsUpdating  {
    
    var data = [Report]()
    var reportController = ReportsController()
    var datosFiltrados = [Report]()
    let searchController = UISearchController(searchResultsController: nil)
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
			self.updateGUI()
        
        searchController.searchResultsUpdater = self
        searchController.dimsBackgroundDuringPresentation = false
        searchController.hidesNavigationBarDuringPresentation = false
        tableView.tableHeaderView = searchController.searchBar
    }
	override func viewDidAppear(_ animated: Bool) {
		self.updateGUI()
	}
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.searchController.searchBar.isHidden = false
        self.searchController.searchBar.text = ""
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        
        // si la caja de búsuqeda es vacía, entonces mostrar todos los resultados
        if searchController.searchBar.text! == "" {
            datosFiltrados = data
        } else {
            // Filtrar los resultados de acuerdo al texto escrito en la caja que es obtenido a través del parámetro $0
            //$0 es un objeto tipo Raza
            datosFiltrados = data.filter{
                let s:String = $0.nombre
                return(s.lowercased().contains(searchController.searchBar.text!.lowercased())) }
        }
        
        self.tableView.reloadData()
    }
    

    
    func updateGUI(){
			reportController.fetchReports{(resultado) in
					switch resultado{
					case .success(let reportList):
						DispatchQueue.main.async {
									self.data = reportList
									self.datosFiltrados = reportList
									self.tableView.reloadData()
							}
					case .failure(let err):
							self.displayError(err: err)
					}
			}
			
    }
    
    func displayError(err: Error){
        DispatchQueue.main.async {
            let alerta = UIAlertController(title: "Error", message: err.localizedDescription, preferredStyle: .alert)
            alerta.addAction(UIAlertAction(title: "Close", style: .default, handler: nil))
            self.present(alerta, animated: true, completion: nil)
        }
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
//        print("Number of rows ", data.count)
        return datosFiltrados.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "zelda", for: indexPath)

        // Configure the cell...
        cell.textLabel?.text = datosFiltrados[indexPath.row].nombre
        return cell
    }

    override func prepare(for segue: UIStoryboardSegue, sender:Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        
        if segue.identifier == "reportDetails"{
            self.searchController.searchBar.isHidden = true
            let siguiente = segue.destination as! DetalleReporteViewController
            let indice = self.tableView.indexPathForSelectedRow?.row
            siguiente.report = datosFiltrados[indice!]
        }
    }
	
	@IBAction func editTable(_ sender: UIBarButtonItem) {
		let modoEdicion = self.tableView.isEditing
		self.tableView.setEditing(!modoEdicion, animated: true)
	}
	
	override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath){
		if editingStyle == .delete {
			reportController.deleteReporte(registroID: datosFiltrados[indexPath.row].id){
				(resultado) in
				switch resultado{
				case.success( _): self.updateGUI()
				case .failure(let error): self.displayError(err: error)
				}
			}
		}
	}
}

