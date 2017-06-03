#!/bin/awk -f

{
    if ($3!="HN") 
	print $0
}

