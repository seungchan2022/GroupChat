import Architecture
import LinkNavigator
import SwiftUI

// MARK: - AppMain

struct AppMain {

  let viewModel: AppViewModel

}

// MARK: View

extension AppMain: View {
  var body: some View {
    LinkNavigationView(
      linkNavigator: viewModel.linkNavigator,
      item: .init(path: Link.Dashboard.Path.sample.rawValue, items: .none),
      prefersLargeTitles: true)
      .ignoresSafeArea()
  }
}
