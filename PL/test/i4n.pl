i = 1;
x = 1+2*3;
factorial = 1;
while (i<x+1) {
    factorial = factorial * i;
    i = i+1;
}
if (factorial>=0)
    if (factorial < 256*256)
        print (factorial/1024);
    else
        print (-1);
