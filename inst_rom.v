/*
 *  ┌───┐   ┌───┬───┬───┬───┐ ┌───┬───┬───┬───┐ ┌───┬───┬───┬───┐ ┌───┬───┬───┐
 *  │Esc│   │ F1│ F2│ F3│ F4│ │ F5│ F6│ F7│ F8│ │ F9│F10│F11│F12│ │P/S│S L│P/B│  ┌┐    ┌┐    ┌┐
 *  └───┘   └───┴───┴───┴───┘ └───┴───┴───┴───┘ └───┴───┴───┴───┘ └───┴───┴───┘  └┘    └┘    └┘
 *  ┌───┬───┬───┬───┬───┬───┬───┬───┬───┬───┬───┬───┬───┬───────┐ ┌───┬───┬───┐ ┌───┬───┬───┬───┐
 *  │~ `│! 1│@ 2│# 3│$ 4│% 5│^ 6│& 7│* 8│( 9│) 0│_ -│+ =│ BacSp │ │Ins│Hom│PUp│ │N L│ / │ * │ - │
 *  ├───┴─┬─┴─┬─┴─┬─┴─┬─┴─┬─┴─┬─┴─┬─┴─┬─┴─┬─┴─┬─┴─┬─┴─┬─┴─┬─────┤ ├───┼───┼───┤ ├───┼───┼───┼───┤
 *  │ Tab │ Q │ W │ E │ R │ T │ Y │ U │ I │ O │ P │{ [│} ]│ | \ │ │Del│End│PDn│ │ 7 │ 8 │ 9 │   │
 *  ├─────┴┬──┴┬──┴┬──┴┬──┴┬──┴┬──┴┬──┴┬──┴┬──┴┬──┴┬──┴┬──┴─────┤ └───┴───┴───┘ ├───┼───┼───┤ + │
 *  │ Caps │ A │ S │ D │ F │ G │ H │ J │ K │ L │: ;│" '│ Enter  │               │ 4 │ 5 │ 6 │   │
 *  ├──────┴─┬─┴─┬─┴─┬─┴─┬─┴─┬─┴─┬─┴─┬─┴─┬─┴─┬─┴─┬─┴─┬─┴────────┤     ┌───┐     ├───┼───┼───┼───┤
 *  │ Shift  │ Z │ X │ C │ V │ B │ N │ M │< ,│> .│? /│  Shift   │     │ ↑ │     │ 1 │ 2 │ 3 │   │
 *  ├─────┬──┴─┬─┴──┬┴───┴───┴───┴───┴───┴──┬┴───┼───┴┬────┬────┤ ┌───┼───┼───┐ ├───┴───┼───┤ E││
 *  │ Ctrl│    │Alt │         Space         │ Alt│    │    │Ctrl│ │ ← │ ↓ │ → │ │   0   │ . │←─┘│
 *  └─────┴────┴────┴───────────────────────┴────┴────┴────┴────┘ └───┴───┴───┘ └───────┴───┴───┘
 * 
 * @Author: Groot
 * @Date: 2022-02-16 12:35:40
 * @LastEditTime: 2022-02-16 14:20:21
 * @LastEditors: Groot
 * @Description: 
 * @FilePath: /groot/openMIPS/inst_rom.v
 * 版权声明
 */
//ROM的大小为128KB，按字节寻址，用17根地址线就可以访问到全部的存储单元
module inst_rom (input wire ce,
                 input wire[`InstAddrBus] addr,
                 output reg[`InstBus] inst);

    //定义一个数组，大小是InstMemNum，元素宽度是InstBus
    reg[`InstBus] inst_mem[0:`InstMemNum-1];

    //使用文件inst_rom.data初始化指令存储器
    initial $readmemh ("inst_rom.data", inst_mem);

    //当复位信号无效时，依据输入的地址，给吃指令存储器ROM中对应的元素
    always @( * ) begin
        if (ce == `ChipDisable) begin
            inst <= `ZeroWord;
        end
        else begin
            //openMIPS按字节寻址，而指令存储器的每个地址是一个32bit的字
            //所以要要访问存储器，就必须要将openMIPS给出的地址除以4再使用
            //除以4就是将地址右移2位
            //地址有17位，例如0_00000000_00000011
            //要想右移两位，直接选取高18位，截至到低3位，任位共17位的地址
            inst <= inst_mem[addr[`InstMemNumLog2+1:2]];
        end
    end
endmodule //inst_rom
