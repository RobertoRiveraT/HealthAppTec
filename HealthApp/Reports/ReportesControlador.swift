//
//  ReportesControlador.swift
//  HealthApp
//
//  Created by user194251 on 11/3/21.
//

import Foundation
import Firebase


class ReportesControlador{

    let db = Firestore.firestore()
    
   /*
    func fetchRazas(completion: @escaping (Result<[Raza],Error>)->Void){
        
        var lista_razas = [Raza]()
        
        db.collection("razas").getDocuments() { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
                completion(.failure(err))
            } else {
                for document in querySnapshot!.documents {
                    var r = Raza(d: document)
                    lista_razas.append(r)
                    
                }
                completion(.success(lista_razas))
            }
        }

        
        
    }
    
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
    }*/
    
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
}

