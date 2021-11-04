//
//  Reports.swift
//  HealthApp
//
//  Created by user191400 on 10/4/21.
//

import Foundation

// MARK: - Welcome
struct Report: Codable {
		let nombre, nombreVacuna, fechaUltimaVacuna: String
		let numeroDosis: Int
		let dolorCabeza, fiebre, cuerpoCortado, congestionNasal: Bool
		let otro: String

		enum CodingKeys: String, CodingKey {
				case nombre = "nombre"
				case nombreVacuna = "nombre_vacuna"
				case fechaUltimaVacuna = "fecha_ultima_vacuna"
				case numeroDosis = "numero_dosis"
				case dolorCabeza = "dolorCabeza"
				case fiebre = "fiebre"
				case cuerpoCortado = "cuerpo_cortado"
				case congestionNasal = "congestion_nasal"
				case otro = "otro"
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
    }
}

// MARK: - Imagen

typealias Reports = [Report]
