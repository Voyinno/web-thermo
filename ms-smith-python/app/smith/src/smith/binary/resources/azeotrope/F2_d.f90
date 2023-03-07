!        Generated by TAPENADE     (INRIA, Ecuador team)
!  Tapenade 3.15 (master) - 15 Apr 2020 11:54
!
!  Differentiation of f2 in forward (tangent) mode:
!   variations   of useful results: y
!   with respect to varying inputs: x
!   RW status of diff variables: x:in y:out

MODULE mod_F2d

	CONTAINS

	SUBROUTINE F2_D(x, xd, modelname_p, npars_p, pars_p, modelname_g, &
	& npars_g, pars_g, y, yd)
		USE MODELS_DIFF
		IMPLICIT NONE
		INTEGER, INTENT(IN) :: npars_p, npars_g
		CHARACTER(len=20), INTENT(IN) :: modelname_p, modelname_g
		DOUBLE PRECISION, DIMENSION(2), INTENT(IN) :: x
		DOUBLE PRECISION, DIMENSION(2), INTENT(IN) :: xd
		DOUBLE PRECISION, DIMENSION(npars_p), INTENT(IN) :: pars_p
		DOUBLE PRECISION, DIMENSION(npars_g), INTENT(IN) :: pars_g
		DOUBLE PRECISION, DIMENSION(2), INTENT(OUT) :: y
		DOUBLE PRECISION, DIMENSION(2), INTENT(OUT) :: yd
	! local variables
		DOUBLE PRECISION :: concentrations(3), temperature, kaux(2)
		DOUBLE PRECISION :: concentrationsd(3), temperatured, kauxd(2)
		INTEGER :: p0
		p0 = 760
	! x = (x1, T)
		concentrations(3) = 0d0
		concentrationsd = 0.D0
		concentrationsd(1) = xd(1)
		concentrations(1) = x(1)
		concentrationsd(2) = -concentrationsd(1)
		concentrations(2) = 1d0 - concentrations(1)
		temperatured = xd(2)
		temperature = x(2)
		CALL GETKAUX_D(concentrations, concentrationsd, temperature, &
	&          temperatured, modelname_p, npars_p, pars_p, modelname_g, &
	&          npars_g, pars_g, p0, kaux, kauxd)
		yd = 0.D0
		yd(1) = -kauxd(1)
		y(1) = 1d0 - kaux(1)
		yd(2) = -kauxd(2)
		y(2) = 1d0 - kaux(2)
	END SUBROUTINE F2_D

	SUBROUTINE F2_C(x, modelname_p, npars_p, pars_p, modelname_g, npars_g, &
	& pars_g, y)
		USE MODELS_DIFF
		IMPLICIT NONE
		INTEGER, INTENT(IN) :: npars_p, npars_g
		CHARACTER(len=20), INTENT(IN) :: modelname_p, modelname_g
		DOUBLE PRECISION, DIMENSION(2), INTENT(IN) :: x
		DOUBLE PRECISION, DIMENSION(npars_p), INTENT(IN) :: pars_p
		DOUBLE PRECISION, DIMENSION(npars_g), INTENT(IN) :: pars_g
		DOUBLE PRECISION, DIMENSION(2), INTENT(OUT) :: y
	! local variables
		DOUBLE PRECISION :: concentrations(3), temperature, kaux(2)
		INTEGER :: p0
		p0 = 760
	! x = (x1, T)
		concentrations(3) = 0d0
		concentrations(1) = x(1)
		concentrations(2) = 1d0 - concentrations(1)
		temperature = x(2)
		CALL GETKAUX(concentrations, temperature, modelname_p, npars_p, pars_p&
	&        , modelname_g, npars_g, pars_g, p0, kaux)
		y(1) = 1d0 - kaux(1)
		y(2) = 1d0 - kaux(2)
	END SUBROUTINE F2_C

END MODULE mod_F2d