//
//  MainCollectionViewCell.swift
//  Dokemon
//
//  Created by Edo Lorenza on 20/06/21.
//

import UIKit
import SDWebImage

class MainCollectionViewCell: UICollectionViewCell {
    static let identifier = "MainCollectionViewCell"
    
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

    private let nameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = .systemFont(ofSize: 18, weight: .bold)
        return label
    }()
    
    private let typeLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = .systemFont(ofSize: 16, weight: .regular)
        return label
    }()
    
    private let overlayView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.alpha = 0.25
        return view
    }()


    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.layer.cornerRadius = 8
        contentView.layer.masksToBounds = true
        setupView()
    }

    required init?(coder: NSCoder) {
        fatalError()
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        nameLabel.text = nil
        imageView.image = UIImage(systemName: "photo", withConfiguration: UIImage.SymbolConfiguration(pointSize: 50, weight: .regular))
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        contentView.dropShadow()
    }
    
    //MARK: - Helpers
    private func setupView(){
        contentView.addSubview(nameLabel)
        contentView.addSubview(imageView)
        contentView.addSubview(overlayView)
        contentView.addSubview(typeLabel)
        
        nameLabel.anchor(top: topAnchor, left: leftAnchor, paddingTop: 4, paddingLeft: 8)
        
        imageView.anchor(bottom: bottomAnchor, right: rightAnchor, paddingBottom: 4, paddingRight: 4)
        imageView.setDimensions(height: frame.height/1.5, width: frame.width/2.5)
        
        typeLabel.centerY(inView: imageView)
        typeLabel.anchor(left: leftAnchor, paddingLeft: 24)
        
        overlayView.setDimensions(height: 30, width: 70)
        overlayView.layer.cornerRadius = 15
        overlayView.center(inView: typeLabel, yConstant: 0)
        
    }
    
    func configure(){
        guard let color = viewModel?.backgroundColor(forType: viewModel?.type ?? "") else {
            return
        }
        contentView.backgroundColor = color
        imageView.sd_setImage(with: viewModel?.pokemonImg)
        nameLabel.text = viewModel?.name
        typeLabel.text = viewModel?.type
    }
}

