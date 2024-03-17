//AUTHOR: RAKSITHA R , RAKSHITHA R NAYAK , SRIVATHSA //
class sudoku;
  rand bit [8:0][3:0] row_col [8:0];  
  bit [8:0][3:0] puzzle [8:0];

//Function to give input puzzle  
  function void input_puzzle(bit [8:0][3:0] local_puzzle [8:0]);
    puzzle = local_puzzle;
  endfunction

//Function to print the puzzle
  function void print(string puzzle_type, bit [8:0][3:0]array[8:0]);
    $display("---------------------------------%s----------------------------------------------", puzzle_type);
    foreach(array[i]) begin
      foreach(array[i][j])begin
        if((j+1) % 3 == 0)
        	$write("\t");
        $write("%0d\t",array[i][j]);
      end
       if(i %3 ==0)
        $display("");
      $display("");
    end
  endfunction
  
  constraint one2nine{foreach(row_col[i,j])
  	row_col[i][j] inside {[1:9]};
  }
  
  constraint row_constraint{foreach(row_col[i,j]){
  	foreach(row_col[k,l]){
  		if((i == k) && (j != l))
  			row_col[i][j] != row_col[k][l]; 
   		}
   	}
   }
      
  constraint column_constraint{foreach(row_col[i,j]){
  	foreach(row_col[k,l]){
  		if((j == l) && (i < 8) && ((i+1) != k))
  			row_col[i+1][j] != row_col[k][l]; 
  		}
  	}
  }
          
  constraint box{foreach(row_col[i,j]){
  	foreach(row_col[k,l]){
  		if((i/3 == k/3) && (j/3 == l/3) && ((i!=k)|| j!= l))
  			row_col[i][j] != row_col[k][l]; 
  		}
  	}
  } 
                
  constraint puzzle_constraint{foreach(row_col[i,j]){
  	if(puzzle[i][j] != 0)
  		row_col[i][j] == puzzle[i][j];
  	} 
  } 
endclass

module top;
  sudoku sudo;
  bit [8:0][3:0] puzzle_in [8:0] = '{'{3,0,6,5,0,8,4,0,0},'{5,2,0,0,0,0,0,0,0},'{0,8,7,0,0,0,0,3,1},'{0,0,3,0,1,0,0,8,0},'{9,0,0,8,6,3,0,0,5},'{0,5,0,0,9,0,6,0,0},'{1,3,0,0,0,0,2,5,0},'{0,0,0,0,0,0,0,7,4},'{0,0,5,2,0,6,3,0,0}};
  initial begin    
    sudo = new();
    sudo.input_puzzle(puzzle_in);
    sudo.print("GIVEN PUZZLE",sudo.puzzle);
    void'(sudo.randomize());
    sudo.print("SOLVED PUZZLE",sudo.row_col);
    $display("----------------------------------------------------------------------------------------------");
  end
endmodule
