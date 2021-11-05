//
//  Reports.swift
//  HealthApp
//
//  Created by user191400 on 10/4/21.
//

import Foundation
import Firebase

// MARK: - Welcome
struct Report: Codable {
        var id:String
		let nombre, nombreVacuna, fechaUltimaVacuna: String
		let numeroDosis: Int
		let dolorCabeza, fiebre, cuerpoCortado, congestionNasal: Bool
		let otro: String

		enum CodingKeys: String, CodingKey {
                case id = "id"
				case nombre = "nombre"
				case nombreVacuna = "nombre_vacuna"
				case fechaUltimaVacuna = "fechaUltimaVacuna"
				case numeroDosis = "numero_dosis"
				case dolorCabeza = "dolorCabeza"
				case fiebre = "fiebre"
				case cuerpoCortado = "cuerpo_cortado"
				case congestionNasal = "congestion_nasal"
				case otro = "otro"
		}
    
    init(id:String, nombre:String, nombreVacuna:String, fechaUltimaVacuna:String, numeroDosis: Int,
         dolorCabeza: Bool, fiebre: Bool, cuerpoCortado: Bool, congestionNasal: Bool, otro:String) {
        self.nombre = nombre
        self.nombreVacuna = nombreVacuna
        self.fechaUltimaVacuna = fechaUltimaVacuna
        self.numeroDosis = numeroDosis
        self.dolorCabeza = dolorCabeza
        self.fiebre = fiebre
        self.cuerpoCortado = cuerpoCortado
        self.congestionNasal = congestionNasal
        self.otro = otro
        self.id = id
    }
    
    init(nombre:String, nombreVacuna:String, fechaUltimaVacuna:String, numeroDosis: Int,
         dolorCabeza: Bool, fiebre: Bool, cuerpoCortado: Bool, congestionNasal: Bool, otro:String) {
        self.nombre = nombre
        self.nombreVacuna = nombreVacuna
        self.fechaUltimaVacuna = fechaUltimaVacuna
        self.numeroDosis = numeroDosis
        self.dolorCabeza = dolorCabeza
        self.fiebre = fiebre
        self.cuerpoCortado = cuerpoCortado
        self.congestionNasal = congestionNasal
        self.otro = otro
        self.id = "1234"
    }
    
    init(d:DocumentSnapshot){
        self.id = d.documentID
        self.nombre = (d.get("nombre") as? String)!
        self.nombreVacuna = (d.get("nombreVacuna") as? String)!
        self.fechaUltimaVacuna = (d.get("fechaUltimaVacuna") as? String)!
        self.numeroDosis = (d.get("numeroDosis") as? Int)!
        self.dolorCabeza = (d.get("dolorCabeza") as? Bool)!
        self.fiebre = (d.get("fiebre") as? Bool)!
        self.cuerpoCortado = (d.get("cuerpoCortado") as? Bool)!
        self.congestionNasal = (d.get("congestionNasal") as? Bool)!
        self.otro = (d.get("otro") as? String)!
    }
}

// MARK: - Imagen

typealias Reports = [Report]
