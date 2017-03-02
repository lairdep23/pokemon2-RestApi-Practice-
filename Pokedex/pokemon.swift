//
//  pokemon.swift
//  Pokedex
//
//  Created by Evan on 2/27/17.
//  Copyright © 2017 Evan. All rights reserved.
//

import Foundation
import Alamofire

class Pokemon {
    private var _name: String!
    private var _pokeID: Int!
    
    private var _bio: String!
    private var _type: String!
    private var _defense: String!
    private var _height: String!
    private var _weight: String!
    private var _attack: String!
    private var _nextEvo: String!
    private var _pokemonUrl: String!
    
    var name: String {
        return _name
    }
    
    var pokeID: Int {
        return _pokeID
    }
    
    var bio: String {
        if _bio == nil {
            _bio = ""
        }
        return _bio
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
    
    var attack: String {
        if _attack == nil {
            _attack = ""
        }
        return _attack
    }
    
    var nextEvo: String {
        if _nextEvo == nil {
            _nextEvo = ""
        }
        return _nextEvo
    }
    
    init(name: String, pokeID: Int) {
        self._name = name
        self._pokeID = pokeID
        self._pokemonUrl = "\(url_base)\(poke_url)\(self.pokeID)/"
    }
    
    func downloadPokemonDetails(completed: @escaping DownloadComplete){
        
        Alamofire.request(_pokemonUrl).responseJSON { (response) in
            if let dict = response.result.value as? Dictionary<String, AnyObject> {
                if let weight = dict["weight"] as? String {
                    self._weight = weight
                    //print(self._weight)
                }
                
                if let height = dict["height"] as? String {
                    self._height = height
                    //print(self._height)
                }
                
                if let attact = dict["attack"] as? Int {
                    self._attack = "\(attact)"
                    //print(self._attack)
                }
                
                if let defense = dict["defense"] as? Int {
                    self._defense = "\(defense)"
                    //print(self._defense)
                }
                
            }
            completed()
        }
    }
    
    
}
