program toto

integer, pointer :: p, q, r
integer, target  :: i, j, k

i = 12
j =  3
k =  7
p => i
q => j
r => k
q = p*3 !12*3 = 36 (j)
print *, j
k = j
q = 9
print *, j !9 (j)
r = q + p
print *, k, r !k:21 (k), r:21 (k)
q => k 
k = q + k
print *, k, r !k:42 (k), r:42 (k)
!p => 3*q
!p => 3*i
!j => 9
!p => p + 1

allocate(p)

if(associated(p)) print *, "p alloué"
p = 6
print *, p
deallocate(p)
!nullify(p)
print *, p
p = 7


end program toto










