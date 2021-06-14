//
//  SiteViewController.swift
//  ChaynsClone
//
//  Created by Driesch, Leonhard on 11.06.21.
//

import UIKit
import WebKit

class SiteViewController: UIViewController {
    var mainView: SiteView! { return self.view as? SiteView }

    override func loadView() {
        view = SiteView(frame: UIScreen.main.bounds)
    }

    public var domain: String?

    override func viewDidLoad() {
        super.viewDidLoad()

        if let url = URL(string: domain ?? ""), let request = try? URLRequest(
            url: url,
            method: .get,
            headers: ["Authorization": "Bearer \(TokenService.instance.token)"]
        ) {
            mainView.webView.load(request)
        }
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setNeedsStatusBarAppearanceUpdate()
    }

    override var preferredStatusBarStyle: UIStatusBarStyle {
        .lightContent
    }
}

class SiteView: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setup() {
        setupViews()
        setupConstraints()
    }

    func setupViews() {
        addSubview(webView)
    }

    func setupConstraints() {
        webView.pinEdges(to: self)
    }

    // MARK: - Views

    let webView: WKWebView = {
        let view = WKWebView()
        return view
    }()
}
