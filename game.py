#!/usr/bin/env pyhton3

print('why this kolaveri D?')

number= int(input("tell me the number,I'll make it's square :  "))
 try:
	if number ==0:
		break
	else:
		sq_no= number ** number
		print(sq_no)
except:
	print('my code just crashed')
	print(number)
