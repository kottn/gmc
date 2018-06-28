program gmc
! Gmsh converter by T.Kotani
! _/  _/  _/  _/  _/  _/  _/  _/  _/  _/  _/  _/  _/  _/  _/  _/  _/  _/
integer :: i, j, k, m
integer :: nphys, node, nelem           !phys = physical
integer :: nelem_jmbl                   !jmbl = jumble
integer :: n1, n2, n3, n4
integer :: io
double precision :: x1, x2, x3, x4
double precision :: y1, y2, y3, y4
double precision :: z1, z2, z3, z4
double precision :: a11, a12, a13
double precision :: a21, a22, a23
double precision :: a31, a32, a33
double precision :: vol, vol06

integer, allocatable :: nc(:,:), nc_jmbl(:,:)
integer, allocatable :: bc(:,:)
integer :: eltype
double precision, allocatable :: xy(:,:)

character(20) :: inchar, infile, outfile
character(20) :: id_phys, id_node, id_elem
character(20), allocatable :: bcchar(:)

character(20) :: myid
! _/  _/  _/  _/  _/  _/  _/  _/  _/  _/  _/  _/  _/  _/  _/  _/  _/  _/

!============================================================
!  INITIAL PROCESSING
!============================================================
!***** SPECIFY THE INPUT FILE
write(6,*) 'Input the input-file name (without extension): '
read(5,*) inchar
infile  = trim(adjustl(inchar)) //'.msh'
outfile = trim(adjustl(inchar)) //'.mes'

!***** CHARACTER STRING SPECIFYED BLOCK-ID TYPE
write(id_phys, '(a14)')'$PhysicalNames'
write(id_node, '(a6 )')'$Nodes'
write(id_elem, '(a9 )')'$Elements'


!============================================================
!  READ PROCESSING
!============================================================
!***** READ GMESH(.MSH) FILE
open(11, file = infile, status = 'old', action = 'read')

  write(6,*) '***** Reading...'

  do


    read(11,*,iostat=io) myid

    !----- PHYSICALNAMES
    if (myid == id_phys) then
      read(11,*) nphys
      allocate(bc(2,nphys), bcchar(nphys))
      read(11,*) (((bc(i,j), bcchar(j)), i=1, 2), j = 1, nphys)
    end if


    !----- NODES
    if (myid == id_node) then
      read(11,*) node
      allocate(xy(3,node))
      read(11,*) (i, (xy(k,j), k = 1, 3), j = 1, node)
    end if


    !----- ELEMENTS
    if (myid == id_elem) then
      read(11,*) nelem_jmbl
      do i = 1, nelem_jmbl
        read(11,*) (i, eltype, (tag(k,j), k = 1, 8), j = 1, nelem_jumble)
      end do
      allocate(nc_jmbl(4,nelem_jmbl))

      allocate(nc(4,nelem))
    end if


    !----- EXIT LOOP AT EOF
    if (io < 0) exit


  end do

close(11)

write(6,'(a)') ''
write(6,'(a10,i10)') '   node = ', node
write(6,'(a10,i10)') '  nelem = ', nelem
write(6,'(a)') ''


!============================================================
!  EXPORT PROCESSING
!============================================================
!***** ".MES" FILE EXPORTING
open(22, file = outfile, status = 'replace')

  write(6,*)'***** Exporting ".mes"...'

  write(22,'(2i10)') node, nelem
  write(22,'(i10,3f15.10)') (i, (xy(k,j), k = 1, 3), j = 1, node)

  do j = 1, nelem
    write(22,'(i10,4i10)') j, nc(1,j), nc(2,j), nc(3,j), nc(4,j)
  end do

close(22)


write(6,*)'done.'
!_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/
end program gmc
