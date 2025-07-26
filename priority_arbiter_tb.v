//testbench


module  priority_arbiter_tb();
  reg clk,rst;
  reg[3:0]req;
  wire[3:0]grnt;
  reg[4:0]x;
  reg[3:0]local_grnt=0000;
  priority_arbiter dut(clk,rst,req,grnt);
  
  task reset();
begin
  @(negedge clk)
     rst =1;
  @(negedge clk)
     rst = 0;
end
endtask
  
  task insert(input [3:0] val);
begin
  $display("val:%0b",val);
@(negedge clk)
   req= val;
end
endtask
  
  
  task compare(input [3:0]op);
begin
  @(posedge clk) #1 begin 
    if(op ==grnt)
      $display("DUT Working grant:%0b  local_grnt:%0b",grnt,op);
   else
     $display("DUT NOT Working grnt:%0b  local_grnt:%0b",grnt,op);
end
end
endtask
  
  initial begin 
    clk=0;
    forever #10 clk= ~clk;
  end 
  
  initial begin 
    reset();
    repeat(10)
      begin 
        x=({$random}%10)+9;
        if(x>15)
          insert (4'b0000);
        else 
          insert(x);
      end
    
    x=4'b0110;
    insert(x);
    local_grnt[1]=1'b1;
    compare(local_grnt);
    
    //2nd one 
//      x=4'b0100;
//     insert(x);
//     local_grnt=0000;
//     compare(local_grnt);
  
    
//     //3rd case 
//      x=4'b1111;
//     insert(x);
//     local_grnt=0001;
//     compare(local_grnt);
    
//     //4th case 
//       x=4'b1001;
//     insert(x);
//     local_grnt=0001;
//     compare(local_grnt);
    
    
    
    
    #200 $finish();
  end 
  initial begin 
    $dumpfile("arbiter.vcd");
    $dumpvars(1);
  end 
endmodule
    