import UIKit
import SwiftUI

/// Entry point for the Share Extension
/// Bridges UIKit (required by iOS) to SwiftUI
class ShareViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let hostingView = UIHostingController(rootView: ShareExtensionView(
            textProvider: { [weak self] in
                await self?.extractSharedText()
            },
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

    /// Extract shared text using async/await — no deadlock risk
    private func extractSharedText() async -> String? {
        guard let items = extensionContext?.inputItems as? [NSExtensionItem] else {
            return nil
        }

        for item in items {
            guard let attachments = item.attachments else { continue }
            for provider in attachments {
                if provider.hasItemConformingToTypeIdentifier("public.plain-text") {
                    do {
                        let data = try await provider.loadItem(forTypeIdentifier: "public.plain-text")
                        if let text = data as? String, !text.isEmpty {
                            return text
                        }
                    } catch {
                        continue
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
