//
//  PetDetailsViewController.swift
//  TestingAlamofire
//
//  Created by Ahmad Musallam on 04/03/2024.
//
import UIKit
import SnapKit
import Kingfisher
import QuartzCore

class PetDetailsViewController: UIViewController {
    
    var pets: Pet?
    
    private let scrollView = UIScrollView()
    private let contentView = UIView()
    private let petImageView = UIImageView()
    private let detailsCardView = UIView()
    private let petNameLabel = UILabel()
    private let petDetailsStackView = UIStackView()
    private let petGenderLabel = UILabel()
    private let petAdoptedLabel = UILabel()
    private let petAgeLabel = UILabel()
    private let petIDLabel = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupScrollView()
        setupLayout()
        configureWithPet()
        setGradientBackground()
        // check on this 
        let appearance = UINavigationBarAppearance()
        appearance.configureWithDefaultBackground()
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
    }
    
    private func setupViews() {
        
        view.backgroundColor = .white
        scrollView.showsVerticalScrollIndicator = false
        view.addSubview(scrollView)
        
        
        scrollView.addSubview(contentView)
        
        petImageView.contentMode = .scaleAspectFill
        petImageView.clipsToBounds = true
        petImageView.layer.cornerRadius = 16
        contentView.addSubview(petImageView)
        
        
        detailsCardView.backgroundColor = UIColor.systemBackground
        detailsCardView.layer.cornerRadius = 16
        detailsCardView.layer.shadowColor = UIColor.black.cgColor
        detailsCardView.layer.shadowOpacity = 0.1
        detailsCardView.layer.shadowOffset = CGSize(width: 0, height: 2)
        detailsCardView.layer.shadowRadius = 8
        contentView.addSubview(detailsCardView)
        
        petNameLabel.font = UIFont.preferredFont(forTextStyle: .title1)
        petNameLabel.adjustsFontForContentSizeCategory = true
        detailsCardView.addSubview(petNameLabel)
        
        
        petDetailsStackView.axis = .vertical
        petDetailsStackView.distribution = .equalSpacing
        petDetailsStackView.spacing = 8
        detailsCardView.addSubview(petDetailsStackView)
        
        
        petGenderLabel.font = UIFont.preferredFont(forTextStyle: .body)
        petGenderLabel.adjustsFontForContentSizeCategory = true
        petAdoptedLabel.font = UIFont.preferredFont(forTextStyle: .body)
        petAdoptedLabel.adjustsFontForContentSizeCategory = true
        petAgeLabel.font = UIFont.preferredFont(forTextStyle: .body)
        petAgeLabel.adjustsFontForContentSizeCategory = true
        petIDLabel.font = UIFont.preferredFont(forTextStyle: .body)
        petIDLabel.adjustsFontForContentSizeCategory = true
        
        petDetailsStackView.addArrangedSubview(petGenderLabel)
        petDetailsStackView.addArrangedSubview(petAdoptedLabel)
        petDetailsStackView.addArrangedSubview(petAgeLabel)
        petDetailsStackView.addArrangedSubview(petIDLabel)
    }
    
    
    private func setupScrollView() {
        scrollView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
        
        contentView.snp.makeConstraints { make in
            make.edges.equalTo(scrollView)
            make.width.equalTo(scrollView)
        }
    }
    
    private func setupLayout() {
        petImageView.snp.makeConstraints { make in
            make.top.equalTo(contentView).offset(20)
            make.left.right.equalTo(contentView).inset(20)
            make.height.equalTo(petImageView.snp.width).multipliedBy(0.75)
        }
        
        detailsCardView.snp.makeConstraints { make in
            make.top.equalTo(petImageView.snp.bottom).offset(20)
            make.left.right.equalTo(contentView).inset(20)
            
        }
        
        petNameLabel.snp.makeConstraints { make in
            make.top.equalTo(detailsCardView).offset(20)
            make.left.right.equalTo(detailsCardView).inset(20)
        }
        
        petDetailsStackView.snp.makeConstraints { make in
            make.top.equalTo(petNameLabel.snp.bottom).offset(20)
            make.left.right.equalTo(detailsCardView).inset(20)
            make.bottom.equalTo(detailsCardView).offset(-20)
        }
    }
    
    let imageView = UIImageView()

    private func configureWithPet() {
        petIDLabel.text = "ID: \(pets?.id ?? 0)"
        petAgeLabel.text = "Age: \(pets?.age ?? 0) years"
        petNameLabel.text = pets?.name ?? "N/A"
        petGenderLabel.text = "Gender: \(pets?.gender ?? "N/A")"
        petAdoptedLabel.text = "Adopted: \(pets?.adopted ?? false ? "Yes" : "No")"
        let imageUrl = URL(string: pets?.image ?? "")
        petImageView.kf.setImage(with: imageUrl, placeholder: UIImage(named: ""))
    }

    private func setGradientBackground() {
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [UIColor.black.cgColor, UIColor.systemBackground.cgColor]
        gradientLayer.locations = [0.0, 1.0]
        gradientLayer.frame = view.bounds
        view.layer.insertSublayer(gradientLayer, at: 0)
    }
}
