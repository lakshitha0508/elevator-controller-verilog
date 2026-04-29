module elevator_controller(input [1:0] button,input rst,clk,output reg door_open,close_door,move_up,move_down,idle,output reg door_time=0);
 parameter IDLE=3'b000, MOVE_UP=3'b001,MOVE_DOWN=3'b010,DOOR_OPEN=3'b100,CLOSE_DOOR=3'b101,DOOR_TIME=3'b110; 
 reg [2:0] state,next_state; 
 reg [2:0]current_floor; 
 always @(posedge clk ) begin
  if(rst) begin state<=IDLE; 
  current_floor<=0; 
  end 
  else begin state=next_state; 
  if(state==MOVE_UP) 
  current_floor<=current_floor+1; 
  else if(state==MOVE_DOWN) 
  current_floor=current_floor-1; 
  else if(state==DOOR_OPEN) 
  door_time=door_time+1; 
  end 
  end 
always @(*) begin 
case(state) 
IDLE:begin 
if(button==current_floor) 
next_state<=DOOR_OPEN; 
else next_state<=CLOSE_DOOR; 
end 
MOVE_UP:begin 
if(button==current_floor) 
next_state<=IDLE; 
else 
next_state<=MOVE_UP; 
end 
MOVE_DOWN:begin 
if(button==current_floor) 
next_state<=IDLE; 
else next_state<=MOVE_DOWN; 
end 
DOOR_OPEN:begin 
if(button==current_floor) 
next_state<=DOOR_TIME; 
else next_state<=CLOSE_DOOR; 
end 
CLOSE_DOOR:begin 
if(button<current_floor) 
next_state<=MOVE_DOWN; 
else if(button>current_floor) 
next_state<=MOVE_UP; 
else 
next_state<=DOOR_OPEN; 
end 
DOOR_TIME: begin 
if(button==current_floor) begin
if(door_time==3'd3) 
state<=CLOSE_DOOR; 
else 
state<=DOOR_TIME; 
end
else
state<=CLOSE_DOOR; 
end 
default:state<=idle;
endcase 
end 
always @(*) begin 
idle=0; 
move_up=0; 
move_down=0; 
door_open=0; 
close_door=0; 
door_time=0; 
case(state) 
IDLE:begin 
idle=1; 
close_door=1; 
end 
MOVE_UP:begin 
move_up = 1; 
close_door = 1; 
end 
MOVE_DOWN:begin 
move_down = 1; 
close_door = 1; 
end 
DOOR_OPEN:begin 
door_open=1; 
idle=1; 
door_time=door_time+1; 
end 
CLOSE_DOOR:begin 
close_door = 1; 
idle = 1; 
end 
DOOR_TIME:begin 
door_open=1; 
idle=1; 
door_time=door_time+1;
end 
endcase 
end 
endmodule

