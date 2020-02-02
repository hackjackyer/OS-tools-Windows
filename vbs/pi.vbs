set fso=CreateObject( "Scripting.FileSystemObject" )
set xx=fso.opentextfile("PI.txt",2,TRUE)
Dim f(28010)
a = 10000
b = 0
c = 28000
While b < c
     f(b) = a / 5
     b = b + 1
Wend
Do While c > 0
     d = 0
     g = c * 2
     b = c
     Do
         d = d + f(b) * a
         g = g - 1
         f(b) = d Mod g
         d = Fix(d / g)
         g = g - 1
         b = b - 1
         If b = 0 Then Exit Do
         d = d * b
        
     Loop
     c = c - 14
     xx.write(e + d \ a)
     e = d Mod a
Loop
xx.close
Set fso = nothing