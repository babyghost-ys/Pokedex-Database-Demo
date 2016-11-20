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
    
    var name: String {
        return _name
    }
    
    var pokeID: Int {
        return _pokeID
    }
    
    init(name: String, ID: Int) {
        self._name = name
        self._pokeID = ID
        
    }
}
