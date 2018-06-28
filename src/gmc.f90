!
!                         Gmsh converter (gmc)
!
! _/  _/  _/  _/  _/  _/  _/  _/  _/  _/  _/  _/  _/  _/  _/  _/  _/  _/
module mesh_data
  implicit none
  integer :: node, nelem
  integer, allocatable :: nc(:,:)
  double precision, allocatable :: xy(:,:)
end module mesh_data
! _/  _/  _/  _/  _/  _/  _/  _/  _/  _/  _/  _/  _/  _/  _/  _/  _/  _/
module bc_data
  implicit none
  integer :: iubc, ivbc, iwbc
  integer, allocatable :: nubc(:,:), nvbc(:,:), nwbc(:,:)
  integer, allocatable :: fubc(:,:), fvbc(:,:), fwbc(:,:)

  integer :: islip
  integer, allocatable :: nslip(:)
  double precision, allocatable :: slip(:)
end module bc_data
! _/  _/  _/  _/  _/  _/  _/  _/  _/  _/  _/  _/  _/  _/  _/  _/  _/  _/
module dataset
  implicit none
  character(len=  7), parameter :: gmcinp='gmc.inp'

  character(len=  1) :: flag_fldmsh, flag_fldbc, &
                        flag_strmsh, flag_strprm, &
                        flag_plymsh

  character(len= 50) :: mesfile, bc_listfile, bcfile, phifile, &
                        strfile, prmfile, plyfile
end module dataset
! _/  _/  _/  _/  _/  _/  _/  _/  _/  _/  _/  _/  _/  _/  _/  _/  _/  _/
module key_data
  implicit none
  character(len= 11), parameter :: key_fomt='$MeshFormat'
  character(len= 14), parameter :: key_phys='$PhysicalNames'
  character(len=  6), parameter :: key_node='$Nodes'
  character(len=  9), parameter :: key_elem='$Elements'
  !character(len=  9), parameter :: key_peri='$Periodic' (Comming soon)

  !--- For post-processing datasets (Comming soon)
  !character(len=  9), parameter :: keyd_node='$NodeData'
  !character(len=  9), parameter :: keyd_elem='$ElementData'
  !character(len=  9), parameter :: keyd_elnd='$ElementNodeData'
end module key_data
! _/  _/  _/  _/  _/  _/  _/  _/  _/  _/  _/  _/  _/  _/  _/  _/  _/  _/

program gmc

implicit none

write(6,200)
200 format(//5x,'_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/',&
            /5x,'_/                                    _/',&
            /5x,'_/           Welcome to gmc           _/',&
            /5x,'_/                                    _/',&
            /5x,'_/   $MeshFormat 2.2 is supported.    _/',&
            /5x,'_/                                    _/',&
            /5x,'_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/',/)


call flopen

!call datain
!
!call chkmes
!
!call outmes
!
!call makebc

write(6,*) ''
write(6,*) 'gmc done.'
write(6,*) ''

end program gmc

