//
//  News.swift
//  HealthApp
//
//  Created by user190113 on 10/4/21.
//

struct Noticia: Codable {
    let titulo, fuente, url, imagen_url:String
}

typealias Noticias = [Noticia]

