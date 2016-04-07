onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /zxw_tb/Resetn_tb
add wave -noupdate /zxw_tb/Clock_tb
add wave -noupdate /zxw_tb/SW_in_tb
add wave -noupdate /zxw_tb/Display_out_tb
add wave -noupdate /zxw_tb/i
add wave -noupdate -radix hexadecimal /zxw_tb/dut/my_crom/Clock
add wave -noupdate -radix hexadecimal /zxw_tb/dut/my_crom/PM_out
add wave -noupdate -radix hexadecimal /zxw_tb/dut/my_crom/stall_flg
add wave -noupdate -radix hexadecimal /zxw_tb/dut/my_crom/mbits
add wave -noupdate -radix hexadecimal /zxw_tb/dut/my_crom/grp
add wave -noupdate -radix hexadecimal /zxw_tb/dut/my_crom/PMM_out
add wave -noupdate -radix hexadecimal /zxw_tb/dut/my_crom/c0
add wave -noupdate -radix hexadecimal /zxw_tb/dut/my_crom/c1
add wave -noupdate -radix hexadecimal /zxw_tb/dut/my_crom/c2
add wave -noupdate -radix hexadecimal /zxw_tb/dut/my_crom/dout
add wave -noupdate -radix hexadecimal /zxw_tb/dut/my_crom/we_n
add wave -noupdate -radix hexadecimal /zxw_tb/dut/my_crom/rd_n
add wave -noupdate -radix hexadecimal /zxw_tb/dut/my_crom/miss
add wave -noupdate -radix hexadecimal /zxw_tb/dut/my_crom/wren
add wave -noupdate -radix hexadecimal /zxw_tb/dut/my_crom/PMC_address
add wave -noupdate -radix hexadecimal /zxw_tb/dut/my_crom/PMM_address
add wave -noupdate -radix hexadecimal /zxw_tb/dut/my_crom/din
add wave -noupdate -radix hexadecimal /zxw_tb/dut/my_crom/cam_addrs
add wave -noupdate -radix hexadecimal /zxw_tb/dut/my_crom/transfer_count
add wave -noupdate -radix hexadecimal /zxw_tb/dut/my_cram/transfer_count
add wave -noupdate -radix hexadecimal /zxw_tb/dut/my_cram/write_count
add wave -noupdate -radix hexadecimal /zxw_tb/dut/my_cram/clock_cache
add wave -noupdate -radix hexadecimal /zxw_tb/dut/my_cram/clock_mm
add wave -noupdate -radix hexadecimal /zxw_tb/dut/my_cram/write_back
add wave -noupdate -radix hexadecimal /zxw_tb/dut/my_cram/write_miss
add wave -noupdate -radix hexadecimal -childformat {{{/zxw_tb/dut/my_cram/dirtybit[15]} -radix hexadecimal} {{/zxw_tb/dut/my_cram/dirtybit[14]} -radix hexadecimal} {{/zxw_tb/dut/my_cram/dirtybit[13]} -radix hexadecimal} {{/zxw_tb/dut/my_cram/dirtybit[12]} -radix hexadecimal} {{/zxw_tb/dut/my_cram/dirtybit[11]} -radix hexadecimal} {{/zxw_tb/dut/my_cram/dirtybit[10]} -radix hexadecimal} {{/zxw_tb/dut/my_cram/dirtybit[9]} -radix hexadecimal} {{/zxw_tb/dut/my_cram/dirtybit[8]} -radix hexadecimal} {{/zxw_tb/dut/my_cram/dirtybit[7]} -radix hexadecimal} {{/zxw_tb/dut/my_cram/dirtybit[6]} -radix hexadecimal} {{/zxw_tb/dut/my_cram/dirtybit[5]} -radix hexadecimal} {{/zxw_tb/dut/my_cram/dirtybit[4]} -radix hexadecimal} {{/zxw_tb/dut/my_cram/dirtybit[3]} -radix hexadecimal} {{/zxw_tb/dut/my_cram/dirtybit[2]} -radix hexadecimal} {{/zxw_tb/dut/my_cram/dirtybit[1]} -radix hexadecimal} {{/zxw_tb/dut/my_cram/dirtybit[0]} -radix hexadecimal}} -subitemconfig {{/zxw_tb/dut/my_cram/dirtybit[15]} {-radix hexadecimal} {/zxw_tb/dut/my_cram/dirtybit[14]} {-radix hexadecimal} {/zxw_tb/dut/my_cram/dirtybit[13]} {-radix hexadecimal} {/zxw_tb/dut/my_cram/dirtybit[12]} {-radix hexadecimal} {/zxw_tb/dut/my_cram/dirtybit[11]} {-radix hexadecimal} {/zxw_tb/dut/my_cram/dirtybit[10]} {-radix hexadecimal} {/zxw_tb/dut/my_cram/dirtybit[9]} {-radix hexadecimal} {/zxw_tb/dut/my_cram/dirtybit[8]} {-radix hexadecimal} {/zxw_tb/dut/my_cram/dirtybit[7]} {-radix hexadecimal} {/zxw_tb/dut/my_cram/dirtybit[6]} {-radix hexadecimal} {/zxw_tb/dut/my_cram/dirtybit[5]} {-radix hexadecimal} {/zxw_tb/dut/my_cram/dirtybit[4]} {-radix hexadecimal} {/zxw_tb/dut/my_cram/dirtybit[3]} {-radix hexadecimal} {/zxw_tb/dut/my_cram/dirtybit[2]} {-radix hexadecimal} {/zxw_tb/dut/my_cram/dirtybit[1]} {-radix hexadecimal} {/zxw_tb/dut/my_cram/dirtybit[0]} {-radix hexadecimal}} /zxw_tb/dut/my_cram/dirtybit
add wave -noupdate -radix hexadecimal /zxw_tb/dut/my_cram/dout
add wave -noupdate -radix hexadecimal /zxw_tb/dut/my_cram/DMM_out
add wave -noupdate -radix hexadecimal /zxw_tb/dut/my_cram/DMM_out_val
add wave -noupdate /zxw_tb/dut/DM_in
add wave -noupdate /zxw_tb/dut/my_cram/stall_flg
add wave -noupdate /zxw_tb/dut/stall_flg2
add wave -noupdate /zxw_tb/dut/WR_DM
add wave -noupdate /zxw_tb/dut/my_cram/ram_wr
add wave -noupdate /zxw_tb/Resetn_tb
add wave -noupdate /zxw_tb/Clock_tb
add wave -noupdate /zxw_tb/SW_in_tb
add wave -noupdate /zxw_tb/Display_out_tb
add wave -noupdate /zxw_tb/i
add wave -noupdate -radix hexadecimal /zxw_tb/dut/MAB
add wave -noupdate -radix hexadecimal /zxw_tb/dut/MAX
add wave -noupdate -radix hexadecimal /zxw_tb/dut/MAeff
add wave -noupdate -radix hexadecimal /zxw_tb/dut/my_cram/datain
add wave -noupdate -radix hexadecimal /zxw_tb/dut/my_cram/DM_out
add wave -noupdate -radix hexadecimal -childformat {{{/zxw_tb/dut/my_cram/DM_address[13]} -radix hexadecimal} {{/zxw_tb/dut/my_cram/DM_address[12]} -radix hexadecimal} {{/zxw_tb/dut/my_cram/DM_address[11]} -radix hexadecimal} {{/zxw_tb/dut/my_cram/DM_address[10]} -radix hexadecimal} {{/zxw_tb/dut/my_cram/DM_address[9]} -radix hexadecimal} {{/zxw_tb/dut/my_cram/DM_address[8]} -radix hexadecimal} {{/zxw_tb/dut/my_cram/DM_address[7]} -radix hexadecimal} {{/zxw_tb/dut/my_cram/DM_address[6]} -radix hexadecimal} {{/zxw_tb/dut/my_cram/DM_address[5]} -radix hexadecimal} {{/zxw_tb/dut/my_cram/DM_address[4]} -radix hexadecimal} {{/zxw_tb/dut/my_cram/DM_address[3]} -radix hexadecimal} {{/zxw_tb/dut/my_cram/DM_address[2]} -radix hexadecimal} {{/zxw_tb/dut/my_cram/DM_address[1]} -radix hexadecimal} {{/zxw_tb/dut/my_cram/DM_address[0]} -radix hexadecimal}} -subitemconfig {{/zxw_tb/dut/my_cram/DM_address[13]} {-radix hexadecimal} {/zxw_tb/dut/my_cram/DM_address[12]} {-radix hexadecimal} {/zxw_tb/dut/my_cram/DM_address[11]} {-radix hexadecimal} {/zxw_tb/dut/my_cram/DM_address[10]} {-radix hexadecimal} {/zxw_tb/dut/my_cram/DM_address[9]} {-radix hexadecimal} {/zxw_tb/dut/my_cram/DM_address[8]} {-radix hexadecimal} {/zxw_tb/dut/my_cram/DM_address[7]} {-radix hexadecimal} {/zxw_tb/dut/my_cram/DM_address[6]} {-radix hexadecimal} {/zxw_tb/dut/my_cram/DM_address[5]} {-radix hexadecimal} {/zxw_tb/dut/my_cram/DM_address[4]} {-radix hexadecimal} {/zxw_tb/dut/my_cram/DM_address[3]} {-radix hexadecimal} {/zxw_tb/dut/my_cram/DM_address[2]} {-radix hexadecimal} {/zxw_tb/dut/my_cram/DM_address[1]} {-radix hexadecimal} {/zxw_tb/dut/my_cram/DM_address[0]} {-radix hexadecimal}} /zxw_tb/dut/my_cram/DM_address
add wave -noupdate -radix hexadecimal /zxw_tb/dut/my_cram/my_cam2/cam_mem
add wave -noupdate -radix hexadecimal -childformat {{{/zxw_tb/dut/my_cram/mbits[15]} -radix hexadecimal} {{/zxw_tb/dut/my_cram/mbits[14]} -radix hexadecimal} {{/zxw_tb/dut/my_cram/mbits[13]} -radix hexadecimal} {{/zxw_tb/dut/my_cram/mbits[12]} -radix hexadecimal} {{/zxw_tb/dut/my_cram/mbits[11]} -radix hexadecimal} {{/zxw_tb/dut/my_cram/mbits[10]} -radix hexadecimal} {{/zxw_tb/dut/my_cram/mbits[9]} -radix hexadecimal} {{/zxw_tb/dut/my_cram/mbits[8]} -radix hexadecimal} {{/zxw_tb/dut/my_cram/mbits[7]} -radix hexadecimal} {{/zxw_tb/dut/my_cram/mbits[6]} -radix hexadecimal} {{/zxw_tb/dut/my_cram/mbits[5]} -radix hexadecimal} {{/zxw_tb/dut/my_cram/mbits[4]} -radix hexadecimal} {{/zxw_tb/dut/my_cram/mbits[3]} -radix hexadecimal} {{/zxw_tb/dut/my_cram/mbits[2]} -radix hexadecimal} {{/zxw_tb/dut/my_cram/mbits[1]} -radix hexadecimal} {{/zxw_tb/dut/my_cram/mbits[0]} -radix hexadecimal}} -subitemconfig {{/zxw_tb/dut/my_cram/mbits[15]} {-height 15 -radix hexadecimal} {/zxw_tb/dut/my_cram/mbits[14]} {-height 15 -radix hexadecimal} {/zxw_tb/dut/my_cram/mbits[13]} {-height 15 -radix hexadecimal} {/zxw_tb/dut/my_cram/mbits[12]} {-height 15 -radix hexadecimal} {/zxw_tb/dut/my_cram/mbits[11]} {-height 15 -radix hexadecimal} {/zxw_tb/dut/my_cram/mbits[10]} {-height 15 -radix hexadecimal} {/zxw_tb/dut/my_cram/mbits[9]} {-height 15 -radix hexadecimal} {/zxw_tb/dut/my_cram/mbits[8]} {-height 15 -radix hexadecimal} {/zxw_tb/dut/my_cram/mbits[7]} {-height 15 -radix hexadecimal} {/zxw_tb/dut/my_cram/mbits[6]} {-height 15 -radix hexadecimal} {/zxw_tb/dut/my_cram/mbits[5]} {-height 15 -radix hexadecimal} {/zxw_tb/dut/my_cram/mbits[4]} {-height 15 -radix hexadecimal} {/zxw_tb/dut/my_cram/mbits[3]} {-height 15 -radix hexadecimal} {/zxw_tb/dut/my_cram/mbits[2]} {-height 15 -radix hexadecimal} {/zxw_tb/dut/my_cram/mbits[1]} {-height 15 -radix hexadecimal} {/zxw_tb/dut/my_cram/mbits[0]} {-height 15 -radix hexadecimal}} /zxw_tb/dut/my_cram/mbits
add wave -noupdate -radix hexadecimal /zxw_tb/dut/my_cram/grp
add wave -noupdate -radix hexadecimal /zxw_tb/dut/my_cram/DMC_address
add wave -noupdate -radix hexadecimal /zxw_tb/dut/my_cram/DMM_address
add wave -noupdate -radix hexadecimal /zxw_tb/dut/PC
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {7312257 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 102
configure wave -valuecolwidth 215
configure wave -justifyvalue left
configure wave -signalnamewidth 1
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ns
update
WaveRestoreZoom {2836413 ps} {11711925 ps}
