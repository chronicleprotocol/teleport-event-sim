import os
import pytest

from starkware.starknet.testing.starknet import Starknet

CONTRACT_FILE = os.path.join("contracts", "teleport_event_sim.cairo")

@pytest.mark.asyncio
async def test_increase_balance():
    starknet = await Starknet.empty()

    contract = await starknet.deploy(
        source=CONTRACT_FILE,
    )

    execution_info = await contract.emit_random_event().call()
    assert len(execution_info.main_call_events) == 1

