//===----------------------------------------------------------------------===//
//
// This source file is part of the Swift.org open source project
//
// Copyright (c) 2022 Apple Inc. and the Swift project authors
// Licensed under Apache License v2.0 with Runtime Library Exception
//
// See https://swift.org/LICENSE.txt for license information
//
//===----------------------------------------------------------------------===//

import Swift

@frozen
public struct ExtendedExistentialMetadata: PrivateLayout {
  typealias Layout = (
    base: Metadata.Layout,
    shape: ExtendedExistentialShape
  )
  
  let ptr: UnsafeRawPointer
  
  @usableFromInline
  init(_ ptr: UnsafeRawPointer) {
    self.ptr = ptr
  }
}

extension ExtendedExistentialMetadata {
  public var shape: ExtendedExistentialShape {
    PtrAuth.signNonUniqueExtendedExistentialShape(layout.shape)
  }
}

//===----------------------------------------------------------------------===//
// Stdlib conformances
//===----------------------------------------------------------------------===//

extension ExtendedExistentialMetadata: Equatable {
  public static func ==(
    lhs: ExtendedExistentialMetadata,
    rhs: ExtendedExistentialMetadata
  ) -> Bool {
    lhs.ptr == rhs.ptr
  }
}

extension ExtendedExistentialMetadata: Hashable {
  public func hash(into hasher: inout Hasher) {
    hasher.combine(ptr)
  }
}
