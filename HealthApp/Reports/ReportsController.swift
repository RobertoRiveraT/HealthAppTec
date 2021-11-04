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

    
    func fetchReports(completion: @escaping (Result<Reports,Error>)->Void){
        var lista_reportes = [Report]()
        
        db.collection("reportes").getDocuments() { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
                completion(.failure(err))
            } else {
                for document in querySnapshot!.documents {
                    var r = Report(d: document)
                    lista_reportes.append(r)
                }
                completion(.success(lista_reportes))
            }
        }
    }
}
