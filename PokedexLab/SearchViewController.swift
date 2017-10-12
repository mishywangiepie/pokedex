//
//  SearchViewController.swift
//  PokedexLab
//
//  Created by SAMEER SURESH on 2/25/17.
//  Copyright © 2017 iOS Decal. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {

    var pokemonArray: [Pokemon] = []
    var filteredArray: [Pokemon] = []
    @IBOutlet weak var collection: UICollectionView!
    var pokemon: [Pokemon] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        pokemonArray = PokemonGenerator.getPokemonArray()
        collection.delegate = self
        collection.dataSource = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    // Utility function to iterate through pokemon array for a single category
    func filteredPokemon(ofType type: Int) -> [Pokemon] {
        var filtered: [Pokemon] = []
        for pokemon in pokemonArray {
            if (pokemon.types.contains(PokemonGenerator.categoryDict[type]!)) {
                filtered.append(pokemon)
            }
        }
        return filtered
    }

   func collectionView(_ collectionView: UICollectionView,
                       numberOfItemsInSection section: Int) -> Int {
        return pokemonArray.count
   }

   func collectionView(_ collectionView: UICollectionView,
                       cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
      let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "reuseIdentifier", for: indexPath) as! pokemoncellCollectionViewCell
      if let str = PokemonGenerator.categoryDict[indexPath.row]{
         cell.image.image = UIImage(named: str)
      }
      return cell
   }

   func collectionView(_ collectionView: UICollectionView,
                       didSelectItemAt indexPath: IndexPath) {
      pokemon = filteredPokemon(ofType: indexPath.row)
      super.performSegue(withIdentifier: "tocategory", sender: indexPath)

   }
   override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
      if segue.identifier == "tocategory" {
         if let nextVC = segue.destination as? CategoryViewController {
            print(pokemon.count)
            nextVC.pokemonArray = pokemon
         }
      }
   }
}






