//
//  NoticiaControlador.swift
//  pruebasPF
//
//  Created by user190113 on 10/3/21.
//

import Foundation

class NoticiaControlador{
    
    func fetchNews(completion: @escaping (Result<Noticias,Error>)->Void){
        
        let urlComponents = URLComponents(string: "http://martinmolina.com.mx/202113/tc2024/equipo1/Noticias.json")!

        let task = URLSession.shared.dataTask(with: urlComponents.url!) { (data, response, error) in
            let jsonDecoder = JSONDecoder()
            if let data = data{
                do{
                    let noticias = try? jsonDecoder.decode([Noticia].self, from: data)
                    completion(.success(noticias!))
                }
                catch{
                    completion(.failure(error))
                }
            }
            else {
                completion(.failure(error!))
            }
            
        }

        task.resume()
        
    }
    
}
