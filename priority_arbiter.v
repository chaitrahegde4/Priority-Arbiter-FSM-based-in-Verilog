module priority_arbiter(input clk, rst, input [3:0] req, output reg[3:0]grnt);

 parameter s0=3'b000,
           s1=3'b001,
           s2=3'b010, 
           s3=3'b011,
           s4=3'b100;
reg [2:0]pre_state;
reg [2:0]nxt_state;

always@(posedge clk)

    begin 
        if (rst)
       pre_state=s0;
       else
        pre_state =nxt_state;
     end 

always@(*)
begin
case(pre_state)
  s0:begin
     if (req[0]==1)
       nxt_state= s1; 
    else if (req[1:0]==2'b10)
       nxt_state=s2;
   else if(req[2:0]==3'b100)
       nxt_state=s3;
    else if(req[3:0]==4'b1000)
      nxt_state=s4;
    else
      nxt_state=s0;
     grnt=4'b0000;
  end
  s1: begin 
    if (req[0]==1)
      nxt_state=s1;
    else
      nxt_state=s0;
    grnt=4'b0001;
  end 
  s2: begin 
    if(req[1:0]==2'b10)
      nxt_state=s2;
    else 
      nxt_state=s0;
     grnt=4'b0010;
  end 
  
  s3: begin
    if(req[2:0]==3'b100)
      nxt_state=s3;
    else 
      nxt_state=s0;
     grnt=4'b0100;
  end 
  
    
  s4: begin
    if(req[3:0]==4'b1000)
      nxt_state=s4;
    else 
      nxt_state=s0;
     grnt=4'b1000;
  end
  default: nxt_state=s0;
endcase 
end 
endmodule



