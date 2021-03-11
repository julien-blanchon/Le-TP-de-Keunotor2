
program pointeurs

integer, target :: m, n
integer, pointer :: p, q
integer :: retour

n = 5
m = 98
p => n
print *, "*p contient", p !5 (n)
q => m
print *, "*q contient", q !98 (m)
m = m + p
print *, "*q contient", q !103 (m)
p = 4
print *, "*p contient", p !4 (n)
p = q
print *, "*p contient", p !103 (m)

allocate(q, stat = retour)
q = 10
print *, "*q contient", q !10 (?)
deallocate(q)
if(associated(q)) then
  print *, "*q contient", q !?
else
  print *, "plus rien" !? Oui
end if

end program pointeurs
