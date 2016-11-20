//
//  Pokemon.swift
//  Pokedex
//
//  Created by Peter Leung on 20/11/2016.
//  Copyright © 2016 winandmac Media. All rights reserved.
//

import Foundation

class Pokemon {
    fileprivate var _name: String!
    fileprivate var _pokeID: Int!
    private var _description: String!
    private var _type: String!
    private var _defense: String!
    private var _height: String!
    private var _weight: String!
    private var _attack: String!
    private var _nextEvoTxt: String!
    private var _pokemonURL: String!
    
    var name: String {
        return _name
    }
    
    var pokeID: Int {
        return _pokeID
    }
    
    init(name: String, ID: Int) {
        self._name = name
        self._pokeID = ID
        
        self._pokemonURL = "\(URL_BASE)\(URL_POKEMON)\(self._pokeID)"
    }
    
    func downloadPokemonDetails(completed: DownloadComplete) {
        
    }
}
