import UIKit
import SDWebImage

// MARK: - Me Display Logic Protocol

protocol MeDisplayLogic: AnyObject {
    func displayProfile(viewModel: Me.LoadProfile.ViewModel)
}

// MARK: - Me View Controller

final class MeViewController: UIViewController {
    
    // MARK: IBOutlets
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var firstNameLabel: UILabel!
    @IBOutlet weak var lastNameLabel: UILabel!
    @IBOutlet weak var dobLabel: UILabel!
    @IBOutlet weak var ageLabel: UILabel!
    @IBOutlet weak var genderImageView: UIImageView!
    @IBOutlet weak var nationalityLabel: UILabel!
    @IBOutlet weak var phoneLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var reloadButton: UIButton!
    
    // MARK: IBAction
    @IBAction func reloadButtonTapped(_ sender: UIButton) {
        loadProfile()
    }
    
    // MARK: Properties
    var interactor: MeBusinessLogic?
    var router: (NSObjectProtocol & MeRoutingLogic & MeDataPassing)?
    
    // MARK: Setup
    
    private func setup() {
        let viewController = self
        let interactor = MeInteractor()
        let presenter = MePresenter()
        let router = MeRouter()
        let worker = MeWorker()
        
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        interactor.worker = worker
        presenter.viewController = viewController
        router.viewController = viewController
        router.dataStore = interactor
    }
    
    private func setupUI() {
        profileImageView.makeCircular()
    }
    
    // MARK: View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        setupUI()
        loadProfile()
    }
    
    // MARK: Request Methods
    private func loadProfile() {
        showLoading()
        let request = Me.LoadProfile.Request()
        interactor?.loadProfile(request: request)
    }
    
    // MARK: Display Logic
    private func showLoading() {
        showModalLoading(message: "Loading profile...")
    }
    
    private func hideLoading() {
        dismiss(animated: true)
    }
    
    private func showError(message: String) {
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
    
    // MARK: Private Methods
    private func loadImage(from urlString: String) {
        let options: SDWebImageOptions = [
            .retryFailed,
            .refreshCached,
            .progressiveLoad
        ]
        
        profileImageView.sd_setImage(
            with: URL(string: urlString),
            placeholderImage: UIImage(named: "profile_sample"),
            options: options
        )
    }
    
    private func getGenderImageName(for gender: String) -> String {
        return gender.lowercased() == "male" ? "male-gender" : "female-gender"
    }
    
}

// MARK: - Display Logic Extension
extension MeViewController: MeDisplayLogic {
    
    func displayProfile(viewModel: Me.LoadProfile.ViewModel) {
        DispatchQueue.main.async { [weak self] in
            self?.hideLoading()
            
            if let errorMessage = viewModel.errorMessage {
                self?.showError(message: errorMessage)
                return
            }
            
            guard let displayedProfile = viewModel.displayedProfile else { return }
            
            self?.titleLabel.text = displayedProfile.title
            self?.firstNameLabel.text = displayedProfile.firstName
            self?.lastNameLabel.text = displayedProfile.lastName
            self?.dobLabel.text = displayedProfile.dateOfBirth
            self?.ageLabel.text = displayedProfile.age
            self?.nationalityLabel.text = displayedProfile.nationality
            self?.phoneLabel.text = displayedProfile.phone
            self?.addressLabel.text = displayedProfile.address
            
            if let genderImageName = self?.getGenderImageName(for: displayedProfile.gender) {
                self?.genderImageView.image = UIImage(named: genderImageName)
            }
            
            self?.loadImage(from: displayedProfile.profileImageURL)
        }
    }
    
} 
