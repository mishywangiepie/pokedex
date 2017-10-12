//
//  pokemonTableViewCell.swift
//  PokedexLab
//
//  Created by Michelle Wang on 10/4/17.
//  Copyright © 2017 iOS Decal. All rights reserved.
//

import UIKit

class pokemonTableViewCell: UITableViewCell {

   @IBOutlet weak var name: UILabel!
   @IBOutlet weak var number: UILabel!
   @IBOutlet weak var stats: UILabel!
   @IBOutlet weak var pic: UIImageView!

   var pokemon: Pokemon?
   override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
