module [testChip8]

width = 64
height = 32

romData : List(U8)
romData = [
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
]

expected : Str
expected =
    \\
    \\░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░
    \\░███░█░█░░███░█░█░░░░░░███░███░░███░█░█░░░░░███░░██░███░█░█░░░░░
    \\░░██░░█░░░█░█░██░░░░░░░█░█░██░░░█░█░██░░░░░░███░░█░░█░█░██░░░░░░
    \\░░░█░█░█░░█░█░█░█░░░░░░█░█░█░░░░█░█░█░█░░░░░█░█░░░█░█░█░█░█░░░░░
    \\░███░█░█░░███░█░█░░░░░░███░███░░███░█░█░░░░░███░░█░░███░█░█░░░░░
    \\░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░
    \\░█░█░█░█░░███░█░█░░░░░░███░███░░███░█░█░░░░░███░███░███░█░█░░░░░
    \\░███░░█░░░█░█░██░░░░░░░███░█░█░░█░█░██░░░░░░███░█░░░█░█░██░░░░░░
    \\░░█░█░█░░░█░█░█░█░░░░░░█░█░█░█░░█░█░█░█░░░░░█░█░███░█░█░█░█░░░░░
    \\░░░█░█░█░░███░█░█░░░░░░███░███░░███░█░█░░░░░███░███░███░█░█░░░░░
    \\░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░
    \\░░██░█░█░░███░█░█░░░░░░███░██░░░███░█░█░░░░░███░███░███░█░█░░░░░
    \\░░█░░░█░░░█░█░██░░░░░░░███░░█░░░█░█░██░░░░░░███░██░░█░█░██░░░░░░
    \\░░░█░█░█░░█░█░█░█░░░░░░█░█░░█░░░█░█░█░█░░░░░█░█░█░░░█░█░█░█░░░░░
    \\░░█░░█░█░░███░█░█░░░░░░███░███░░███░█░█░░░░░███░███░███░█░█░░░░░
    \\░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░
    \\░███░█░█░░███░█░█░░░░░░███░███░░███░█░█░░░░░███░░██░███░█░█░░░░░
    \\░░░█░░█░░░█░█░██░░░░░░░███░░░█░░█░█░██░░░░░░█░░░░█░░█░█░██░░░░░░
    \\░░░█░█░█░░█░█░█░█░░░░░░█░█░██░░░█░█░█░█░░░░░██░░░░█░█░█░█░█░░░░░
    \\░░░█░█░█░░███░█░█░░░░░░███░███░░███░█░█░░░░░█░░░░█░░███░█░█░░░░░
    \\░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░
    \\░███░█░█░░███░█░█░░░░░░███░███░░███░█░█░░░░░███░███░███░█░█░░░░░
    \\░███░░█░░░█░█░██░░░░░░░███░░██░░█░█░██░░░░░░█░░░░██░█░█░██░░░░░░
    \\░░█░█░█░░░█░█░█░█░░░░░░█░█░░░█░░█░█░█░█░░░░░██░░░░█░█░█░█░█░░░░░
    \\░███░█░█░░███░█░█░░░░░░███░███░░███░█░█░░░░░█░░░███░███░█░█░░░░░
    \\░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░
    \\░░█░░█░█░░███░█░█░░░░░░███░█░█░░███░█░█░░░░░██░░█░█░███░█░█░░░░░
    \\░█░█░░█░░░█░█░██░░░░░░░███░███░░█░█░██░░░░░░░█░░░█░░█░█░██░░░░░░
    \\░███░█░█░░█░█░█░█░░░░░░█░█░░░█░░█░█░█░█░░░░░░█░░█░█░█░█░█░█░░░░░
    \\░█░█░█░█░░███░█░█░░░░░░███░░░█░░███░█░█░░░░░███░█░█░███░█░█░░░░░
    \\░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░
    \\░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░
    \\

State : {
    ram : List(U8),
    display : List(U8),
    regs : List(U8),
    stack : List(U16),
    sp : U64,
    pc : U64,
    lastPc : U64,
    addressReg : U64,
}

buildCols : List(U8), U64, U64, Str -> Str
buildCols = |display, row, col, acc| {
    if col >= width then
        acc
    else
        offset = col + row * width
        pixel = display.get(offset).withDefault(0)
        char = if pixel != 0 "█" else "░"
        newAcc = acc.concat(char)
        buildCols(display, row, col + 1, newAcc)
}

buildRows : List(U8), U64, Str -> Str
buildRows = |display, row, acc| {
    if row >= height then
        acc
    else
        accWithRow = buildCols(display, row, 0, acc)
        accWithNewline = accWithRow.concat("\n")
        buildRows(display, row + 1, accWithNewline)
}

screenString : List(U8) -> Str
screenString = |display| {
    buildRows(display, 0, "\n")
}

initState : U8 -> State
initState = |iter| {
    emptyRam = List.repeat 0 4096
    ramWithIter = emptyRam.set(0x199, iter)
    ramWithRom = romData.walkWithIndex(ramWithIter, |ram, byte, index| {
        ram.set(0x200 + index, byte)
    })
    {
        ram: ramWithRom,
        display: List.repeat 0 (width * height),
        regs: List.repeat 0 16,
        stack: List.repeat 0 12,
        sp: 0,
        pc: 0x200,
        lastPc: 0x0,
        addressReg: 0x0,
    }
}

step : State -> State
step = |state| {
    byte1 = state.ram.get(state.pc).withDefault(0)
    byte2 = state.ram.get(state.pc + 1).withDefault(0)
    opcode = byte1.toU64().shiftLeftBy(8).bitwiseOr(byte2.toU64())
    newState = { ..state, lastPc: state.pc, pc: state.pc + 2 }

    when opcode.shiftRightBy(12) is
        0x0 =>
            when opcode is
                0x0E0 =>
                    { ..newState, display: List.repeat 0 (width * height) }

                0x0EE => {
                    newSp = newState.sp - 1
                    newPc = newState.stack.get(newSp).withDefault(0)
                    { ..newState, sp: newSp, pc: newPc.toU64() }
                }

                _ =>
                    crash "Unimplemented opcode in 0x0 group"

        0x1 =>
            { ..newState, pc: opcode.bitwiseAnd(0x0FFF) }

        0x2 => {
            newStack = newState.stack.set(newState.sp, newState.pc.toU16())
            { ..newState, stack: newStack, sp: newState.sp + 1, pc: opcode.bitwiseAnd(0x0FFF) }
        }

        0x3 => {
            xIdx = opcode.bitwiseAnd(0x0F00).shiftRightBy(8)
            x = newState.regs.get(xIdx).withDefault(0).toU64()
            kk = opcode.bitwiseAnd(0xFF)
            pcInc = if x == kk 2 else 0
            { ..newState, pc: newState.pc + pcInc }
        }

        0x4 => {
            xIdx = opcode.bitwiseAnd(0x0F00).shiftRightBy(8)
            x = newState.regs.get(xIdx).withDefault(0).toU64()
            kk = opcode.bitwiseAnd(0xFF)
            pcInc = if x != kk 2 else 0
            { ..newState, pc: newState.pc + pcInc }
        }

        0x5 => {
            xIdx = opcode.bitwiseAnd(0x0F00).shiftRightBy(8)
            yIdx = opcode.bitwiseAnd(0x00F0).shiftRightBy(4)
            x = newState.regs.get(xIdx).withDefault(0)
            y = newState.regs.get(yIdx).withDefault(0)
            pcInc = if x == y 2 else 0
            { ..newState, pc: newState.pc + pcInc }
        }

        0x6 => {
            xIdx = opcode.bitwiseAnd(0x0F00).shiftRightBy(8)
            kk = opcode.bitwiseAnd(0xFF).toU8()
            newRegs = newState.regs.set(xIdx, kk)
            { ..newState, regs: newRegs }
        }

        0x7 => {
            xIdx = opcode.bitwiseAnd(0x0F00).shiftRightBy(8)
            x = newState.regs.get(xIdx).withDefault(0).toU64()
            kk = opcode.bitwiseAnd(0xFF)
            newVal = (x + kk).bitwiseAnd(0xFF).toU8()
            newRegs = newState.regs.set(xIdx, newVal)
            { ..newState, regs: newRegs }
        }

        0x8 => {
            xIdx = opcode.bitwiseAnd(0x0F00).shiftRightBy(8)
            yIdx = opcode.bitwiseAnd(0x00F0).shiftRightBy(4)
            x = newState.regs.get(xIdx).withDefault(0)
            y = newState.regs.get(yIdx).withDefault(0)
            when opcode.bitwiseAnd(0x000F) is
                0x0 => {
                    newRegs = newState.regs.set(xIdx, y)
                    { ..newState, regs: newRegs }
                }

                0x1 => {
                    newVal = x.bitwiseOr(y)
                    newRegs = newState.regs.set(xIdx, newVal)
                    { ..newState, regs: newRegs }
                }

                0x2 => {
                    newVal = x.bitwiseAnd(y)
                    newRegs = newState.regs.set(xIdx, newVal)
                    { ..newState, regs: newRegs }
                }

                0x3 => {
                    newVal = x.bitwiseXor(y)
                    newRegs = newState.regs.set(xIdx, newVal)
                    { ..newState, regs: newRegs }
                }

                0x4 => {
                    sum = x.toU64() + y.toU64()
                    vf = if sum > 0xFF 1 else 0
                    newVal = sum.bitwiseAnd(0xFF).toU8()
                    regsWithX = newState.regs.set(xIdx, newVal)
                    newRegs = regsWithX.set(0xF, vf)
                    { ..newState, regs: newRegs }
                }

                0x5 => {
                    diff = x.toI64() - y.toI64()
                    vf = if diff >= 0 1 else 0
                    newVal = diff.toU64().bitwiseAnd(0xFF).toU8()
                    regsWithX = newState.regs.set(xIdx, newVal)
                    newRegs = regsWithX.set(0xF, vf)
                    { ..newState, regs: newRegs }
                }

                0x6 => {
                    vf = y.bitwiseAnd(0x01)
                    newVal = y.shiftRightBy(1)
                    regsWithX = newState.regs.set(xIdx, newVal)
                    newRegs = regsWithX.set(0xF, vf)
                    { ..newState, regs: newRegs }
                }

                0x7 => {
                    diff2 = y.toI64() - x.toI64()
                    vf = if diff2 >= 0 1 else 0
                    newVal = diff2.toU64().bitwiseAnd(0xFF).toU8()
                    regsWithX = newState.regs.set(xIdx, newVal)
                    newRegs = regsWithX.set(0xF, vf)
                    { ..newState, regs: newRegs }
                }

                0xE => {
                    vf = y.bitwiseAnd(0x80).shiftRightBy(7)
                    newVal = y.shiftLeftBy(1).bitwiseAnd(0xFF)
                    regsWithX = newState.regs.set(xIdx, newVal)
                    newRegs = regsWithX.set(0xF, vf)
                    { ..newState, regs: newRegs }
                }

                _ =>
                    crash "Unimplemented opcode in 0x8 group"
        }

        0x9 => {
            xIdx = opcode.bitwiseAnd(0x0F00).shiftRightBy(8)
            yIdx = opcode.bitwiseAnd(0x00F0).shiftRightBy(4)
            x = newState.regs.get(xIdx).withDefault(0)
            y = newState.regs.get(yIdx).withDefault(0)
            pcInc = if x != y 2 else 0
            { ..newState, pc: newState.pc + pcInc }
        }

        0xA =>
            { ..newState, addressReg: opcode.bitwiseAnd(0x0FFF) }

        0xD => {
            xIdx = opcode.bitwiseAnd(0x0F00).shiftRightBy(8)
            yIdx = opcode.bitwiseAnd(0x00F0).shiftRightBy(4)
            xReg = newState.regs.get(xIdx).withDefault(0).toU64()
            yReg = newState.regs.get(yIdx).withDefault(0).toU64()
            x = xReg.rem(width)
            y = yReg.rem(height)
            n = opcode.bitwiseAnd(0x000F)

            result = List.range({ start: At 0, end: Before n }).walk({ display: newState.display, vf: 0 }, |acc, rowOffset| {
                row = y + rowOffset
                if row >= height
                    acc
                else {
                    spriteByte = newState.ram.get(newState.addressReg + rowOffset).withDefault(0)
                    List.range({ start: At 0, end: Before 8 }).walk(acc, |innerAcc, colOffset| {
                        col = x + colOffset
                        if col >= width
                            innerAcc
                        else {
                            bitIndex = colOffset
                            mask = 0x80.shiftRightBy(bitIndex)
                            pixel = spriteByte.bitwiseAnd(mask).shiftRightBy(7 - bitIndex)
                            offset = col + row * width
                            currentPixel = innerAcc.display.get(offset).withDefault(0)
                            newVf = innerAcc.vf.bitwiseOr(currentPixel.bitwiseAnd(pixel))
                            newPixel = currentPixel.bitwiseXor(pixel)
                            newDisplay = innerAcc.display.set(offset, newPixel)
                            { display: newDisplay, vf: newVf }
                        }
                    })
                }
            })

            regsWithVf = newState.regs.set(0xF, result.vf)
            { ..newState, display: result.display, regs: regsWithVf }
        }

        0xF => {
            xIdx = opcode.bitwiseAnd(0x0F00).shiftRightBy(8)
            when opcode.bitwiseAnd(0x00FF) is
                0x33 => {
                    rx = newState.regs.get(xIdx).withDefault(0).toU64()
                    hundreds = rx.divTrunc(100)
                    remainder1 = rx - hundreds * 100
                    tens = remainder1.divTrunc(10)
                    ones = remainder1 - tens * 10
                    ramWith0 = newState.ram.set(newState.addressReg, hundreds.toU8())
                    ramWith1 = ramWith0.set(newState.addressReg + 1, tens.toU8())
                    ramWith2 = ramWith1.set(newState.addressReg + 2, ones.toU8())
                    { ..newState, ram: ramWith2 }
                }

                0x55 => {
                    result = List.range({ start: At 0, end: Before (xIdx + 1) }).walk(newState.ram, |ram, i| {
                        val = newState.regs.get(i).withDefault(0)
                        ram.set(newState.addressReg + i, val)
                    })
                    { ..newState, ram: result, addressReg: newState.addressReg + xIdx + 1 }
                }

                0x65 => {
                    result = List.range({ start: At 0, end: Before (xIdx + 1) }).walk(newState.regs, |regs, i| {
                        val = newState.ram.get(newState.addressReg + i).withDefault(0)
                        regs.set(i, val)
                    })
                    { ..newState, regs: result, addressReg: newState.addressReg + xIdx + 1 }
                }

                _ =>
                    crash "Unimplemented opcode in 0xF group"
        }

        _ =>
            crash "Unimplemented opcode"
}

runEmulator : State -> State
runEmulator = |state| {
    if state.pc == state.lastPc
        state
    else
        runEmulator(step(state))
}

testChip8Helper : U8, U8 -> Bool
testChip8Helper = |iter, count| {
    if count == 0 then
        Bool.True
    else
        state = initState(iter)
        finalState = runEmulator(state)
        out = screenString(finalState.display)
        if out == expected then
            testChip8Helper(iter, count - 1)
        else
            Bool.False
}

testChip8 : U8 -> Bool
testChip8 = |iter| {
    iterations = if iter == 0 then 1 else iter
    testChip8Helper(iter, iterations)
}

expect testChip8(0) == Bool.True
