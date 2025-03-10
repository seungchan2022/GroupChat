import ComposableArchitecture
import SwiftUI

// MARK: - SamplePage

struct SamplePage {
  @Bindable var store: StoreOf<SampleReducer>
}

// MARK: View

extension SamplePage: View {
  var body: some View {
    VStack {
      Spacer()
      Button(action: { store.send(.onTapHome) }) {
        Text("홈으로 이동")
      }

      Text(store.text)

      Button(action: { store.send(.test) }) {
        Text("성공")
      }

      Button(action: { store.send(.test2) }) {
        Text("실패")
      }

      Spacer()
    }
    .onAppear {
      store.send(.getSample)
    }
  }
}
