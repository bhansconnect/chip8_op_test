
# This is just a simple interpretter speed test.
# All it fundamentally does is run the cpu part of a chip8 test rom
# After completion, it asserts the correct screen is generated.
# It is meant to be used as a basic program speed test.

import sys
from array import array

# rom from https://github.com/corax89/chip8-test-rom/blob/master/test_opcode.ch8
ROM_DATA = bytes([
    0x12, 0x4e, 0xea, 0xac, 0xaa, 0xea, 0xce, 0xaa, 0xaa, 0xae, 0xe0, 0xa0, 0xa0, 0xe0, 0xc0, 0x40,
    0x40, 0xe0, 0xe0, 0x20, 0xc0, 0xe0, 0xe0, 0x60, 0x20, 0xe0, 0xa0, 0xe0, 0x20, 0x20, 0x60, 0x40,
    0x20, 0x40, 0xe0, 0x80, 0xe0, 0xe0, 0xe0, 0x20, 0x20, 0x20, 0xe0, 0xe0, 0xa0, 0xe0, 0xe0, 0xe0,
    0x20, 0xe0, 0x40, 0xa0, 0xe0, 0xa0, 0xe0, 0xc0, 0x80, 0xe0, 0xe0, 0x80, 0xc0, 0x80, 0xa0, 0x40,
    0xa0, 0xa0, 0xa2, 0x02, 0xda, 0xb4, 0x00, 0xee, 0xa2, 0x02, 0xda, 0xb4, 0x13, 0xdc, 0x68, 0x01,
    0x69, 0x05, 0x6a, 0x0a, 0x6b, 0x01, 0x65, 0x2a, 0x66, 0x2b, 0xa2, 0x16, 0xd8, 0xb4, 0xa2, 0x3e,
    0xd9, 0xb4, 0xa2, 0x02, 0x36, 0x2b, 0xa2, 0x06, 0xda, 0xb4, 0x6b, 0x06, 0xa2, 0x1a, 0xd8, 0xb4,
    0xa2, 0x3e, 0xd9, 0xb4, 0xa2, 0x06, 0x45, 0x2a, 0xa2, 0x02, 0xda, 0xb4, 0x6b, 0x0b, 0xa2, 0x1e,
    0xd8, 0xb4, 0xa2, 0x3e, 0xd9, 0xb4, 0xa2, 0x06, 0x55, 0x60, 0xa2, 0x02, 0xda, 0xb4, 0x6b, 0x10,
    0xa2, 0x26, 0xd8, 0xb4, 0xa2, 0x3e, 0xd9, 0xb4, 0xa2, 0x06, 0x76, 0xff, 0x46, 0x2a, 0xa2, 0x02,
    0xda, 0xb4, 0x6b, 0x15, 0xa2, 0x2e, 0xd8, 0xb4, 0xa2, 0x3e, 0xd9, 0xb4, 0xa2, 0x06, 0x95, 0x60,
    0xa2, 0x02, 0xda, 0xb4, 0x6b, 0x1a, 0xa2, 0x32, 0xd8, 0xb4, 0xa2, 0x3e, 0xd9, 0xb4, 0x22, 0x42,
    0x68, 0x17, 0x69, 0x1b, 0x6a, 0x20, 0x6b, 0x01, 0xa2, 0x0a, 0xd8, 0xb4, 0xa2, 0x36, 0xd9, 0xb4,
    0xa2, 0x02, 0xda, 0xb4, 0x6b, 0x06, 0xa2, 0x2a, 0xd8, 0xb4, 0xa2, 0x0a, 0xd9, 0xb4, 0xa2, 0x06,
    0x87, 0x50, 0x47, 0x2a, 0xa2, 0x02, 0xda, 0xb4, 0x6b, 0x0b, 0xa2, 0x2a, 0xd8, 0xb4, 0xa2, 0x0e,
    0xd9, 0xb4, 0xa2, 0x06, 0x67, 0x2a, 0x87, 0xb1, 0x47, 0x2b, 0xa2, 0x02, 0xda, 0xb4, 0x6b, 0x10,
    0xa2, 0x2a, 0xd8, 0xb4, 0xa2, 0x12, 0xd9, 0xb4, 0xa2, 0x06, 0x66, 0x78, 0x67, 0x1f, 0x87, 0x62,
    0x47, 0x18, 0xa2, 0x02, 0xda, 0xb4, 0x6b, 0x15, 0xa2, 0x2a, 0xd8, 0xb4, 0xa2, 0x16, 0xd9, 0xb4,
    0xa2, 0x06, 0x66, 0x78, 0x67, 0x1f, 0x87, 0x63, 0x47, 0x67, 0xa2, 0x02, 0xda, 0xb4, 0x6b, 0x1a,
    0xa2, 0x2a, 0xd8, 0xb4, 0xa2, 0x1a, 0xd9, 0xb4, 0xa2, 0x06, 0x66, 0x8c, 0x67, 0x8c, 0x87, 0x64,
    0x47, 0x18, 0xa2, 0x02, 0xda, 0xb4, 0x68, 0x2c, 0x69, 0x30, 0x6a, 0x34, 0x6b, 0x01, 0xa2, 0x2a,
    0xd8, 0xb4, 0xa2, 0x1e, 0xd9, 0xb4, 0xa2, 0x06, 0x66, 0x8c, 0x67, 0x78, 0x87, 0x65, 0x47, 0xec,
    0xa2, 0x02, 0xda, 0xb4, 0x6b, 0x06, 0xa2, 0x2a, 0xd8, 0xb4, 0xa2, 0x22, 0xd9, 0xb4, 0xa2, 0x06,
    0x66, 0xe0, 0x86, 0x6e, 0x46, 0xc0, 0xa2, 0x02, 0xda, 0xb4, 0x6b, 0x0b, 0xa2, 0x2a, 0xd8, 0xb4,
    0xa2, 0x36, 0xd9, 0xb4, 0xa2, 0x06, 0x66, 0x0f, 0x86, 0x66, 0x46, 0x07, 0xa2, 0x02, 0xda, 0xb4,
    0x6b, 0x10, 0xa2, 0x3a, 0xd8, 0xb4, 0xa2, 0x1e, 0xd9, 0xb4, 0xa3, 0xe8, 0x60, 0x00, 0x61, 0x30,
    0xf1, 0x55, 0xa3, 0xe9, 0xf0, 0x65, 0xa2, 0x06, 0x40, 0x30, 0xa2, 0x02, 0xda, 0xb4, 0x6b, 0x15,
    0xa2, 0x3a, 0xd8, 0xb4, 0xa2, 0x16, 0xd9, 0xb4, 0xa3, 0xe8, 0x66, 0x89, 0xf6, 0x33, 0xf2, 0x65,
    0xa2, 0x02, 0x30, 0x01, 0xa2, 0x06, 0x31, 0x03, 0xa2, 0x06, 0x32, 0x07, 0xa2, 0x06, 0xda, 0xb4,
    0x6b, 0x1a, 0xa2, 0x0e, 0xd8, 0xb4, 0xa2, 0x3e, 0xd9, 0xb4, 0x12, 0x48, 0x13, 0xdc,
])
WIDTH = 64
HEIGHT = 32

EXPECTED = """
░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░
░███░█░█░░███░█░█░░░░░░███░███░░███░█░█░░░░░███░░██░███░█░█░░░░░
░░██░░█░░░█░█░██░░░░░░░█░█░██░░░█░█░██░░░░░░███░░█░░█░█░██░░░░░░
░░░█░█░█░░█░█░█░█░░░░░░█░█░█░░░░█░█░█░█░░░░░█░█░░░█░█░█░█░█░░░░░
░███░█░█░░███░█░█░░░░░░███░███░░███░█░█░░░░░███░░█░░███░█░█░░░░░
░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░
░█░█░█░█░░███░█░█░░░░░░███░███░░███░█░█░░░░░███░███░███░█░█░░░░░
░███░░█░░░█░█░██░░░░░░░███░█░█░░█░█░██░░░░░░███░█░░░█░█░██░░░░░░
░░░█░█░█░░█░█░█░█░░░░░░█░█░█░█░░█░█░█░█░░░░░█░█░███░█░█░█░█░░░░░
░░░█░█░█░░███░█░█░░░░░░███░███░░███░█░█░░░░░███░███░███░█░█░░░░░
░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░
░░██░█░█░░███░█░█░░░░░░███░██░░░███░█░█░░░░░███░███░███░█░█░░░░░
░░█░░░█░░░█░█░██░░░░░░░███░░█░░░█░█░██░░░░░░███░██░░█░█░██░░░░░░
░░░█░█░█░░█░█░█░█░░░░░░█░█░░█░░░█░█░█░█░░░░░█░█░█░░░█░█░█░█░░░░░
░░█░░█░█░░███░█░█░░░░░░███░███░░███░█░█░░░░░███░███░███░█░█░░░░░
░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░
░███░█░█░░███░█░█░░░░░░███░███░░███░█░█░░░░░███░░██░███░█░█░░░░░
░░░█░░█░░░█░█░██░░░░░░░███░░░█░░█░█░██░░░░░░█░░░░█░░█░█░██░░░░░░
░░░█░█░█░░█░█░█░█░░░░░░█░█░██░░░█░█░█░█░░░░░██░░░░█░█░█░█░█░░░░░
░░░█░█░█░░███░█░█░░░░░░███░███░░███░█░█░░░░░█░░░░█░░███░█░█░░░░░
░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░
░███░█░█░░███░█░█░░░░░░███░███░░███░█░█░░░░░███░███░███░█░█░░░░░
░███░░█░░░█░█░██░░░░░░░███░░██░░█░█░██░░░░░░█░░░░██░█░█░██░░░░░░
░░░█░█░█░░█░█░█░█░░░░░░█░█░░░█░░█░█░█░█░░░░░██░░░░█░█░█░█░█░░░░░
░███░█░█░░███░█░█░░░░░░███░███░░███░█░█░░░░░█░░░███░███░█░█░░░░░
░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░
░░█░░█░█░░███░█░█░░░░░░███░█░█░░███░█░█░░░░░██░░█░█░███░█░█░░░░░
░█░█░░█░░░█░█░██░░░░░░░███░███░░█░█░██░░░░░░░█░░░█░░█░█░██░░░░░░
░███░█░█░░█░█░█░█░░░░░░█░█░░░█░░█░█░█░█░░░░░░█░░█░█░█░█░█░█░░░░░
░█░█░█░█░░███░█░█░░░░░░███░░░█░░███░█░█░░░░░███░█░█░███░█░█░░░░░
░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░
░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░
"""

def screen_string(display):
    out = '\n'
    for i in range(HEIGHT):
        for j in range(WIDTH):
            out += '█' if display[i*WIDTH+j] else '░'
        out += '\n'
    return out

class State:
    def __init__(self, iter):
        self.ram = bytearray(4096)
        self.display = bytearray(WIDTH * HEIGHT)
        self.regs = bytearray(16)
        self.stack = array('H', 12 * [0])
        self.sp = 0
        self.pc = 0x200
        self.last_pc = 0x0
        self.address_reg = 0x0

        # Just in case any program tries to optimize away code.
        self.ram[0x199] = iter

        # Load ROM at address 0x200
        self.ram[0x200:0x200 + len(ROM_DATA)] = ROM_DATA

def step(state):
    state.last_pc = state.pc
    opcode = (state.ram[state.pc] << 8) | state.ram[state.pc + 1]
    state.pc += 2

    # Match on the highest 4 bits
    match opcode >> 12:
        case 0x0:
            match opcode:
                case 0x0E0:
                    # Clearing the screen without new allocations.
                    for i in range(len(state.display)):
                        state.display[i] = 0
                case 0x0EE:
                    state.sp -= 1
                    state.pc = state.stack[state.sp]
                case _:
                    raise NotImplementedError(f"Opcode 0x{opcode:04X} not implemented")
        case 0x1:
            state.pc = opcode & 0x0FFF
        case 0x2:
            state.stack[state.sp] = state.pc
            state.sp += 1
            state.pc = opcode & 0x0FFF
        case 0x3:
            x = state.regs[(opcode&0x0F00)>>8]
            state.pc += 2*int(x == opcode & 0xFF)
        case 0x4:
            x = state.regs[(opcode&0x0F00)>>8]
            state.pc += 2*int(x != opcode & 0xFF)
        case 0x5:
            x = state.regs[(opcode&0x0F00)>>8]
            y = state.regs[(opcode&0x00F0)>>4]
            state.pc += 2*int(x == y)
        case 0x6:
            state.regs[(opcode&0x0F00)>>8] = opcode & 0x00FF
        case 0x7:
            state.regs[(opcode&0x0F00)>>8] = (state.regs[(opcode&0x0F00)>>8] + (opcode & 0x00FF)) & 0xFF
        case 0x8:
            x = (opcode&0x0F00)>>8
            y = (opcode&0x00F0)>>4
            match opcode & 0x000F:
                case 0x0:
                    state.regs[x] = state.regs[y]
                case 0x1:
                    state.regs[x] |= state.regs[y]
                case 0x2:
                    state.regs[x] &= state.regs[y]
                case 0x3:
                    state.regs[x] ^= state.regs[y]
                case 0x4:
                    out = state.regs[x] + state.regs[y]
                    state.regs[0xF] = int(out > 0xFF)
                    state.regs[x] = out & 0xFF
                case 0x5:
                    out = state.regs[x] - state.regs[y]
                    state.regs[0xF] = int(out >= 0)
                    state.regs[x] = out & 0xFF
                case 0x6:
                    state.regs[0xF] = state.regs[y] & 0x01
                    state.regs[x] = state.regs[y] >> 1
                case 0x7:
                    out = state.regs[y] - state.regs[x]
                    state.regs[0xF] = int(out >= 0)
                    state.regs[x] = out & 0xFF
                case 0xE:
                    state.regs[0xF] = (state.regs[y] & 0x80) >> 7
                    state.regs[x] = (state.regs[y] << 1) & 0xFF
                case _:
                    raise NotImplementedError(f"Opcode 0x{opcode:04X} not implemented")
        case 0x9:
            x = state.regs[(opcode&0x0F00)>>8]
            y = state.regs[(opcode&0x00F0)>>4]
            state.pc += 2*int(x != y)
        case 0xA:
            state.address_reg = opcode & 0x0FFF
        case 0xB:
            raise NotImplementedError(f"Opcode 0x{opcode:04X} not implemented")
        case 0xC:
            raise NotImplementedError(f"Opcode 0x{opcode:04X} not implemented")
        case 0xD:
            x = state.regs[(opcode&0x0F00)>>8] % WIDTH
            y = state.regs[(opcode&0x00F0)>>4] % HEIGHT
            n = opcode & 0x000F
            state.regs[0xF] = 0
            for i in range(y, min(y+n,HEIGHT)):
                sprite_byte = state.ram[state.address_reg+i-y]
                for j in range(x, min(x+8,WIDTH)):
                    bit_index = j - x
                    pixel = (sprite_byte & (0x80 >> bit_index)) >> (7 - bit_index)
                    offset = j + i * WIDTH
                    state.regs[0xF] |= state.display[offset] & pixel
                    state.display[offset] ^= pixel
        case 0xE:
            raise NotImplementedError(f"Opcode 0x{opcode:04X} not implemented")
        case 0xF:
            x = (opcode&0x0F00)>>8
            match opcode & 0x00FF:
                case 0x33:
                    rx = state.regs[x]
                    hundreds = rx//100
                    rx -= hundreds * 100
                    tens = rx//10
                    ones = rx - tens * 10
                    state.ram[state.address_reg] = hundreds
                    state.ram[state.address_reg+1] = tens
                    state.ram[state.address_reg+2] = ones
                case 0x55:
                    state.ram[state.address_reg:state.address_reg+x+1] = state.regs[0:x+1]
                    state.address_reg += x + 1
                case 0x65:
                    state.regs[0:x+1] = state.ram[state.address_reg:state.address_reg+x+1]
                    state.address_reg += x + 1
                case _:
                    raise NotImplementedError(f"Opcode 0x{opcode:04X} not implemented")

def test_chip8(i):
    state = State(i)
    while state.pc != state.last_pc:
        step(state)
    out = screen_string(state.display)
    assert out == EXPECTED


if __name__ == '__main__':
    iterations = int(sys.argv[1]) if len(sys.argv) > 1 else 1
    for i in range(iterations):
        test_chip8(i)
