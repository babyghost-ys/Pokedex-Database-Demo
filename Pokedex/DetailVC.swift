//
//  DetailVC.swift
//  Pokedex
//
//  Created by Peter Leung on 20/11/2016.
//  Copyright © 2016 winandmac Media. All rights reserved.
//

import UIKit

class DetailVC: UIViewController {
    
    var receivedPokemon: Pokemon!

    @IBOutlet weak var pokeName: UILabel!
    @IBOutlet weak var pokeImage: UIImageView!
    @IBOutlet weak var pokeDesc: UILabel!
    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var heightLabel: UILabel!
    @IBOutlet weak var weightLabel: UILabel!
    @IBOutlet weak var attackLabel: UILabel!
    @IBOutlet weak var idLabel: UILabel!
    @IBOutlet weak var defenseLabel: UILabel!
    @IBOutlet weak var evoLabel: UILabel!
    @IBOutlet weak var currentEvo: UIImageView!
    @IBOutlet weak var nextEvo: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let img = UIImage(named: "\(receivedPokemon.pokeID)")
        pokeImage.image = img
        currentEvo.image = img
        
        idLabel.text = "\(receivedPokemon.pokeID)"
        // Do any additional setup after loading the view.
        receivedPokemon.downloadPokemonDetails { 
            //With typealias closure, this will be exceuted when download is completed
            self.updateUI()
        }
    }
    
    func updateUI(){
        heightLabel.text = receivedPokemon.height
        weightLabel.text = receivedPokemon.weight
        attackLabel.text = receivedPokemon.attack
        defenseLabel.text = receivedPokemon.defense
        typeLabel.text = receivedPokemon.type
        pokeDesc.text = receivedPokemon.description
        
        if receivedPokemon.nextEvoID == "" {
            evoLabel.text = "No Evolutions"
            nextEvo.isHidden = true
        } else {
            nextEvo.isHidden = false
            nextEvo.image = UIImage(named: receivedPokemon.nextEvoID)
            
            let str = "Next Evolution \(receivedPokemon.nextEvoName) - Level \(receivedPokemon.nextEvoLevel)"
            evoLabel.text = str
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func closeButton(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
