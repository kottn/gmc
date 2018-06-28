subroutine flopen

use dataset, only : gmcinp, &
                    flag_fldmsh, flag_fldbc, flag_strmsh, &
                    flag_strprm, flag_plymsh, &
                    mesfile, bc_listfile, bcfile, phifile, &
                    strfile, prmfile, plyfile

implicit none
character(len= 50) :: charm, hoge, piyo, name_fldmsh, name_strmsh


!--- read inp.
write(6,'(3a)') ' *) Reading ./',gmcinp,' ...'

open(10,file=gmcinp,status='old')
  do

    read(10,'(A1, A)') hoge, piyo
    if(hoge == '!') cycle

      charm=trim(adjustl(hoge))//trim(adjustl(piyo))
      !--- for fluid
      if(charm == '<flag_fldmsh>') then
        read(10,*)flag_fldmsh
      else if(charm == '<flag_fldbc>') then
        read(10,*)flag_fldbc
      else if(charm == '<name_fldmsh>') then
        read(10,*)name_fldmsh

      !--- structure(DEM&FCM)
      else if(charm == '<flag_strmsh>') then
        read(10,*)flag_strmsh
      else if(charm == '<flag_strprm>') then
        read(10,*)flag_strprm
      else if(charm == '<name_strmsh>') then
        read(10,*)name_strmsh

      !--- polygon(DEM)
      else if(charm == '<flag_plymsh>') then
        read(10,*)flag_plymsh                  ! 2=auto

      !--- end
      else if(charm == '<end>') then
        exit

    end if

  end do
close(10)

!--- read mesh


mesfile = trim(adjustl(name_fldmsh))//'.mes'
bc_listfile = trim(adjustl(name_fldmsh))//'_bc.txt'
bcfile = trim(adjustl(name_fldmsh))//'.bc'
phifile = trim(adjustl(name_fldmsh))//'.phi'

strfile = 'str_'//trim(adjustl(name_strmsh))//'.dat'
prmfile = 'prm_'//trim(adjustl(name_strmsh))//'.dat'

if(flag_plymsh == '2') then
  plyfile = 'waku_auto.dat'
else
  plyfile = 'waku_'//trim(adjustl(name_strmsh))//'.dat'
end if

end subroutine flopen
