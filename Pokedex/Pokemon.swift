//
//  Pokemon.swift
//  Pokedex
//
//  Created by Peter Leung on 20/11/2016.
//  Copyright © 2016 winandmac Media. All rights reserved.
//

import Foundation
import Alamofire

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
    private var _nextEvoName: String!
    private var _nextEvoID: String!
    private var _nextEvoLevel: String!
    private var _pokemonURL: String!
    
    var nextEvoLevel: String{
        if _nextEvoLevel == nil {
            _nextEvoLevel = ""
        }
        
        return _nextEvoLevel
    }
    
    
    var nextEvoID: String {
        if _nextEvoID == nil {
            _nextEvoID = ""
        }
        
        return _nextEvoID
    }
    
    var nextEvoName: String {
        if _nextEvoName == nil{
            _nextEvoName = ""
        }
        return _nextEvoName
    }
    
    var description: String {
        if _description == nil {
            _description = ""
        }
        
        return _description
    }
    
    var type: String {
        if _type == nil {
            _type = ""
        }
        
        return _type
    }
    
    var defense: String {
        if _defense == nil {
            _defense = ""
        }
        return _defense
    }
    
    var height: String {
        if _height == nil {
            _height = ""
        }
        return _height
    }
    
    var weight: String {
        if _weight == nil {
            _weight = ""
        }
        return _weight
    }
    
    var attack:String {
        if _attack == nil {
            _attack = ""
        }
        return _attack
    }
    
    var nextEvoText:String {
        if _nextEvoTxt == nil {
            _nextEvoTxt = ""
        }
        return _nextEvoTxt
    }
    
    var name: String {
        return _name
    }
    
    var pokeID: Int {
        return _pokeID
    }
    
    init(name: String, ID: Int) {
        self._name = name
        self._pokeID = ID
        
        self._pokemonURL = "\(URL_BASE)\(URL_POKEMON)\(self.pokeID)/"
        print("URL now is \(self._pokemonURL)")
    }
    
    func downloadPokemonDetails(completed: @escaping DownloadComplete) {
        Alamofire.request(_pokemonURL).responseJSON { (response) in
            if let dict = response.result.value as? Dictionary<String, AnyObject>{
                if let weight = dict["weight"] as? String {
                    self._weight = weight
                }
                
                if let height = dict["height"] as? String {
                    self._height = height
                }
                
                if let attack = dict["attack"] as? Int {
                    self._attack = "\(attack)"
                }
                
                if let defense = dict["defense"] as? Int {
                    self._defense = "\(defense)"
                }
                
                if let types = dict["types"] as? [Dictionary<String, String>], types.count > 0 {
                    if let name = types[0]["name"] {
                        self._type = name.capitalized
                    }
                    
                    if types.count > 1 {
                        for x in 1..<types.count {
                            if let name = types[x]["name"]{
                                self._type! += "/\(name.capitalized)"
                            }
                        }
                    }
                } else {
                    self._type = ""
                }
                
                if let descrArray = dict["descriptions"] as? [Dictionary<String, String>], descrArray.count > 0 {
                    if let url = descrArray[0]["resource_uri"]{
                        let desurl = "\(URL_BASE)\(url)"
                        Alamofire.request(desurl).responseJSON(completionHandler: { (response) in
                            if let desDict = response.result.value as? Dictionary<String, AnyObject> {
                                if let descr = desDict["description"] as? String {
                                    let finaldes = descr.replacingOccurrences(of: "POKMON", with: "Pokemon")
                                    self._description = finaldes
                                }
                            }
                            completed()
                        })
                    }
                } else {
                    self._description = ""
                }
                
                if let evoArray = dict["evolutions"] as? [Dictionary<String, AnyObject>], evoArray.count > 0 {
                    if let nextEvo = evoArray[0]["to"] as? String {
                        if nextEvo.range(of: "mega") == nil { //Disable Mega Pokemon Only
                            self._nextEvoName = nextEvo
                            
                            if let uri = evoArray[0]["resource_uri"] as? String {
                                let newStr = uri.replacingOccurrences(of: "/api/v1/pokemon/", with: "")
                                let evoID = newStr.replacingOccurrences(of: "/", with: "")
                                self._nextEvoID = evoID
                                
                                if let lvlExist = evoArray[0]["level"] {
                                    self._nextEvoLevel = "\(lvlExist)"
                                } else {
                                    self._nextEvoLevel = ""
                                }
                            }
                        }
                        
                    }
                }
                
            }
            
            completed()
            
        }
    }
}
