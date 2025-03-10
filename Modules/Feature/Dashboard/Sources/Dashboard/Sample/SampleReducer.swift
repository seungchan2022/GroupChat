import Architecture
import ComposableArchitecture
import Domain
import Foundation

// MARK: - SampleReducer

@Reducer
struct SampleReducer {
  let sideEffect: SampleSideEffect

  var body: some ReducerOf<Self> {
    BindingReducer()
    Reduce { state, action in
      switch action {
      case .binding:
        return .none

      case .teardown:
        return .concatenate(
          CancelID.allCases.map { .cancel(pageID: state.id, id: $0) })

      case .getSample:
        state.fetchSample.isLoading = true
        return sideEffect
          .sample("sample usecase test")
          .cancellable(pageID: state.id, id: CancelID.requestSample, cancelInFlight: true)

      case .fetchSample(let result):
        state.fetchSample.isLoading = true
        switch result {
        case .success(let item):
          state.text = item
          return .none

        case .failure(let error):
          return .run { await $0(.throwError(error)) }
        }

      case .onTapHome:
        sideEffect.routeToHome()
        return .none

      case .test:
        sideEffect.useCaseGroup.toastViewModel.send(message: "성공")
        return .none

      case .test2:
        sideEffect.useCaseGroup.toastViewModel.send(errorMessage: "실패")
        return .none

      case .throwError(let error):
        sideEffect.useCaseGroup.toastViewModel.send(errorMessage: error.displayMessage)
        return .none
      }
    }
  }

}

extension SampleReducer {

  @ObservableState
  struct State: Equatable, Identifiable, Sendable {
    let id: UUID

    init(id: UUID = .init()) {
      self.id = id
    }

    var text = ""
    var fetchSample = FetchState.Data<String?>(isLoading: false, value: .none)
  }

  enum Action: Equatable, BindableAction, Sendable {
    case binding(BindingAction<State>)
    case teardown

    case getSample
    case fetchSample(Result<String, CompositeErrorRepository>)

    case onTapHome

    case test
    case test2

    case throwError(CompositeErrorRepository)

  }
}

extension SampleReducer {
  enum CancelID: Equatable, CaseIterable {
    case teardown
    case requestSample
  }
}
