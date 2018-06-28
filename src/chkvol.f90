subroutine check_mesh_vol

use mesh_data, only : nc, xy

implicit none


write(6,*) 'Tet. mesh volume checking... ------------------------------'

do m = 1, nelem
  n1 = nc(1,m)
  n2 = nc(2,m)
  n3 = nc(3,m)
  n4 = nc(4,m)

  x1 = xy(1,n1)
  x2 = xy(1,n2)
  x3 = xy(1,n3)
  x4 = xy(1,n4)

  y1 = xy(2,n1)
  y2 = xy(2,n2)
  y3 = xy(2,n3)
  y4 = xy(2,n4)

  z1 = xy(3,n1)
  z2 = xy(3,n2)
  z3 = xy(3,n3)
  z4 = xy(3,n4)

  a11 = x2 - x1
  a12 = x3 - x1
  a13 = x4 - x1
  a21 = y2 - y1
  a22 = y3 - y1
  a23 = y4 - y1
  a31 = z2 - z1
  a32 = z3 - z1
  a33 = z4 - z1

  vol06  = a11 * a22 * a33 + a21 * a32 * a13 &
         + a31 * a12 * a23 - a11 * a32 * a23 &
         - a31 * a22 * a13 - a21 * a12 * a33


  vol = vol06 / 6.0d0

  if(vol .le. 0.d0) then
    write(6,*)'VOLUME <= 0.0   Elem No. = ', m, '   vol = ', vol
    if( anser == y )
      nc(2,m) = n3
      nc(3,m) = n2
    end if
  end if
end do


end subroutine check_mesh_vol
