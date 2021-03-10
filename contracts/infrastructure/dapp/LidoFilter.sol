// Copyright (C) 2021  Argent Labs Ltd. <https://argent.xyz>

// This program is free software: you can redistribute it and/or modify
// it under the terms of the GNU General Public License as published by
// the Free Software Foundation, either version 3 of the License, or
// (at your option) any later version.

// This program is distributed in the hope that it will be useful,
// but WITHOUT ANY WARRANTY; without even the implied warranty of
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
// GNU General Public License for more details.s

// You should have received a copy of the GNU General Public License
// along with this program.  If not, see <http://www.gnu.org/licenses/>.

// SPDX-License-Identifier: GPL-3.0-only
pragma solidity ^0.6.12;

import "./BaseFilter.sol";

contract LidoFilter is BaseFilter {
  bytes4 private constant SUBMIT = bytes4(keccak256("submit(address)"));

  function isValid(address /*_wallet*/, address _spender, address _to, bytes calldata _data) external view override returns (bool) {
    // Allow sending ETH as well as calls to send(address)
    if (_data.length == 0) {
        return true;
    }
    if(_spender == _to && _data.length >= 4) {
      bytes4 methodId = getMethod(_data);
      if (methodId == SUBMIT) {
        return true;
      }
    }
  }
}