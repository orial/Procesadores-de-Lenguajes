#! /bin/bash
jflex PYPLC.flex
cup PYPLC.cup
javac *.java
echo "2**4"
java PYPLC ./prueba/caso1.pypl ./prueba/caso1.ctd
./ctd ./prueba/caso1.ctd
echo "3/4"
java PYPLC ./prueba/caso2.pypl ./prueba/caso2.ctd
./ctd ./prueba/caso2.ctd
echo "3%4"
java PYPLC ./prueba/caso3.pypl ./prueba/caso3.ctd
./ctd ./prueba/caso3.ctd
echo "3//4"
java PYPLC ./prueba/caso4.pypl ./prueba/caso4.ctd
./ctd ./prueba/caso4.ctd
echo "identacion"
java PYPLC ./prueba/caso5.pypl ./prueba/caso5.ctd
./ctd ./prueba/caso5.ctd
echo "if - elif - else"
java PYPLC ./prueba/caso6.pypl ./prueba/caso6.ctd
./ctd ./prueba/caso6.ctd
echo "if - elif - else"
java PYPLC ./prueba/caso7.pypl ./prueba/caso7.ctd
./ctd ./prueba/caso7.ctd
echo "while"
java PYPLC ./prueba/caso8.pypl ./prueba/caso8.ctd
./ctd ./prueba/caso8.ctd
echo "for"
java PYPLC ./prueba/caso9.pypl ./prueba/caso9.ctd
./ctd ./prueba/caso9.ctd
echo "primer caso"
java PYPLC ./prueba/caso10.pypl ./prueba/caso10.ctd
./ctd ./prueba/caso10.ctd
