module elevator_controller_tb;
reg [1:0] button;
reg rst,clk;
wire door_open,close_door,move_up,move_down,idle;
elevator_controller uut(button,rst,clk,door_open,close_door,move_up,move_down,idle);
initial begin
clk=0;
forever #10 clk=~clk;
end
initial begin
$monitor("time=%g button=%b rst=%b door_open=%b close_door=%b move_up=%b move_down=%b idle=%b",$time,button,rst,door_open,close_door,move_up,move_up,idle);
rst=1;button=2'b01;
#20 rst=0;
#100 button=2'b10;
#100 button=2'b11;
#100 button=2'b00;
#100 button=2'b10;
#100 $finish;
end
endmodule

