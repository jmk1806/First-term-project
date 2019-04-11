module midterm( input [16:0] SW, output reg [0:6] HEX0,HEX1,HEX4,HEX5,HEX6,HEX7 );
reg [3:0] bit3, bit4, bit5, bit6;
reg operator;
wire [3:0] bit1, bit2;
reg car_0, car_1, car_2;
parameter Seg9 = 7'b000_1100; parameter Seg8 = 7'b000_0000; parameter Seg7 = 7'b000_1111; parameter Seg6 = 7'b010_0000; parameter Seg5 = 7'b010_0100;
parameter Seg4 = 7'b100_1100; parameter Seg3 = 7'b000_0110; parameter Seg2 = 7'b001_0010; parameter Seg1 = 7'b100_1111; parameter Seg0 = 7'b000_0001;
	
bcd_adder bcdadd(operator,bit1, bit2, bit3, bit4, bit5, bit6, car_0); // Create Module bcdadd
	
always @(*)
begin
	operator = SW[16];
	bit3 = SW[15:12];
	bit4 = SW[11:8];
	bit5 = SW[7:4];
	bit6 = SW[3:0];
	car_0 = 1'b0;
end

always @(*)
begin
	case(SW[15:12])
		9:HEX7=Seg9;    8:HEX7=Seg8;	7:HEX7=Seg7;	6:HEX7=Seg6;
		5:HEX7=Seg5;	4:HEX7=Seg4;	3:HEX7=Seg3;	2:HEX7=Seg2;
		1:HEX7=Seg1;	0:HEX7=Seg0;    //default: HEX7 = 7'b1111111;
	endcase
	case(SW[11:8])
		9:HEX6=Seg9;    8:HEX6=Seg8;	7:HEX6=Seg7;	6:HEX6=Seg6;
		5:HEX6=Seg5;	4:HEX6=Seg4;	3:HEX6=Seg3;	2:HEX6=Seg2;
		1:HEX6=Seg1;	0:HEX6=Seg0;    //default: HEX6 = 7'b1111111;
	endcase
	case(SW[7:4])
		9:HEX5=Seg9;    8:HEX5=Seg8;	7:HEX5=Seg7;	6:HEX5=Seg6;
		5:HEX5=Seg5;	4:HEX5=Seg4;	3:HEX5=Seg3;	2:HEX5=Seg2;
		1:HEX5=Seg1;	0:HEX5=Seg0;  	//default: HEX5 = 7'b1111111;
	endcase
	case(SW[3:0])
		9:HEX4=Seg9;	8:HEX4=Seg8;	7:HEX4=Seg7;	6:HEX4=Seg6;
		5:HEX4=Seg5;	4:HEX4=Seg4;	3:HEX4=Seg3;	2:HEX4=Seg2;
		1:HEX4=Seg1;	0:HEX4=Seg0;	//default: HEX4 = 7'b1111111;
	endcase
	case(bit1)
		9:HEX1=Seg9;	8:HEX1=Seg8;	7:HEX1=Seg7;	6:HEX1=Seg6;
		5:HEX1=Seg5;	4:HEX1=Seg4;	3:HEX1=Seg3;	2:HEX1=Seg2;			
		1:HEX1=Seg1;	0:HEX1=Seg0;	//default: HEX1 = 7'b1111111;
	endcase
	case(bit2)
		9:HEX0=Seg9;	8:HEX0=Seg8;	7:HEX0=Seg7;	6:HEX0=Seg6;
		5:HEX0=Seg5;	4:HEX0=Seg4;	3:HEX0=Seg3;	2:HEX0=Seg2;			
		1:HEX0=Seg1;	0:HEX0=Seg0;	//default: HEX0 = 7'b1111111;
	endcase
end
endmodule

module bcd_adder(operator, sum1, sum2, a, b, c, d, cin);

output [3:0] sum1,sum2;
//output overflow;
input operator;
input [3:0] a, b, c, d;
input cin;

reg [4:0] temp1,temp2;
reg [3:0] sum1, sum2;
reg car1,car2;


always@(*)
if(operator==0)begin
	temp2 = b + d + cin;
		if(temp2 > 9) begin
			temp2 = temp2 + 6;
			car2 = 1;
		end
		else begin
			car2 = 0;
		end
		sum2= temp2[3:0];
		///////////////
		
		temp1 = a + c + car2;
		if(temp1>9) begin
			temp1 = temp1 + 6;
			car1 = 1;
		end
		else begin
			car1 = 0;
		end
		sum1 = temp1[3:0];
end
else if(operator==1)begin
	temp2 = b + (~d) + 1 + cin; // complement of 2
		if(temp2>9 && temp2 <= 15) begin
			temp2 = temp2 + 6;
			car2 = 1;
		end
		else if(temp2 > 15) begin
			car2 = 1;
		end
		else if(temp2< 0) begin
			temp2 = temp2 + 10;
			car2 = -1;
		end
		else begin
			car2=0;
		end
		
		sum2= temp2[3:0];
		///////////////
		temp1 = a + (~c) + car2;
		if(temp1>9 && temp1 <= 15) begin
			temp1 = temp1 + 6;
			car1 = 1;
		end
		else if(temp1 > 15) begin
			temp1 = temp1 + 1;
			car1=1;
		end
		else begin
			car1 = 0;
		end
		sum1 = temp1[3:0];
end
endmodule
