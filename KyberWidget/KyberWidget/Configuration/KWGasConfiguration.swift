//
//  KWGasConfiguration.swift
//  KyberWidget
//
//  Created by Manh Le on 27/8/18.
//  Copyright © 2018 kyber.network. All rights reserved.
//

import BigInt

public struct KWGasConfiguration {
  static let digixGasLimitDefault = BigInt(770_000)
  static let exchangeTokensGasLimitDefault = BigInt(700_000)
  static let exchangeETHTokenGasLimitDefault = BigInt(350_000)
  static let payTransferTokenGasLimitDefault = BigInt(200_000)
  static let approveTokenGasLimitDefault = BigInt(100_000)
  static let transferTokenGasLimitDefault = BigInt(60_000)
  static let transferETHGasLimitDefault = BigInt(21_000)

  static let gasPriceFast = BigInt(15) * BigInt(10).power(9)
  static let gasPriceMedium = BigInt(10) * BigInt(10).power(9)
  static let gasPriceSlow = BigInt(5) * BigInt(10).power(9)
  static let gasPriceMax = BigInt(50) * BigInt(10).power(9)

  static func calculateGasLimit(from: KWTokenObject, to: KWTokenObject, isPay: Bool) -> BigInt {
    if from == to {
      // normal transfer
      if isPay { return payTransferTokenGasLimitDefault }
      if from.isETH { return transferETHGasLimitDefault }
      return transferTokenGasLimitDefault
    }
    // swapping
    if from.isDGX {
      // swapping digix to eth or token
      return to.isETH ? digixGasLimitDefault : digixGasLimitDefault + exchangeETHTokenGasLimitDefault
    }
    if to.isDGX {
      return from.isETH ? digixGasLimitDefault : digixGasLimitDefault + exchangeETHTokenGasLimitDefault
    }
    // swap ETH <-> token or token <-> token
    return (from.isETH || to.isETH) ? exchangeETHTokenGasLimitDefault : exchangeTokensGasLimitDefault
  }
}
