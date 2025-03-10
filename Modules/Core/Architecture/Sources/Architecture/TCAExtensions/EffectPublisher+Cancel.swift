import ComposableArchitecture
import Foundation

extension Effect {
  public func cancellable(pageID: String, id: some Hashable, cancelInFlight: Bool = false) -> Self {
    let newID = "\(id)_\(pageID)_cancel_ID"
    return cancellable(id: newID, cancelInFlight: cancelInFlight)
  }

  public func cancellable(pageID: UUID, id: some Hashable, cancelInFlight: Bool = false) -> Self {
    let newID = "\(id)_\(pageID.uuidString)_cancel_ID"
    return cancellable(id: newID, cancelInFlight: cancelInFlight)
  }
}

extension Effect {
  public static func cancel(pageID: String, id: some Hashable) -> Self {
    let newID = "\(id)_\(pageID)_cancel_ID"
    return cancel(id: newID)
  }

  public static func cancel(pageID: UUID, id: some Hashable) -> Self {
    let newID = "\(id)_\(pageID.uuidString)_cancel_ID"
    return cancel(id: newID)
  }
}
