//
//  DetailPokemonViewController.swift
//  Dokemon
//
//  Created by Edo Lorenza on 20/06/21.
//

import UIKit

class DetailPokemonViewController: UIViewController {
    
    //MARK: - Properties
    var viewModel: PokemonViewModel? {
        didSet { configure() }
    }
    
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleToFill
        imageView.layer.masksToBounds = true
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private let overlayView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.alpha = 1.0
        view.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
        // Top right corner, Top left corner respectively
        return view
    }()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = .systemFont(ofSize: 24, weight: .bold)
        return label
    }()
    
    private let typeLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = .systemFont(ofSize: 16, weight: .regular)
        return label
    }()
    
    private let overlayTypeLabelView: UIView = {
        let view = UIView()
        view.alpha = 1.0
        view.layer.cornerRadius = 20
        return view
    }()

    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 16, weight: .regular)
        return label
    }()
    
    private let statusLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.text = "Stats"
        label.font = .systemFont(ofSize: 18, weight: .bold)
        return label
    }()

    private let heightLabel: UILabel = {
        let label = UILabel()
        label.textColor = .darkGray
        label.text = "Height"
        label.font = .systemFont(ofSize: 16, weight: .regular)
        return label
    }()
    
    private let attackLabel: UILabel = {
        let label = UILabel()
        label.textColor = .darkGray
        label.text = "Attack"
        label.font = .systemFont(ofSize: 16, weight: .regular)
        return label
    }()
    
    private let defenseLabel: UILabel = {
        let label = UILabel()
        label.textColor = .darkGray
        label.text = "Defense"
        label.font = .systemFont(ofSize: 16, weight: .regular)
        return label
    }()
    
    private let weightLabel: UILabel = {
        let label = UILabel()
        label.textColor = .darkGray
        label.text = "Weight"
        label.font = .systemFont(ofSize: 16, weight: .regular)
        return label
    }()
    
    
    private let heightStatLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = .systemFont(ofSize: 16, weight: .bold)
        return label
    }()
    
    private let attackStatLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = .systemFont(ofSize: 16, weight: .bold)
        return label
    }()
    
    private let defenseStatLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = .systemFont(ofSize: 16, weight: .bold)
        return label
    }()
    
    private let weightStatLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = .systemFont(ofSize: 16, weight: .bold)
        return label
    }()
    
    
    private let overlayStatusHeightView: UIProgressView = {
        let view = UIProgressView(progressViewStyle: .bar)
        view.trackTintColor = .systemGray6
        view.layer.masksToBounds = true
        view.layer.cornerRadius = 10
        view.progressTintColor = .systemYellow
        return view
    }()
    
    private let overlayStatsAttackView: UIProgressView = {
        let view = UIProgressView(progressViewStyle: .bar)
        view.trackTintColor = .systemGray6
        view.layer.masksToBounds = true
        view.layer.cornerRadius = 10
        view.progressTintColor = .systemRed
        return view
    }()
    
    private let overlayStatsDefenseView: UIProgressView = {
        let view = UIProgressView(progressViewStyle: .bar)
        view.trackTintColor = .systemGray6
        view.layer.masksToBounds = true
        view.layer.cornerRadius = 10
        view.progressTintColor = .systemBlue
        return view
    }()
    
    private let overlayStatusWeightView: UIProgressView = {
        let view = UIProgressView(progressViewStyle: .bar)
        view.trackTintColor = .systemGray6
        view.layer.masksToBounds = true
        view.layer.cornerRadius = 10
        view.progressTintColor = .systemPurple
        return view
    }()
    
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemGray
        setupView()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
       
    }
    
    //MARK: - Helpers
    private func setupView(){
        
        view.addSubview(overlayView)
        overlayView.layer.cornerRadius = 40
        overlayView.anchor(left: view.leftAnchor,bottom: view.bottomAnchor, right: view.rightAnchor)
        overlayView.setHeight(view.frame.height - (view.frame.height/3))
        
        view.addSubview(imageView)
        imageView.centerX(inView: overlayView)
        let imageSize = view.frame.width/2
        imageView.setDimensions(height: imageSize, width: imageSize)
        imageView.anchor(bottom: overlayView.topAnchor, paddingBottom: -30)
        
        view.addSubview(nameLabel)
        nameLabel.centerX(inView: imageView)
        nameLabel.anchor(top: imageView.bottomAnchor, paddingTop: 8)
        
        view.addSubview(overlayTypeLabelView)
        overlayTypeLabelView.centerX(inView: imageView)
        overlayTypeLabelView.anchor(top: nameLabel.bottomAnchor, paddingTop: 4)
        overlayTypeLabelView.setDimensions(height: 40, width: 120)
        
        
        view.addSubview(typeLabel)
        typeLabel.center(inView: overlayTypeLabelView)
        typeLabel.anchor(top: nameLabel.bottomAnchor, paddingTop: 4)
        
        view.addSubview(descriptionLabel)
        descriptionLabel.anchor(top: typeLabel.bottomAnchor, left: view.leftAnchor, right: view.rightAnchor, paddingTop: 8, paddingLeft: 8, paddingRight: 8)
        
        
        view.addSubview(statusLabel)
        statusLabel.anchor(top: descriptionLabel.bottomAnchor, left: view.leftAnchor, paddingTop: 6, paddingLeft: 8)
        
        let stackStatusLabel = UIStackView(arrangedSubviews: [heightLabel, attackLabel, defenseLabel, weightLabel])
        stackStatusLabel.distribution = .fillEqually
        stackStatusLabel.axis = .vertical
        stackStatusLabel.spacing = 20
        
        view.addSubview(stackStatusLabel)
        stackStatusLabel.anchor(top: statusLabel.bottomAnchor, left: view.leftAnchor, paddingTop: 8, paddingLeft: 20)
        
    
        let stackStatusValue = UIStackView(arrangedSubviews: [heightStatLabel, attackStatLabel, defenseStatLabel, weightStatLabel])
        stackStatusValue.distribution = .fillEqually
        stackStatusValue.axis = .vertical
        stackStatusValue.spacing = 20
        
        view.addSubview(stackStatusValue)
        stackStatusValue.anchor(top: statusLabel.bottomAnchor, left: stackStatusLabel.rightAnchor, paddingTop: 8, paddingLeft: 8)
        
        let stackStatusBar = UIStackView(arrangedSubviews: [overlayStatusHeightView, overlayStatsAttackView, overlayStatsDefenseView, overlayStatusWeightView])
        stackStatusBar.distribution = .fillEqually
        stackStatusBar.axis = .vertical
        stackStatusBar.spacing = 20

        overlayStatusHeightView.setHeight(20)
        overlayStatsAttackView.setHeight(20)
        overlayStatsDefenseView.setHeight(20)
        overlayStatusWeightView.setHeight(20)
        
    
        view.addSubview(stackStatusBar)
        stackStatusBar.anchor(top: statusLabel.bottomAnchor, left: stackStatusValue.rightAnchor, right: view.rightAnchor, paddingTop: 8, paddingLeft: 16, paddingRight: 24)

    }
    
    func configure(){
        imageView.sd_setImage(with: viewModel?.pokemonImg)
        view.backgroundColor = viewModel?.backgroundColor(forType: viewModel?.type ?? "")
        nameLabel.text = viewModel?.name
        typeLabel.text = viewModel?.type
        overlayTypeLabelView.backgroundColor = viewModel?.backgroundColor(forType: viewModel?.type ?? "")
        descriptionLabel.text = viewModel?.description
        
        heightStatLabel.text = viewModel?.height
        attackStatLabel.text = viewModel?.attack
        defenseStatLabel.text = viewModel?.defense
        weightStatLabel.text = viewModel?.weight
        
        guard let heightStats = viewModel?.heightStats else {
            return
        }
        
        guard let attackStats = viewModel?.attackStats else {
            return
        }
        
        guard let defenseStats = viewModel?.defenseStats else {
            return
        }
        
        guard let weightStats = viewModel?.weightStats else {
            return
        }
        
        overlayStatusHeightView.setProgress(heightStats/200, animated: false)
        overlayStatsAttackView.setProgress(attackStats/200, animated: false)
        overlayStatsDefenseView.setProgress(defenseStats/200, animated: false)
        overlayStatusWeightView.setProgress(weightStats/200, animated: false)
    }
    
}
