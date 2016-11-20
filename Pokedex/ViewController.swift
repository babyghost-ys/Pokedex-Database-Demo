//
//  ViewController.swift
//  Pokedex
//
//  Created by Peter Leung on 20/11/2016.
//  Copyright © 2016 winandmac Media. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UISearchBarDelegate {

    @IBOutlet weak var pokeCollectionView: UICollectionView!
    @IBOutlet weak var searchPokemon: UISearchBar!
    
    var pokemon = [Pokemon]()
    var filteredPokemon = [Pokemon]()
    var inSearch = false
    var musicPlayer: AVAudioPlayer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        pokeCollectionView.delegate = self
        pokeCollectionView.dataSource = self
        searchPokemon.delegate = self
        searchPokemon.returnKeyType = .done
        
        parsePokemonCSV()
        initAudio()
    }
    
    func initAudio(){
        let path = Bundle.main.path(forResource: "music", ofType: "mp3")!
        do {
            musicPlayer = try AVAudioPlayer(contentsOf: URL(string: path)!)
            musicPlayer.prepareToPlay()
            musicPlayer.numberOfLoops = -1 //continuously
            musicPlayer.play()
        } catch {
            
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func parsePokemonCSV(){
        let path = Bundle.main.path(forResource: "pokemon", ofType: "csv")!
        do {
            let csvFile = try CSV(contentsOfURL: path)
            let rows = csvFile.rows
            
            for row in rows {
                let pokeID = Int(row["id"]!)!
                let name = row["identifier"]!
                
                let poke = Pokemon(name: name, ID: pokeID)
                pokemon.append(poke)
                
            }
        } catch let error as NSError {
            print(error.localizedDescription)
        }
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PokeCell", for: indexPath) as? PokeCell {
            let poke: Pokemon!
            if inSearch{
                poke = filteredPokemon[indexPath.row]
                cell.configureCell(poke)
            } else {
                poke = pokemon[indexPath.row]
                cell.configureCell(poke)
            }

            return cell
        } else {
            return UICollectionViewCell()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        var clickedPoke: Pokemon!
        
        if inSearch{
            clickedPoke = filteredPokemon[indexPath.row]
        } else {
            clickedPoke = pokemon[indexPath.row]
        }
        
        performSegue(withIdentifier: "showDetail", sender: clickedPoke)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetail" {
            if let detailsViewController = segue.destination as? DetailVC {
                if let poke = sender as? Pokemon {
                    detailsViewController.receivedPokemon = poke
                }
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if inSearch {
            return filteredPokemon.count
        }
        return pokemon.count
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 105, height: 105)
    }
    
    @IBAction func musicPlayButtonPressed(_ sender: UIButton) {
        if musicPlayer.isPlaying {
            musicPlayer.pause()
            sender.alpha = 0.2
        } else {
            musicPlayer.play()
            sender.alpha = 1.0
        }
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        view.endEditing(true)
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchPokemon.text == nil || searchPokemon.text == "" {
            inSearch = false
            pokeCollectionView.reloadData()
            self.view.endEditing(true)
        } else {
            inSearch = true
            
            let loweredSearchString = searchPokemon.text!.lowercased()
            filteredPokemon = pokemon.filter({ $0.name.range(of: loweredSearchString) != nil }) //$0 is the placeholder
            pokeCollectionView.reloadData()
        }
    }
}

