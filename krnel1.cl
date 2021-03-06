__kernel void remainalive(
  __global int* live,
  
  __global int* alive
  
  ) {
    //Get global position in Y direction
    int row = get_global_id(1);
   //Get global position in X direction
    int col = get_global_id(0);
    int cn=0;
    int w=8;
     if(row==0)
    {
		for (int i = 1; i < w-1; i++)
		{
			cn=0;
			if(live[row*w+i]==1)
			{
				if(live[(row)*w+i-1]==1)
                        cn++;
				if(live[(row)*w+i+1]==1)
                        cn++;
				if(live[(row+1)*w+i-1]==1)
                        cn++;
				if(live[(row+1)*w+i]==1)
                        cn++;
				if(live[(row+1)*w+i+1]==1)
                        cn++;
			}
			if(cn==3 || cn==2)
				alive[row*w+i]=1;
			else
				alive[row*w+i]=0;
			
		}
    }
	else if(row==7)
    {
		for (int i = 1; i < w-1; i++)
		{	
			cn=0;
			if(live[row*w+i]==1)
			{
				if(live[(row)*w+i-1]==1)
                        cn++;
				if(live[(row)*w+i+1]==1)
                        cn++;
				if(live[(row-1)*w+i-1]==1)
                        cn++;
				if(live[(row-1)*w+i]==1)
                        cn++;
				if(live[(row-1)*w+i+1]==1)
                        cn++;
			}
			if(cn==3||cn==2)
				alive[row*w+i]=1;
			else
				alive[row*w+i]=0;
			
		}
    }
	else if(row==0 && col==0)
    {
			cn=0;
			if(live[row*w+0]==1)
			{
				if(live[(row)*w+1]==1)
                        cn++;
				if(live[(row+1)*w+0]==1)
                        cn++;
				if(live[(row+1)*w+1]==1)
                        cn++;
				
			}
			if(cn==3||cn==2)
				alive[row*w+0]=1;
			else
				alive[row*w+0]=0;
   }
   else if(row==0 && col==7)
    {
			cn=0;
			if(live[row*w+7]==1)
			{
				if(live[(row)*w+6]==1)
                        cn++;
				if(live[(row+1)*w+7]==1)
                        cn++;
				if(live[(row+1)*w+6]==1)
                        cn++;
				
			}
			if(cn==3||cn==2)
				alive[row*w+7]=1;
			else
				alive[row*w+7]=0;
   }
   else if(row==7 && col==0)
    {
			cn=0;
			if(live[row*w+0]==1)
			{
				if(live[(row)*w+1]==1)
                        cn++;
				if(live[(row-1)*w+0]==1)
                        cn++;
				if(live[(row-1)*w+1]==1)
                        cn++;
			}
			if(cn==3 || cn==2)
				alive[row*w+0]=1;
			else
				alive[row*w+0]=0;
   }
   else if(row==7 && col==7)
    {
			cn=0;
			if(live[row*w+7]==1)
			{
				if(live[(row)*w+6]==1)
                        cn++;
				if(live[(row-1)*w+7]==1)
                        cn++;
				if(live[(row-1)*w+6]==1)
                        cn++;	
			}
			if(cn==3||cn==2)
				alive[row*w+7]=1;
            else
				alive[row*w+7]=0;
   }
    else if(col==0)
    {
			cn=0;
			if(live[row*w+0]==1)
			{
				if(live[(row-1)*w+0]==1)
                        cn++;
				if(live[(row+1)*w+0]==1)
                        cn++;
				if(live[(row-1)*w+1]==1)
                        cn++;
				if(live[(row)*w+1]==1)
                        cn++;
				if(live[(row+1)*w+1]==1)
                        cn++;
			}
			if(cn==3 || cn==2)
				alive[row*w+0]=1;
			else
				alive[row*w+0]=0;
			
		
    }
	else if(col==7)
    {
			cn=0;
			if(live[row*w+7]==1)
			{
				if(live[(row-1)*w+7]==1)
                        cn++;
				if(live[(row+1)*w+7]==1)
                        cn++;
				if(live[(row-1)*w+6]==1)
                        cn++;
				if(live[(row)*w+6]==1)
                        cn++;
				if(live[(row+1)*w+6]==1)
                        cn++;
			}
			if(cn==3 || cn==2)
				alive[row*w+7]=1;
			else
				alive[row*w+7]=0;
			
		
    }
   else
   {
		for (int i = 1; i < w-1; i++)
		{
			cn=0;
			if(live[row*w+i]==1)
			{                
                if(live[(row-1)*w+i-1]==1)
                {
                        cn++;
                }
                if(live[(row-1)*w+i]==1)
                {
                        cn++;
                }
                if(live[(row-1)*w+i+1]==1)
                {
                        cn++;
                }
                if(live[row*w+i-1]==1)
                {
                        cn++;
                }
                if(live[row*w+i+1]==1)
                {
                        cn++;
                }
                if(live[(row+1)*w+i-1]==1)
                {
                        cn++;
                }
                if(live[(row+1)*w+i]==1)
                {
                        cn++;
                }
                if(live[(row+1)*w+i+1]==1)
                       cn++;
                 
			}
			if(cn==3||cn==2)
               alive[row*w+i]=1;
			else
				alive[row*w+i]=0;
			
		}
   }
    
}
__kernel void resultlive(
  __global int* live,
  
  __global int* alive,
  __global int* produce
  
  ) {
    //Get global position in Y direction
    int row = get_global_id(1);
        
    int w=8;
    for (int i = 0; i < w; i++)
    {
        
                live[row*w+i]=alive[row*w+i]+produce[row*w+i];
    }
    
}
