a.out: tirgul.o
	gcc -g -o a.out tirgul.o -no-pie

tirgul.o: tirgul.s
	gcc -g -c -o tirgul.o tirgul.s

clean:
	rm -f *.o a.out
