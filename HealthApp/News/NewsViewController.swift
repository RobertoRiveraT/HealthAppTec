//
//  NewsViewController.swift
//  HealthApp
//
//  Created by user190113 on 10/4/21.
//

import UIKit

class NewsViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource  {
    var data = [Article]()
    var noticiaControlador = NoticiaControlador()
    var noticiasContador = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        noticiaControlador.fetchNews{(resultado) in
//            switch resultado{
//            case .success(let listaNoticias):
//                self.data = listaNoticias
//            case .failure(let err):
//                self.displayError(err: err)
//            }
//        }
        // Do any additional setup after loading the view.
        APICaller.shared.getTopStories{ result in
            switch result{
            case .success(let listaNoticias):
                self.data = listaNoticias
            case .failure(let error):
                self.displayError(err: error)
            }
        }
        sleep(1)
    }
    
    func displayError(err: Error){
        DispatchQueue.main.async {
            let alerta = UIAlertController(title: "Error", message: err.localizedDescription, preferredStyle: .alert)
            alerta.addAction(UIAlertAction(title: "Close", style: .default, handler: nil))
            self.present(alerta, animated: true, completion: nil)
        }
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.data.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "NewsCollectionViewCell", for: indexPath) as! NewsCollectionViewCell
        cell.fuente.text = self.data[indexPath.row].source.name
        cell.titulo.text = self.data[indexPath.row].title
        cell.destinyURL = self.data[indexPath.row].url!
        fetchImages(url: self.data[indexPath.row].urlToImage!, imgView: cell.imagen)
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
