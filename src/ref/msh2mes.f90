program msh2mes
implicit none

integer :: node, nelem, temp, ntag, phisn, enode, nelemt
integer :: etype, dms, maxid, cnt
integer :: nid(15), en(15)
integer, allocatable :: nc(:,:), tag(:,:), id(:), outid(:)
double precision, allocatable :: xy(:,:)

character(50) :: filename, infile, outfile

integer :: i, j, k, n



print *, 'File name:'
read *, filename
print *, 'Dimension:'
read *, dms
print *, 'Elemnt type:'
print *, '2: 3-node triangle'
print *, '3: 4-node quadrangle'
print *, '4: 4-node tetrahedron'
print *, '5: 8-node hexahedron'
print *, '6: 6-node prism'
read *, etype

en(1) = 2
en(2) = 3
en(3) = 4
en(4) = 4
en(5) = 8
en(6) = 6
en(6) = 6
en(15) = 1


write(infile, '(a,a4)')trim(adjustl(filename)), '.msh'
open(10,file=infile,status='old',action='read')

read(10,'()')
read(10,'()')
read(10,'()')
read(10,'()')
!read(10,*)phisn
!do i = 1, phisn
!  read(10,'()') !
!end do
!read(10,'()')
!read(10,'()')

read(10,*)node
allocate(xy(3,node))
read(10,*)(temp, (xy(j,i), j = 1, 3), i = 1, node)

read(10,'()')
read(10,'()')

read(10,*)nelem
allocate(nc(6,nelem), tag(3,nelem)) !

allocate(id(nelem))
nid(:) = 0
do i = 1, nelem
  read(10,*)temp, id(i), ntag, &
            (tag(j,i), j = 1, ntag), &
            (nc(j,i), j = 1, en(id(i))) !
  nid(id(i)) = nid(id(i)) + 1
end do

close(10)

write(outfile, '(a,a4)')trim(adjustl(filename)), '.mes'
open(11,file=outfile)

write(11,'(2i10)')node, nid(etype)
do i = 1, node
  write(11,'(i10, 3e15.6)')i, (xy(j,i), j = 1, dms)
end do
n = 0
do i = 1, nelem
  if (id(i) .eq. etype) then
    n = n + 1
    write(11,'(4i10)')n, (nc(j,i), j = 1, en(id(i)))
  end if
end do

close(11)

write(outfile, '(a,a6)')trim(adjustl(filename)), '.forbc'
open(12,file=outfile)

allocate(outid(node))
maxid = maxval(tag(2,:))
do i = 1, maxid
  cnt = 0
  outid(:) = 0
  write(12,'(a,i5,a)')'! ---', i, '   ---'
  do j = 1, nelem 
    if(tag(2,j) .eq. i) then
      do k = 1, en(id(j)) 
        outid(nc(k,j)) = 1
      end do
    end if
  end do
  do j = 1, node
    if(outid(j) .eq. 1) then
      write(12,'(i5)')j
      cnt = cnt + 1
    end if  
  end do
  write(12,'(a,i5)')'! -------', cnt
end do

close(12)



end program



