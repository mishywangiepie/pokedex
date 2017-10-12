//
//  CategoryViewController.swift
//  PokedexLab
//
//  Created by SAMEER SURESH on 2/25/17.
//  Copyright © 2017 iOS Decal. All rights reserved.
//

import UIKit

class CategoryViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var pokemonArray: [Pokemon]?
    var cachedImages: [Int:UIImage] = [:]
    var selectedIndexPath: IndexPath?
    var pokemon: Pokemon?
    var pokeimage: UIImage?
    var selectedCell: pokemonTableViewCell?
    @IBOutlet weak var table: UITableView!

   override func viewDidLoad() {
        super.viewDidLoad()
        table.delegate = self
        table.dataSource = self
        print(self.pokemonArray!.count)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
   func tableView(_ tableView: UITableView,
                  numberOfRowsInSection section: Int) -> Int {
      return pokemonArray!.count
   }
   func tableView(_ tableView: UITableView,
                  cellForRowAt indexPath: IndexPath) -> UITableViewCell {
      let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath) as! pokemonTableViewCell
      let pokemon = pokemonArray![indexPath.row]
      cell.name.text = pokemon.name!
      cell.number.text = "#" + String(describing: pokemon.number!)
      cell.stats.text = String(describing: pokemon.attack!) + "/" + String(describing: pokemon.defense!) + "/" + String(describing: pokemon.health!)

      if let image = cachedImages[indexPath.row] {
         DispatchQueue.main.async {
            cell.pic.image = image // may need to change this if you named your image view something different!
         }
      } else {
         let url = URL(string: pokemon.imageUrl)!
         let session = URLSession(configuration: .default)
         let downloadPicTask = session.dataTask(with: url) { (data, response, error) in
            if let e = error {
               print("Error downloading picture: \(e)")
            } else {
               if let _ = response as? HTTPURLResponse {
                  if let imageData = data {
                     let image = UIImage(data: imageData)
                     self.cachedImages[indexPath.row] = image
                     DispatchQueue.main.async {
                        cell.pic.image = UIImage(data: imageData) // may need to change this if you named your image view something different!
//                        self.pokeimage = UIImage(data: imageData)
                     }
                  }
                  else {
                     print("Couldn't get image: Image is nil")
                  }
               } else {
                  print("Couldn't get response code")
               }
            }
         }
         downloadPicTask.resume()
      }
      cell.pokemon = pokemon

      return cell
   }
   func tableView(_ tableView: UITableView,
                  didSelectRowAt indexPath: IndexPath) {
      self.selectedIndexPath = indexPath
      self.selectedCell = table.cellForRow(at: self.selectedIndexPath!) as? pokemonTableViewCell
      self.performSegue(withIdentifier: "toinfo", sender: self)
   }
   override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
      if segue.identifier == "toinfo" {
         if let nextVC = segue.destination as? PokemonInfoViewController {
            nextVC.pokemon = self.selectedCell?.pokemon
            nextVC.image = self.selectedCell?.pic.image
         }
      }
   }
}
