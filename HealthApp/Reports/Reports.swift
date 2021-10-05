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
		let imagen: [Imagen]
		let otro: String

		enum CodingKeys: String, CodingKey {
				case nombre
				case nombreVacuna = "nombre_vacuna"
				case fechaUltimaVacuna = "fecha_ultima_vacuna"
				case numeroDosis = "numero_dosis"
				case dolorCabeza = "dolor_cabeza"
				case fiebre
				case cuerpoCortado = "cuerpo_cortado"
				case congestionNasal = "congestion_nasal"
				case imagen, otro
		}
}

// MARK: - Imagen
struct Imagen: Codable {
		let nombre: String
		let url: String
		let medicamento: String
}

typealias Reports = [Report]
