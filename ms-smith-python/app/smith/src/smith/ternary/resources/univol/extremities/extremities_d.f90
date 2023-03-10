!        Generated by TAPENADE     (INRIA, Ecuador team)
!  Tapenade 3.15 (master) - 15 Apr 2020 11:54
!
!  Differentiation of phi in forward (tangent) mode:
!   variations   of useful results: y
!   with respect to varying inputs: alpha temperature pars_g pars_p
!   RW status of diff variables: alpha:in y:out temperature:in
!                pars_g:in pars_p:in
!!------------------------------------------------------------------------------------------------------
!! PROJET ALCOS 2017
!>  \ problemDefinition
!!  \brief Shooting function. (EDA System characterizes the azeotrope or the univolatility curve)
!!  \param[in] ny       Shooting variable dimension (in our case ny=3 or ny=2)
!!  \param[in] y        Shooting variable (in our case y = [x1 x2 T] ot y = [x1 x2])
!!  \param[in] npar     Number of optional parameters
!!  \param[in] par      Optional parameters
!!
!!  \param[out] s       Shooting value, same dimension as y (EDA system)
MODULE MOD_EXTREM
	IMPLICIT NONE

	CONTAINS

	SUBROUTINE PHI_D(temperature, temperatured, modelname_p, npars_p, pars_p&
	& , modelname_g, npars_g, pars_g, edge, alpha, alphad, y, yd)
	  USE MODELS_DIFF
	  IMPLICIT NONE
	  INTEGER, INTENT(IN) :: npars_p, npars_g, edge
	  CHARACTER(len=20), INTENT(IN) :: modelname_p, modelname_g
	  DOUBLE PRECISION, INTENT(IN) :: temperature, alpha
	  DOUBLE PRECISION, INTENT(IN) :: temperatured, alphad
	  DOUBLE PRECISION, DIMENSION(npars_p), INTENT(IN) :: pars_p
	  DOUBLE PRECISION, DIMENSION(npars_g), INTENT(IN) :: pars_g
	  DOUBLE PRECISION, INTENT(OUT) :: y
	  DOUBLE PRECISION, INTENT(OUT) :: yd
	!!------------------------------------------------------------------------------------------------------
	!! DEFINITION OF THE LOCAL VARIABLES AND INITIALISATION
	!!------------------------------------------------------------------------------------------------------
	!! Local variables
	  DOUBLE PRECISION :: concentrations(3), k(3)
	  DOUBLE PRECISION :: concentrationsd(3), kd(3)
	  INTEGER :: p0
		INTRINSIC TRIM
		SELECT CASE  (TRIM(modelname_p))
		CASE ('Antoine', 'antoine')
		  p0 = 760
		CASE ('DIPPR', 'dippr')
		  p0 = 101325
		CASE DEFAULT
		  WRITE(*, *) 'Wrong choice of model.'
		  STOP
		END SELECT
	! x = T
		SELECT CASE  (edge)
		CASE (1)
		  concentrations(1) = 0d0
		  concentrationsd = 0.D0
		  concentrationsd(2) = alphad
		  concentrations(2) = alpha
		  concentrationsd(3) = -concentrationsd(2)
		  concentrations(3) = 1d0 - concentrations(2)
		CASE (2)
		  concentrations(2) = 0d0
		  concentrationsd = 0.D0
		  concentrationsd(3) = alphad
		  concentrations(3) = alpha
		  concentrationsd(1) = -concentrationsd(3)
		  concentrations(1) = 1d0 - concentrations(3)
		CASE (3)
		  concentrations(3) = 0d0
		  concentrationsd = 0.D0
		  concentrationsd(1) = alphad
		  concentrations(1) = alpha
		  concentrationsd(2) = -concentrationsd(1)
		  concentrations(2) = 1d0 - concentrations(1)
		CASE DEFAULT
		  WRITE(*, *) 'Wrong choice of edge.'
		  STOP
		END SELECT
		CALL GETK_D(concentrations, concentrationsd, temperature, temperatured&
	&       , modelname_p, npars_p, pars_p, modelname_g, npars_g, pars_g, p0, k, kd)
		yd = concentrations(1)*kd(1) + k(1)*concentrationsd(1) + &
	&   concentrations(2)*kd(2) + k(2)*concentrationsd(2) + concentrations(3&
	&   )*kd(3) + k(3)*concentrationsd(3)
		y = k(1)*concentrations(1) + k(2)*concentrations(2) + k(3)*&
	&   concentrations(3) - 1d0
	END SUBROUTINE PHI_D

	!!------------------------------------------------------------------------------------------------------
	!! PROJET ALCOS 2017
	!>  \ problemDefinition
	!!  \brief Shooting function. (EDA System characterizes the azeotrope or the univolatility curve)
	!!  \param[in] ny       Shooting variable dimension (in our case ny=3 or ny=2)
	!!  \param[in] y        Shooting variable (in our case y = [x1 x2 T] ot y = [x1 x2])
	!!  \param[in] npar     Number of optional parameters
	!!  \param[in] par      Optional parameters
	!!
	!!  \param[out] s       Shooting value, same dimension as y (EDA system)
	SUBROUTINE PHI_C(temperature, modelname_p, npars_p, pars_p, modelname_g&
	& , npars_g, pars_g, edge, alpha, y)
		USE MODELS_DIFF
		IMPLICIT NONE
		INTEGER, INTENT(IN) :: npars_p, npars_g, edge
		CHARACTER(len=20), INTENT(IN) :: modelname_p, modelname_g
		DOUBLE PRECISION, INTENT(IN) :: temperature, alpha
		DOUBLE PRECISION, DIMENSION(npars_p), INTENT(IN) :: pars_p
		DOUBLE PRECISION, DIMENSION(npars_g), INTENT(IN) :: pars_g
		DOUBLE PRECISION, INTENT(OUT) :: y
	!!------------------------------------------------------------------------------------------------------
	!! DEFINITION OF THE LOCAL VARIABLES AND INITIALISATION
	!!------------------------------------------------------------------------------------------------------
	!! Local variables
		DOUBLE PRECISION :: concentrations(3), k(3)
		INTEGER :: p0
		INTRINSIC TRIM
		SELECT CASE  (TRIM(modelname_p))
		CASE ('Antoine', 'antoine')
		  p0 = 760
		CASE ('DIPPR', 'dippr')
		  p0 = 101325
		CASE DEFAULT
		  WRITE(*, *) 'Wrong choice of model.'
		  STOP
		END SELECT
	! x = T
		SELECT CASE  (edge)
		CASE (1)
		  concentrations(1) = 0d0
		  concentrations(2) = alpha
		  concentrations(3) = 1d0 - concentrations(2)
		CASE (2)
		  concentrations(2) = 0d0
		  concentrations(3) = alpha
		  concentrations(1) = 1d0 - concentrations(3)
		CASE (3)
		  concentrations(3) = 0d0
		  concentrations(1) = alpha
		  concentrations(2) = 1d0 - concentrations(1)
		CASE DEFAULT
		  WRITE(*, *) 'Wrong choice of edge.'
		  STOP
		END SELECT
		CALL GETK(concentrations, temperature, modelname_p, npars_p, pars_p, &
	&     modelname_g, npars_g, pars_g, p0, k)
		y = k(1)*concentrations(1) + k(2)*concentrations(2) + k(3)*&
	&   concentrations(3) - 1d0
	END SUBROUTINE PHI_C

	!  Differentiation of psi in forward (tangent) mode:
	!   variations   of useful results: y
	!   with respect to varying inputs: alpha temperature pars_g pars_p
	!   RW status of diff variables: alpha:in y:out temperature:in
	!                pars_g:in pars_p:in
	SUBROUTINE PSI_D(temperature, temperatured, modelname_p, npars_p, pars_p&
	& , modelname_g, npars_g, pars_g, edge, alpha, alphad&
	& , indi, indj, y, yd)
		USE MODELS_DIFF
		IMPLICIT NONE
		INTEGER, INTENT(IN) :: npars_p, npars_g, edge, indi, indj
		CHARACTER(len=20), INTENT(IN) :: modelname_p, modelname_g
		DOUBLE PRECISION, INTENT(IN) :: temperature, alpha
		DOUBLE PRECISION, INTENT(IN) :: temperatured, alphad
		DOUBLE PRECISION, DIMENSION(npars_p), INTENT(IN) :: pars_p
		DOUBLE PRECISION, DIMENSION(npars_g), INTENT(IN) :: pars_g
		DOUBLE PRECISION, INTENT(OUT) :: y
		DOUBLE PRECISION, INTENT(OUT) :: yd
	!!------------------------------------------------------------------------------------------------------
	!! DEFINITION OF THE LOCAL VARIABLES AND INITIALISATION
	!!------------------------------------------------------------------------------------------------------
	!! Local variables
		DOUBLE PRECISION :: concentrations(3), k(3)
		DOUBLE PRECISION :: concentrationsd(3), kd(3)
		INTEGER :: p0
		INTRINSIC TRIM
		SELECT CASE  (TRIM(modelname_p))
		CASE ('Antoine', 'antoine')
		  p0 = 760
		CASE ('DIPPR', 'dippr')
		  p0 = 101325
		CASE DEFAULT
		  WRITE(*, *) 'Wrong choice of model.'
		  STOP
		END SELECT
	! x = T
		SELECT CASE  (edge)
		CASE (1)
		  concentrations(1) = 0d0
		  concentrationsd = 0.D0
		  concentrationsd(2) = alphad
		  concentrations(2) = alpha
		  concentrationsd(3) = -concentrationsd(2)
		  concentrations(3) = 1d0 - concentrations(2)
		CASE (2)
		  concentrations(2) = 0d0
		  concentrationsd = 0.D0
		  concentrationsd(3) = alphad
		  concentrations(3) = alpha
		  concentrationsd(1) = -concentrationsd(3)
		  concentrations(1) = 1d0 - concentrations(3)
		CASE (3)
		  concentrations(3) = 0d0
		  concentrationsd = 0.D0
		  concentrationsd(1) = alphad
		  concentrations(1) = alpha
		  concentrationsd(2) = -concentrationsd(1)
		  concentrations(2) = 1d0 - concentrations(1)
		CASE DEFAULT
		  WRITE(*, *) 'Wrong choice of edge.'
		  STOP
		END SELECT
		CALL GETK_D(concentrations, concentrationsd, temperature, temperatured&
	&       , modelname_p, npars_p, pars_p, modelname_g, npars_g, &
	&       pars_g, p0, k, kd)
		yd = kd(indi) - kd(indj)
		y = k(indi) - k(indj)
	END SUBROUTINE PSI_D

	SUBROUTINE PSI_C(temperature, modelname_p, npars_p, pars_p, modelname_g&
	& , npars_g, pars_g, edge, alpha, indi, indj, y)
		USE MODELS_DIFF
		IMPLICIT NONE
		INTEGER, INTENT(IN) :: npars_p, npars_g, edge, indi, indj
		CHARACTER(len=20), INTENT(IN) :: modelname_p, modelname_g
		DOUBLE PRECISION, INTENT(IN) :: temperature, alpha
		DOUBLE PRECISION, DIMENSION(npars_p), INTENT(IN) :: pars_p
		DOUBLE PRECISION, DIMENSION(npars_g), INTENT(IN) :: pars_g
		DOUBLE PRECISION, INTENT(OUT) :: y
	!!------------------------------------------------------------------------------------------------------
	!! DEFINITION OF THE LOCAL VARIABLES AND INITIALISATION
	!!------------------------------------------------------------------------------------------------------
	!! Local variables
		DOUBLE PRECISION :: concentrations(3), k(3)
		INTEGER :: p0
		INTRINSIC TRIM
		SELECT CASE  (TRIM(modelname_p))
		CASE ('Antoine', 'antoine')
		  p0 = 760
		CASE ('DIPPR', 'dippr')
		  p0 = 101325
		CASE DEFAULT
		  WRITE(*, *) 'Wrong choice of model.'
		  STOP
		END SELECT
	! x = T
		SELECT CASE  (edge)
		CASE (1)
		  concentrations(1) = 0d0
		  concentrations(2) = alpha
		  concentrations(3) = 1d0 - concentrations(2)
		CASE (2)
		  concentrations(2) = 0d0
		  concentrations(3) = alpha
		  concentrations(1) = 1d0 - concentrations(3)
		CASE (3)
		  concentrations(3) = 0d0
		  concentrations(1) = alpha
		  concentrations(2) = 1d0 - concentrations(1)
		CASE DEFAULT
		  WRITE(*, *) 'Wrong choice of edge.'
		  STOP
		END SELECT
		CALL GETK(concentrations, temperature, modelname_p, npars_p, pars_p, &
	&     modelname_g, npars_g, pars_g, p0, k)
		y = k(indi) - k(indj)
	END SUBROUTINE PSI_C

	!  Differentiation of extremity in forward (tangent) mode:
	!   variations   of useful results: y
	!   with respect to varying inputs: x
	!   RW status of diff variables: x:in y:out
	SUBROUTINE EXTREMITY_D(x, xd, modelname_p, npars_p, pars_p, modelname_g&
	& , npars_g, pars_g, edge, indi, indj, y, yd)
		USE MODELS_DIFF
		IMPLICIT NONE
		INTEGER, INTENT(IN) :: npars_p, npars_g, edge, indi, indj
		CHARACTER(len=20), INTENT(IN) :: modelname_p, modelname_g
		DOUBLE PRECISION, DIMENSION(2), INTENT(IN) :: x
		DOUBLE PRECISION, DIMENSION(2), INTENT(IN) :: xd
		DOUBLE PRECISION, DIMENSION(npars_p), INTENT(IN) :: pars_p
		DOUBLE PRECISION, DIMENSION(npars_g), INTENT(IN) :: pars_g
		DOUBLE PRECISION, DIMENSION(2), INTENT(OUT) :: y
		DOUBLE PRECISION, DIMENSION(2), INTENT(OUT) :: yd
	!!------------------------------------------------------------------------------------------------------
	!! DEFINITION OF THE LOCAL VARIABLES AND INITIALISATION
	!!------------------------------------------------------------------------------------------------------
	!! Local variables
		DOUBLE PRECISION :: concentrations(3), temperature, k(3)
		DOUBLE PRECISION :: concentrationsd(3), temperatured, kd(3)
		INTEGER :: p0
		INTRINSIC TRIM
		SELECT CASE  (TRIM(modelname_p))
		CASE ('Antoine', 'antoine')
		  p0 = 760
		CASE ('DIPPR', 'dippr')
		  p0 = 101325
		CASE DEFAULT
		  WRITE(*, *) 'Wrong choice of model.'
		  STOP
		END SELECT
	! x = (x1, T)
		temperatured = xd(2)
		temperature = x(2)
		SELECT CASE  (edge)
		CASE (1)
		  concentrations(1) = 0d0
		  concentrationsd = 0.D0
		  concentrationsd(2) = xd(1)
		  concentrations(2) = x(1)
		  concentrationsd(3) = -concentrationsd(2)
		  concentrations(3) = 1d0 - concentrations(2)
		CASE (2)
		  concentrations(2) = 0d0
		  concentrationsd = 0.D0
		  concentrationsd(3) = xd(1)
		  concentrations(3) = x(1)
		  concentrationsd(1) = -concentrationsd(3)
		  concentrations(1) = 1d0 - concentrations(3)
		CASE (3)
		  concentrations(3) = 0d0
		  concentrationsd = 0.D0
		  concentrationsd(1) = xd(1)
		  concentrations(1) = x(1)
		  concentrationsd(2) = -concentrationsd(1)
		  concentrations(2) = 1d0 - concentrations(1)
		CASE DEFAULT
		  WRITE(*, *) 'Wrong choice of edge.'
		  STOP
		END SELECT
		CALL GETK_D(concentrations, concentrationsd, temperature, temperatured&
	&       , modelname_p, npars_p, pars_p, modelname_g, npars_g, pars_g, p0, k, kd)
		yd = 0.D0
		yd(1) = concentrations(1)*kd(1) + k(1)*concentrationsd(1) + &
	&   concentrations(2)*kd(2) + k(2)*concentrationsd(2) + concentrations(3&
	&   )*kd(3) + k(3)*concentrationsd(3)
		y(1) = k(1)*concentrations(1) + k(2)*concentrations(2) + k(3)*&
	&   concentrations(3) - 1d0
		yd(2) = kd(indi) - kd(indj)
		y(2) = k(indi) - k(indj)
	END SUBROUTINE EXTREMITY_D

	SUBROUTINE EXTREMITY_C(x, modelname_p, npars_p, pars_p, modelname_g, &
	& npars_g, pars_g, edge, indi, indj, y)
		USE MODELS_DIFF
		IMPLICIT NONE
		INTEGER, INTENT(IN) :: npars_p, npars_g, edge, indi, indj
		CHARACTER(len=20), INTENT(IN) :: modelname_p, modelname_g
		DOUBLE PRECISION, DIMENSION(2), INTENT(IN) :: x
		DOUBLE PRECISION, DIMENSION(npars_p), INTENT(IN) :: pars_p
		DOUBLE PRECISION, DIMENSION(npars_g), INTENT(IN) :: pars_g
		DOUBLE PRECISION, DIMENSION(2), INTENT(OUT) :: y
	!!------------------------------------------------------------------------------------------------------
	!! DEFINITION OF THE LOCAL VARIABLES AND INITIALISATION
	!!------------------------------------------------------------------------------------------------------
	!! Local variables
		DOUBLE PRECISION :: concentrations(3), temperature, k(3)
		INTEGER :: p0
		INTRINSIC TRIM
		SELECT CASE  (TRIM(modelname_p))
		CASE ('Antoine', 'antoine')
		  p0 = 760
		CASE ('DIPPR', 'dippr')
		  p0 = 101325
		CASE DEFAULT
		  WRITE(*, *) 'Wrong choice of model.'
		  STOP
		END SELECT
	! x = (x1, T)
		temperature = x(2)
		SELECT CASE  (edge)
		CASE (1)
		  concentrations(1) = 0d0
		  concentrations(2) = x(1)
		  concentrations(3) = 1d0 - concentrations(2)
		CASE (2)
		  concentrations(2) = 0d0
		  concentrations(3) = x(1)
		  concentrations(1) = 1d0 - concentrations(3)
		CASE (3)
		  concentrations(3) = 0d0
		  concentrations(1) = x(1)
		  concentrations(2) = 1d0 - concentrations(1)
		CASE DEFAULT
		  WRITE(*, *) 'Wrong choice of edge.'
		  STOP
		END SELECT
		CALL GETK(concentrations, temperature, modelname_p, npars_p, pars_p, &
	&     modelname_g, npars_g, pars_g, p0, k)
		y(1) = k(1)*concentrations(1) + k(2)*concentrations(2) + k(3)*&
	&   concentrations(3) - 1d0
		y(2) = k(indi) - k(indj)
	END SUBROUTINE EXTREMITY_C

END MODULE MOD_EXTREM
