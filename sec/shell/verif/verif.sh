#!/bin/sh
# PM, le 21/3/21

export PATH=.:$PATH
rep=`pwd`

cd $rep
res=KO
if [ \( -f "F1" \) -a \( "`F1 | grep a | tr '[:print:]\n' 'n'`" = "`cat a/hurz`" \) ] ; then
	res=OK
fi
echo "F1 : "$res


cd $rep
res=KO
if [ \( -f "F2" \) -a \( "`F2`" -eq "`cat a/pfurz`" \) ] ; then
	res=OK
fi
echo "F2 : "$res

cd $rep
res=KO
if [  \( -f "F3" \) -a \( -f "a/hurz" \) -a \( -f "a/pfurz" \) ] ; then 
	cp a/hurz a/core
	cp a/pfurz core
	touch a/b/core
	F3
	if [ "`a/bar o`" -eq "`cat foo`" ] ; then
		res=OK
	fi
fi
echo "F3 : "$res

cd $rep
res=KO
if [ \( -f "F8" \) -a \( "`F8 Notice.md`" -eq 1010 \) ] ; then
	res=OK
fi
echo "F8 : "$res

cd $rep
res=KO
if [ \( -f "F11" \) -a \( "`F11 Notice.md`" -le 100 \) -a \( "`F11 Notice.md`" -gt 80 \) ] ; then
	res=OK
fi
echo "F11 : "$res

cd $rep
res=KO
if [ \( -f "S2" \) -a \( \( "`S2 < a/s | wc -l `" -eq 5 \) -o  \( "`S2 < a/s | wc -l `" -eq 6 \) \) ] ; then
	res=OK
fi
echo "S2 : "$res

cd $rep
res=KO
if [ -f "S4" -a \( "`S4 a | wc -l `" -eq 9 \) ] ; then
	res=OK
fi
echo "S4 : "$res
echo "Note : pour ce test (S4), OK et KO ne sont qu'indicatifs"

cd $rep
res=KO
if [ -f "S6"  ] ; then 
	S6 echo -v -o toto -T 14 -S -I -e -t > test
	if [ "`cat test`"  =  '-v -o toto -S -I -x' ] ; then 
	   res=OK
	fi
	rm test
fi
echo "S6 : "$res

cd $rep
res=KO
if [ \( -f "S7" \) -a \( "`S7 esope`" = epose \) ] ; then
	res=OK
fi
echo "S7 : "$res

echo "fini"
