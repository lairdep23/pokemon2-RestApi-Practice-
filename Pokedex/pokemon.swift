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
    private var _nextEvoText: String!
    private var _nextEvoID: String!
    private var _nextEvoLevel: String!
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
    
    var nextEvoText: String {
        if _nextEvoText == nil {
            _nextEvoText = ""
        }
        return _nextEvoText
    }
    
    var nextEvoID: String {
        if _nextEvoID == nil {
            _nextEvoID = ""
        }
        
        return _nextEvoID
    }
    
    var nextEvoLevel: String {
        if _nextEvoLevel == nil {
            _nextEvoLevel = ""
        }
        return _nextEvoLevel
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
                
                if let types = dict["types"] as? [Dictionary<String, AnyObject>] , types.count > 0 {
                    if let name = types[0]["name"] as? String {
                        self._type = name.capitalized
                    }
                    
                    if types.count > 1 {
                        for x in 1..<types.count {
                            if let name = types[x]["name"] as? String {
                                self._type! += "/\(name.capitalized)"
                                //print(self._type)
                            }
                        }
                    }
                    
                } else {
                    self._type = "None"
                }
                
                if let evoArray = dict["evolutions"] as? [Dictionary<String,AnyObject>], evoArray.count > 0 {
                    
                    if let evoName = evoArray[0]["to"] as? String{
                        
                        if evoName.range(of: "mega") == nil {
                            
                            self._nextEvo = evoName
                            
                            if let uri = evoArray[0]["resource_uri"] as? String {
                                let newURI = uri.replacingOccurrences(of: "/api/v1/pokemon/", with: "")
                                let nextID = newURI.replacingOccurrences(of: "/", with: "")
                                
                                self._nextEvoID = nextID
                            }
                            
                            if let level = evoArray[0]["level"]{
                                
                                if let lev = level as? Int {
                                    self._nextEvoLevel = "\(lev)"
                                }
                                
                            } else {
                                self._nextEvoLevel = ""
                            }
                        }
                    }
                }
                
                if let descArray = dict["descriptions"] as? [Dictionary<String,AnyObject>] , descArray.count > 0 {
                    
                    if let url = descArray[0]["resource_uri"] as? String {
                        
                        let real_url = "\(url_base)\(url)"
                        
                        Alamofire.request(real_url).responseJSON(completionHandler: { (response) in
                            if let description = response.result.value as? Dictionary<String,AnyObject> {
                                
                                if let desc = description["description"] as? String {
                                    
                                    let newDescription = desc.replacingOccurrences(of: "POKMON", with: "Pokemon")
                                    
                                    self._bio = newDescription
                                    //print(self._bio)
                                }
                            }
                            completed()
                        })
                    }
                    
                }
                
            }
            completed()
        }
    }
    
    
}
