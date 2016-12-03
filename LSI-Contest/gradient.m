function [dx, dy] = gradient(img)
   img = img(3:132, 3:68);
   [row, col] = size(img);
   dx = zeros (row,col, 'double');
   dy = zeros (row,col, 'double');
   
   
   for i = 1 : row
      for j = 1 : col
          if(i > row-2) || (j> col-2)
              dx(i,j) = 0;
              dy(i,j) = 0;
          else
            x = img(i + 2, j) - img(i,j);
            y = img(i, j + 2) - img(i,j);
          
            if x > 0
                  dx(i,j) = x;
            else
                  dx(i,j) = 0; 
            end
          
            if y > 0
                  dy(i,j) = y;
            else
                  dy(i,j) = 0; 
            end  
          end

          
      end
       
   end
   
   % Remove the 1 pixel border.
    dx = dx(2 : (size(dx, 1) - 1), 2 : (size(dx, 2) - 1));  % 128 x 64
    dy = dy(2 : (size(dy, 1) - 1), 2 : (size(dy, 2) - 1));  % 128 x 64

end