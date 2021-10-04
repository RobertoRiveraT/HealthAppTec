//
//  NewsViewController.swift
//  HealthApp
//
//  Created by user190113 on 10/4/21.
//

import UIKit

class NewsViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource  {
    var data = [Noticia]()
    var imgArr:[String] = []
    var noticiaControlador = NoticiaControlador()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        noticiaControlador.fetchNews{(resultado) in
            switch resultado{
            case .success(let listaNoticias):
                self.data = listaNoticias
            case .failure(let err):
                self.displayError(err: err)
            }
        }
        // Do any additional setup after loading the view.
    }

    
    func displayError(err: Error){
        DispatchQueue.main.async {
            let alerta = UIAlertController(title: "Error", message: err.localizedDescription, preferredStyle: .alert)
            alerta.addAction(UIAlertAction(title: "Close", style: .default, handler: nil))
            self.present(alerta, animated: true, completion: nil)
        }
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        print("Number of sections ", data.count)
        return data.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "NewsCollectionViewCell", for: indexPath) as! NewsCollectionViewCell
        cell.fuente.text = self.data[indexPath.row].fuente
        cell.titulo.text = self.data[indexPath.row].titulo
        cell.destinyURL = self.data[indexPath.row].url
        fetchImages(url: self.data[indexPath.row].imagen_url, imgView: cell.imagen)
        return cell
    }
    
    func fetchImages(url:String, imgView: UIImageView){
        guard let destinyURL = URL(string: url)else{
            return
        }
        let getDataTask = URLSession.shared.dataTask(with: destinyURL) { data, _, error in
            guard let data = data, error == nil else {
                return
            }
            DispatchQueue.main.async {
                let image = UIImage(data:data)
                imgView.image = image
            }
            
        }
        getDataTask.resume()
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
