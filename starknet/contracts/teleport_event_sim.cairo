%lang starknet

from starkware.cairo.common.cairo_builtins import HashBuiltin
from starkware.cairo.common.alloc import alloc
from starkware.cairo.common.keccak import unsafe_keccak
from starkware.cairo.common.math import split_felt
from starkware.starknet.common.syscalls import get_block_number, get_block_timestamp

@event
func TeleportInitialized(
    source_domain: felt,
    target_domain: felt,
    receiver: felt,
    operator: felt,
    amount: felt,
    nonce: felt,
    timestamp: felt,
) { 
}

@external
func emit_random_event{syscall_ptr: felt*, pedersen_ptr: HashBuiltin*, range_check_ptr}() {
    alloc_locals;

    let (block) = get_block_number();
    let (timestamp) = get_block_timestamp();

    let (blockLow, blockHigh) = split_felt(block);
    let (timestampLow, timestampHigh) = split_felt(timestamp);

    let (seed : felt*) = alloc();
    seed[0] = blockLow;
    seed[1] = blockHigh;
    seed[2] = timestampLow;
    seed[3] = timestampHigh;

    let (low, high) = unsafe_keccak(seed,64);

    TeleportInitialized.emit(
        source_domain=low,
        target_domain=high,
        receiver=low+1,
        operator=high+1,
        amount=low+2,
        nonce=high+2,
        timestamp=timestamp,
    );

    return ();
}