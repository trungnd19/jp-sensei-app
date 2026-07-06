import UIKit
import SwiftUI

/// Entry point for the Share Extension
/// Bridges UIKit (required by iOS) to SwiftUI
class ShareViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let sharedText = extractSharedText()
        let hostingView = UIHostingController(rootView: ShareExtensionView(
            inputText: sharedText,
            onDismiss: { [weak self] in
                self?.dismissExtension()
            }
        ))

        addChild(hostingView)
        view.addSubview(hostingView.view)
        hostingView.view.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            hostingView.view.topAnchor.constraint(equalTo: view.topAnchor),
            hostingView.view.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            hostingView.view.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            hostingView.view.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])

        hostingView.didMove(toParent: self)
    }

    private func extractSharedText() -> String? {
        guard let items = extensionContext?.inputItems as? [NSExtensionItem] else {
            return nil
        }

        for item in items {
            guard let attachments = item.attachments else { continue }
            for provider in attachments {
                if provider.hasItemConformingToTypeIdentifier("public.plain-text") {
                    let semaphore = DispatchSemaphore(value: 0)
                    var result: String?

                    provider.loadItem(forTypeIdentifier: "public.plain-text", options: nil) { data, _ in
                        if let text = data as? String {
                            result = text
                        }
                        semaphore.signal()
                    }

                    semaphore.wait()
                    if let text = result, !text.isEmpty {
                        return text
                    }
                }
            }
        }

        return nil
    }

    private func dismissExtension() {
        extensionContext?.completeRequest(returningItems: nil)
    }
}
