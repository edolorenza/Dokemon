//
//  ViewController.swift
//  Dokemon
//
//  Created by Edo Lorenza on 20/06/21.
//

import UIKit

class MainViewController: UIViewController {
    
    //MARK: -Properties
    private var pokemon = [PokemonResponse]()
    
    private let collectionView: UICollectionView = UICollectionView(
        frame: .zero,
        collectionViewLayout: UICollectionViewCompositionalLayout(sectionProvider: { _, _ -> NSCollectionLayoutSection? in
            let item = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1)))

            item.contentInsets = NSDirectionalEdgeInsets(
                top: 2,
                leading: 16,
                bottom: 2,
                trailing: 16
            )

            let group = NSCollectionLayoutGroup.horizontal(
                layoutSize: NSCollectionLayoutSize(
                    widthDimension: .fractionalWidth(1),
                    heightDimension: .absolute(140)),
                subitem: item,
                count: 2
            )

            group.contentInsets = NSDirectionalEdgeInsets(
                top: 4,
                leading: 0,
                bottom: 4,
                trailing: 0
            )

            return NSCollectionLayoutSection(group: group)
        })
    )

    //MARK: -lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.tintColor = .white
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        
        title = "Dokemon"
        view.backgroundColor = .systemBackground
        setupCollectionView()
        fetchData()
    
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        collectionView.backgroundColor = .secondarySystemBackground
        collectionView.frame = view.bounds
    }

    //MARK: - API
    private func fetchData(){
        APICaller.shared.getPokemonList {[weak self] result in
          
            DispatchQueue.main.async {
                switch result {
                case .success(let dokemon):
                    self?.pokemon = dokemon
                    self?.collectionView.reloadData()
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
            
        }
    }
    
    //MARK: - Helpers
    private func setupCollectionView(){
        view.addSubview(collectionView)
        collectionView.register(MainCollectionViewCell.self,
                                forCellWithReuseIdentifier: MainCollectionViewCell.identifier)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = .systemBackground
    }

}

//MARK: - UICollectionViewDelegate
extension MainViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let pokemon = pokemon[indexPath.row]
        let vc = DetailPokemonViewController()
        vc.viewModel = PokemonViewModel(pokemon: pokemon)
        navigationController?.pushViewController(vc, animated: true)
    }
}

//MARK: - UICollectionViewDataSource
extension MainViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return pokemon.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: MainCollectionViewCell.identifier,
                for: indexPath
        ) as? MainCollectionViewCell else {
            return UICollectionViewCell()
        }
        let pokemon = pokemon[indexPath.row]
    
        cell.viewModel = PokemonViewModel(pokemon: pokemon)
        return cell
    }
}

