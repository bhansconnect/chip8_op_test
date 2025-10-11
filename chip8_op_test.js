
// This is just a simple interpretter speed test.
// All it fundamentally does is run the cpu part of a chip8 test rom
// After completion, it asserts the correct screen is generated.
// It is meant to be used as a basic program speed test.

// rom from https://github.com/corax89/chip8-test-rom/blob/master/test_opcode.ch8
const ROM_DATA = new Uint8Array([
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
]);

const WIDTH = 64;
const HEIGHT = 32;

const EXPECTED = `
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
`;

function screen_string(display) {
    let out = '\n';
    for (let i = 0; i < HEIGHT; i++) {
        for (let j = 0; j < WIDTH; j++) {
            out += display[i * WIDTH + j] ? '█' : '░';
        }
        out += '\n';
    }
    return out;
}

function test_chip8(iter) {
    const ram = new Uint8Array(4096);
    const display = new Uint8Array(WIDTH * HEIGHT);
    const regs = new Uint8Array(16);
    const stack = new Uint16Array(12);
    let sp = 0;
    let pc = 0x200;
    let last_pc = 0x0;
    let address_reg = 0x0;

    // Just in case any program tries to optimize away code.
    ram[0x199] = iter & 0xFF;

    // Load ROM at address 0x200
    ram.set(ROM_DATA, 0x200);

    while (true) {
        if (pc === last_pc) {
            break;
        }
        last_pc = pc;
        const opcode = (ram[pc] << 8) | ram[pc + 1];
        pc += 2;

        // Match on the highest 4 bits
        switch (opcode >> 12) {
            case 0x0:
                switch (opcode) {
                    case 0x0E0:
                        // Clearing the screen without new allocations.
                        for (let i = 0; i < display.length; i++) {
                            display[i] = 0;
                        }
                        break;
                    case 0x0EE:
                        sp -= 1;
                        pc = stack[sp];
                        break;
                    default:
                        throw new Error(`Opcode 0x${opcode.toString(16).padStart(4, '0')} not implemented`);
                }
                break;
            case 0x1:
                pc = opcode & 0x0FFF;
                break;
            case 0x2:
                stack[sp] = pc;
                sp += 1;
                pc = opcode & 0x0FFF;
                break;
            case 0x3:
                {
                    const x = regs[(opcode & 0x0F00) >> 8];
                    pc += 2 * (x === (opcode & 0xFF) ? 1 : 0);
                }
                break;
            case 0x4:
                {
                    const x = regs[(opcode & 0x0F00) >> 8];
                    pc += 2 * (x !== (opcode & 0xFF) ? 1 : 0);
                }
                break;
            case 0x5:
                {
                    const x = regs[(opcode & 0x0F00) >> 8];
                    const y = regs[(opcode & 0x00F0) >> 4];
                    pc += 2 * (x === y ? 1 : 0);
                }
                break;
            case 0x6:
                regs[(opcode & 0x0F00) >> 8] = opcode & 0x00FF;
                break;
            case 0x7:
                regs[(opcode & 0x0F00) >> 8] = (regs[(opcode & 0x0F00) >> 8] + (opcode & 0x00FF)) & 0xFF;
                break;
            case 0x8:
                {
                    const x = (opcode & 0x0F00) >> 8;
                    const y = (opcode & 0x00F0) >> 4;
                    switch (opcode & 0x000F) {
                        case 0x0:
                            regs[x] = regs[y];
                            break;
                        case 0x1:
                            regs[x] |= regs[y];
                            break;
                        case 0x2:
                            regs[x] &= regs[y];
                            break;
                        case 0x3:
                            regs[x] ^= regs[y];
                            break;
                        case 0x4:
                            {
                                const out = regs[x] + regs[y];
                                regs[0xF] = out > 0xFF ? 1 : 0;
                                regs[x] = out & 0xFF;
                            }
                            break;
                        case 0x5:
                            {
                                const out = regs[x] - regs[y];
                                regs[0xF] = out >= 0 ? 1 : 0;
                                regs[x] = out & 0xFF;
                            }
                            break;
                        case 0x6:
                            regs[0xF] = regs[y] & 0x01;
                            regs[x] = regs[y] >> 1;
                            break;
                        case 0x7:
                            {
                                const out = regs[y] - regs[x];
                                regs[0xF] = out >= 0 ? 1 : 0;
                                regs[x] = out & 0xFF;
                            }
                            break;
                        case 0xE:
                            regs[0xF] = (regs[y] & 0x80) >> 7;
                            regs[x] = (regs[y] << 1) & 0xFF;
                            break;
                        default:
                            throw new Error(`Opcode 0x${opcode.toString(16).padStart(4, '0')} not implemented`);
                    }
                }
                break;
            case 0x9:
                {
                    const x = regs[(opcode & 0x0F00) >> 8];
                    const y = regs[(opcode & 0x00F0) >> 4];
                    pc += 2 * (x !== y ? 1 : 0);
                }
                break;
            case 0xA:
                address_reg = opcode & 0x0FFF;
                break;
            case 0xB:
                throw new Error(`Opcode 0x${opcode.toString(16).padStart(4, '0')} not implemented`);
            case 0xC:
                throw new Error(`Opcode 0x${opcode.toString(16).padStart(4, '0')} not implemented`);
            case 0xD:
                {
                    const x = regs[(opcode & 0x0F00) >> 8] % WIDTH;
                    const y = regs[(opcode & 0x00F0) >> 4] % HEIGHT;
                    const n = opcode & 0x000F;
                    regs[0xF] = 0;
                    for (let i = y; i < Math.min(y + n, HEIGHT); i++) {
                        const sprite_byte = ram[address_reg + i - y];
                        for (let j = x; j < Math.min(x + 8, WIDTH); j++) {
                            const bit_index = j - x;
                            const pixel = (sprite_byte & (0x80 >> bit_index)) >> (7 - bit_index);
                            const offset = j + i * WIDTH;
                            regs[0xF] |= display[offset] & pixel;
                            display[offset] ^= pixel;
                        }
                    }
                }
                break;
            case 0xE:
                throw new Error(`Opcode 0x${opcode.toString(16).padStart(4, '0')} not implemented`);
            case 0xF:
                {
                    const x = (opcode & 0x0F00) >> 8;
                    switch (opcode & 0x00FF) {
                        case 0x33:
                            {
                                let rx = regs[x];
                                const hundreds = Math.floor(rx / 100);
                                rx -= hundreds * 100;
                                const tens = Math.floor(rx / 10);
                                const ones = rx - tens * 10;
                                ram[address_reg] = hundreds;
                                ram[address_reg + 1] = tens;
                                ram[address_reg + 2] = ones;
                            }
                            break;
                        case 0x55:
                            for (let i = 0; i <= x; i++) {
                                ram[address_reg + i] = regs[i];
                            }
                            address_reg += x + 1;
                            break;
                        case 0x65:
                            for (let i = 0; i <= x; i++) {
                                regs[i] = ram[address_reg + i];
                            }
                            address_reg += x + 1;
                            break;
                        default:
                            throw new Error(`Opcode 0x${opcode.toString(16).padStart(4, '0')} not implemented`);
                    }
                }
                break;
        }
    }

    const out = screen_string(display);
    if (out !== EXPECTED) {
        throw new Error('Assertion failed: output does not match expected');
    }
}

if (require.main === module) {
    const iterations = process.argv[2] ? parseInt(process.argv[2]) : 1;
    for (let i = 0; i < iterations; i++) {
        test_chip8(i);
    }
}
