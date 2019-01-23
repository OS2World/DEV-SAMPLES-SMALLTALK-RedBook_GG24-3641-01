# Compiler Switches:
#
# /c    - Supresses Linking
# /Alfu - Customised large memory model
#         (l) far pointers for code
#         (f) far pointers for data
#         (u) different segments for stack and data
# /Gs   - Removes stack probes

dlgdll.obj:  dlgdll.c 
        cl -c -Alfu -Gs  dlgdll.c

dlgdll.res:   dlgdll.rc about.dlg  
        rc -r dlgdll.rc

dlgdll.dll:  dlgdll.obj dlgdll.def dlgdll.res 
        link  dlgdll.obj, dlgdll.dll, dlgdll, /nod llibcdll os2, dlgdll
        rc dlgdll.res  dlgdll.dll


