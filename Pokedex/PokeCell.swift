//
//  PokeCell.swift
//  Pokedex
//
//  Created by Peter Leung on 20/11/2016.
//  Copyright © 2016 winandmac Media. All rights reserved.
//

import UIKit

class PokeCell: UICollectionViewCell {
    
    @IBOutlet weak var thumbImg: UIImageView!
    @IBOutlet weak var pokeLabel: UILabel!
    
    var pokemon: Pokemon!
    
    func configureCell(pokemon: Pokemon){
        self.pokemon = pokemon
        pokeLabel.text = self.pokemon.name.capitalized
        thumbImg.image = UIImage(named: "\(self.pokemon.pokeID)")
    }
    
    
}
