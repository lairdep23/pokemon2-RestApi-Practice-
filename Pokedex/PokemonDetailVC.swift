//
//  PokemonDetailVC.swift
//  Pokedex
//
//  Created by Evan on 2/28/17.
//  Copyright © 2017 Evan. All rights reserved.
//

import UIKit

class PokemonDetailVC: UIViewController {
    
    var pokemon: Pokemon!

    @IBOutlet weak var namelabel: UILabel!
    @IBOutlet weak var mainImage: UIImageView!
    @IBOutlet weak var bioLabel: UILabel!
    
    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var defenseLabel: UILabel!
    
    @IBOutlet weak var heightLabel: UILabel!
    @IBOutlet weak var weightLabel: UILabel!
    @IBOutlet weak var pokeidLabel: UILabel!
    @IBOutlet weak var attackLabel: UILabel!
    
    @IBOutlet weak var evoLabel: UILabel!
    @IBOutlet weak var currentEvoImg: UIImageView!
    @IBOutlet weak var nextevoImg: UIImageView!
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        namelabel.text = pokemon.name
        pokemon.downloadPokemonDetails {
            self.updateUI()
        }
    }

    @IBAction func backButtion(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    func updateUI(){
        heightLabel.text = pokemon.height
        defenseLabel.text = pokemon.defense
        weightLabel.text = pokemon.weight
        attackLabel.text = pokemon.attack
        
    }
}
