__kernel void resultlive(
  __global int* live,
  
  __global int* alive,
  __global int* produce
  
  ) {
    //Get global position in Y direction
    int row = get_global_id(1);
    //Get global position in X direction
    int col = get_global_id(0);    
    int w=8;
    for (int i = 0; i < w; i++)
    {
        
                live[row*w+i]=alive[row*w+i]+produce[row*w+i];
    }
    
}
