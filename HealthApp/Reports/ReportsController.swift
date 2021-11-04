//
//  ReportsController.swift
//  HealthApp
//
//  Created by user191400 on 10/4/21.
//

import Foundation
import Firebase

class ReportsController {
    let db = Firestore.firestore()
//	func fetchReports(completion: @escaping (Result<Reports,Error>)->Void){
//
//    let urlComponents = URLComponents(string: "http://martinmolina.com.mx/202113/tc2024/equipo1/formulario.json")!
//
//	let task = URLSession.shared.dataTask(with: urlComponents.url!) { (data, response, error) in
//			let jsonDecoder = JSONDecoder()
//			if let data = data{
//					do{
//							let reports = try? jsonDecoder.decode([Report].self, from: data)
//							completion(.success(reports!))
//                        print("---------------------------------------------------------------------")
//						print(reports!)
//					}
//					catch{
//							completion(.failure(error))
//					}
//			}
//			else {
//					completion(.failure(error!))
//			}
//
//	}

//	task.resume()
//
//}

	func insertReporte(nuevoReporte:Report, completion: @escaping (Result<String, Error>) -> Void){
			
			var ref: DocumentReference? = nil
			ref = db.collection("reportes").addDocument(data: [
					"nombre":nuevoReporte.nombre,
					"nombre_vacuna":nuevoReporte.nombreVacuna,
					"fechaUltimaVacuna":nuevoReporte.fechaUltimaVacuna,
					"numeroDosis":nuevoReporte.numeroDosis,
					"dolorCabeza":nuevoReporte.dolorCabeza,
					"fiebre":nuevoReporte.fiebre,
					"cuerpoCortado":nuevoReporte.cuerpoCortado,
					"congestionNasal":nuevoReporte.congestionNasal,
					"otro":nuevoReporte.otro,
			]) { err in
					if let err = err {
							print("Error adding document: \(err)")
							completion(.failure(err))
					} else {
							completion(.success("Documento agregado ID: \(ref!.documentID)"))
					}
			}
	}
    
    func fetchReports(completion: @escaping (Result<Reports,Error>)->Void){
        var lista_reportes = [Report]()
        
        db.collection("reportes").getDocuments() { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
                completion(.failure(err))
            } else {
                for document in querySnapshot!.documents {
                    let r = Report(d: document)
                    lista_reportes.append(r)
                }
                completion(.success(lista_reportes))
            }
        }
    }
	
	
 /*
	
	func updateRazas(razaActualizada: Raza,completion: @escaping (Result<String,Error>)->Void){
			db.collection("razas").document(razaActualizada.id).updateData([
																																			"descripcion":razaActualizada.descripcion]){ err in
					if let err = err {
							completion(.failure(err))
					} else{
							completion(.success("Registro modificado"))
					}
					
			}
	}
	
	*/
	func deleteReporte(registroID:String, completion: @escaping (Result<String, Error>) -> Void){
			
			db.collection("reportes").document(registroID).delete() { err in
					if let err = err {
							print("Error removing document: \(err)")
							completion(.failure(err))
					} else {
							print("Document successfully removed!")
							completion(.success("Document successfully removed!"))
					}
			}
	}
}
