import UIKit
import WebKit
import OSLog

class SchoolWebViewController: UIViewController {

    private let logger = Logger()
    private var webView: WKWebView!

    override func viewDidLoad() {
        super.viewDidLoad()

        setupWebView()

        if let url = URL(string: "https://www.cbnucoop.com/service/restaurant") {
            let request = URLRequest(url: url)
            webView.load(request)
        }
    }

    private func setupWebView() {
        webView = WKWebView(frame: view.bounds)
        webView.translatesAutoresizingMaskIntoConstraints = false
        webView.navigationDelegate = self
        view.addSubview(webView)

        NSLayoutConstraint.activate([
            webView.topAnchor.constraint(equalTo: view.topAnchor),
            webView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            webView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            webView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
}

extension SchoolWebViewController: WKNavigationDelegate {
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction,
                 decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        decisionHandler(.allow)
    }
}
