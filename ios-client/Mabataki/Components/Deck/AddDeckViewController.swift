import PureLayout

class AddDeckViewController: UIViewController {
    // MARK: Properties
    private let router: Router
    private let deckRepository: DeckRepository

    // MARK: View Elements
    let titleTextField: UITextField
    let titleTextFieldHeaderLabel: UILabel

    // MARK: Initializers
    init(router: Router, deckRepository: DeckRepository) {
        self.router = router
        self.deckRepository = deckRepository

        self.titleTextField = UITextField.newAutoLayoutView()
        self.titleTextFieldHeaderLabel = UILabel.newAutoLayoutView()

        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: View Controller Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor(white: 240.0/256.0, alpha: 1.0)
        self.title = "Add Deck"

        configureNavigationBar()
        addSubviews()
        configureSubviews()
        addConstraints()
    }

    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)

        titleTextField.becomeFirstResponder()
    }

    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)

        self.becomeFirstResponder()
    }

    // MARK: View Setup
    private func configureNavigationBar() {
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(
            title: "Close",
            style: .Plain,
            target: self,
            action: #selector(dismissSelfAsPresentedViewController)
        )

        self.navigationItem.rightBarButtonItem = UIBarButtonItem(
            title: "Save",
            style: .Plain,
            target: self,
            action: #selector(createDeckWithEnteredAttributes)
        )
    }

    private func addSubviews() {
        self.view.addSubview(titleTextFieldHeaderLabel)
        self.view.addSubview(titleTextField)
    }

    private func configureSubviews() {
        titleTextFieldHeaderLabel.text = "Title"

        titleTextField.backgroundColor = UIColor.whiteColor()
    }

    private func addConstraints() {
        titleTextFieldHeaderLabel.autoPinToTopLayoutGuideOfViewController(
            self,
            withInset: 10.0
        )
        titleTextFieldHeaderLabel.autoPinEdgeToSuperviewEdge(.Leading)
        titleTextFieldHeaderLabel.autoPinEdgeToSuperviewEdge(.Trailing)

        titleTextField.autoPinEdge(
            .Top,
            toEdge: .Bottom,
            ofView: titleTextFieldHeaderLabel
        )
        titleTextField.autoPinEdgeToSuperviewEdge(.Leading)
        titleTextField.autoPinEdgeToSuperviewEdge(.Trailing)
        titleTextField.autoSetDimension(.Height, toSize: 50.0)
    }

    // MARK: Actions
    @objc private func dismissSelfAsPresentedViewController() {
        router.dismissPresentedViewController()
    }

    @objc private func createDeckWithEnteredAttributes() {
        deckRepository.createDeck(titleTextField.text!)
        dismissSelfAsPresentedViewController()
    }
}