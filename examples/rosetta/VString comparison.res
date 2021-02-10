YUP = YUP => true 
YUP = YUP (case-insensitive) => true 
YUP <> YUP => false 
YUP > YUP => false 
YUP >= YUP => true 
YUP < YUP => false 
YUP =< YUP => true 
----
YUP = Yup => false 
YUP = Yup (case-insensitive) => true 
YUP <> Yup => true 
YUP > Yup => false 
YUP >= Yup => false 
YUP < Yup => true 
YUP =< Yup => true 
----
bot = bat => false 
bot = bat (case-insensitive) => false 
bot <> bat => true 
bot > bat => true 
bot >= bat => true 
bot < bat => false 
bot =< bat => false 
----
aaa = zz => false 
aaa = zz (case-insensitive) => false 
aaa <> zz => true 
aaa > zz => false 
aaa >= zz => false 
aaa < zz => true 
aaa =< zz => true 
----