#!/bin/awk -f

BEGIN{
    x=0;y=0;z=0;c=0
} 

{
    if ($1=="ATOM") {
	x+=$7;y+=$8;z+=$9;c++
    }
} 

END{
    print x/c,y/c,z/c
}
