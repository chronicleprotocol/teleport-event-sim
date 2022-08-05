// SPDX-License-Identifier: GPL-3.0-or-later
pragma solidity ^0.8.6;

import "ds-test/test.sol";

import "./TeleportEventSim.sol";

contract TeleportEventSimTest is DSTest {
    TeleportEventSim sim;

    function setUp() public {
        sim = new TeleportEventSim();
    }

    function testFail_basic_sanity() public {
        assertTrue(false);
    }

    function test_basic_sanity() public {
        assertTrue(true);
    }
}
