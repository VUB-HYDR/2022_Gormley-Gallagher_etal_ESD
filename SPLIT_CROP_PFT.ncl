; This script updates the surface files containing PFT specific fractions and 
; parameters for CLM4.0 to distinguish between managed and unmanaged crops
; Here we duplicate the crop PFT=15 parameter values into PFT=16 and then split the 
; fractional cover between PFTs 15 and 16 according R. Prestele's CA dataset to represent
; managed and unmanaged crops

; Written by Annette L. Hirsch 2017FEB16

; Set up so that where the CA extent exceeds CLMs C3 crop extent then the deficit is 
; removed from the C3 grasses

; If you include Bare Soil you don't resolve things completely as there is still 66 grid cells with excess CA

;***************************************
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_code.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_csm.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/contributed.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/shea_util.ncl"
;***************************************

begin

; User defined input arguments

DATADIR             = "/net/so4/landclim/hirscha/conserveAG/inputMODS/"
CAFILENM            = "/net/so4/landclim/hirscha/conserveAG/input_data/test_20170202/CA_5min_test.nc"

; For the ascii files remember to remove the header information

; Invariant Files
HAFILENM            = "/net/so4/landclim/hirscha/conserveAG/input_data/Carea_NOHEADER.asc"
GAFILENM            = "/net/so4/landclim/hirscha/conserveAG/input_data/Garea_NOHEADER.asc"

; Scenarios
CADIR               = "/net/so4/landclim/hirscha/conserveAG/input_data/"
;CASES               = (/"alloc_CA_base_v05_ha","alloc_CA_low_v05_ha","alloc_CA_high_v05_ha"/)
;CASENM              = (/"BASE","LOW","HIGH"/)

CASES               = (/"alloc_CA_pot_v01_ha"/)
CASENM              = (/"POT"/)

; Using crop area or not: either use byGRIDarea or byCROParea
TAG                 = "byCROParea"

PFT_PHYS_FILE       = DATADIR + "pft-physiology.clm40.c130424.nc"
PFT_INV_FILE        = DATADIR + "surfdata_0.9x1.25_simyr2000_c110921.nc"

PFT_PHYS_FILE_NEW   = DATADIR + "pft-physiology.clm40.conserveAG.nc"

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; First read in fixed variables from R. Prestele's CA dataset
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; Read in the CA data
CAFILE                     = addfile(CAFILENM,"r")
CAlon_in                   = CAFILE->longitude
CAlat                      = CAFILE->latitude(::-1)
CANLAT                     = 2160
CANLON                     = 4320
;NB longitudes -180 to 180 need to flip to 0 to 360
CAlon                     = CAlon_in + 180.

; Read in the invariant ascii files
garea_in                  = asciiread(GAFILENM,(/CANLAT,CANLON/),"double")
harea_in                  = asciiread(HAFILENM,(/CANLAT,CANLON/),"double")
; Flip the latitudes
garea_latflip             = garea_in(::-1,:)
harea_latflip             = harea_in(::-1,:)
; Flip the longitudes
GAarea                    = lonFlip(garea_latflip)
HAarea                    = lonFlip(harea_latflip)
GAarea@_FillValue         = -9999
HAarea@_FillValue         = -9999

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; First update the PCT_PFT fraction in the surfdata.pftdyn*.nc file so that the crop fraction is split according to R. Prestele's CA dataset
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

do cc = 0,dimsizes(CASES)-1

; Read in the CA area

carea_in                  = asciiread(CADIR + CASES(cc) + "_NOHEADER.asc",(/CANLAT,CANLON/),"double")
carea_latflip             = carea_in(::-1,:)
CAarea                    = lonFlip(carea_latflip)
CAarea@_FillValue         = -9999

PFT_INV_FILE_NEW    = DATADIR + "surfdata_0.9x1.25_simyr2000_conserveAG_" + CASENM(cc) + "_" + TAG + ".nc"
system("scp -p " + PFT_INV_FILE + " " + PFT_INV_FILE_NEW)

INVFILE                  = addfile(PFT_INV_FILE_NEW, "w")
P15in                    = INVFILE->PCT_PFT(15,:,:)  ; (lsmpft, lsmlat, lsmlon)

MONTHLY_LAI15_IN         = INVFILE->MONTHLY_LAI(:,15,:,:)  ; (time, lsmpft, lsmlat, lsmlon)
MONTHLY_SAI15_IN         = INVFILE->MONTHLY_SAI(:,15,:,:)  ; (time, lsmpft, lsmlat, lsmlon)
MONTHLY_HGT_TOP15_IN     = INVFILE->MONTHLY_HEIGHT_TOP(:,15,:,:)  ; (time, lsmpft, lsmlat, lsmlon)
MONTHLY_HGT_BOT15_IN     = INVFILE->MONTHLY_HEIGHT_BOT(:,15,:,:)  ; (time, lsmpft, lsmlat, lsmlon)
LATIXY                   = INVFILE->LATIXY
LONGXY                   = INVFILE->LONGXY
NLAT                     = 192
NLON                     = 288
LATRES                   = 0.9
LONRES                   = 1.25
LAT                      = fspan(min(LATIXY),max(LATIXY),NLAT)
LON                      = fspan(min(LONGXY),max(LONGXY),NLON)
PFTMASK                  = INVFILE->PFTDATA_MASK ; 1 = land, 0 = ocean
AREA                     = INVFILE->AREA ; in km^2
PFTFRAC                  = INVFILE->LANDFRAC_PFT
PFT_ALL                  = INVFILE->PCT_PFT

P15in@_FillValue  = 1e+36

; Calculate the fraction of area that is CA
print("CA dataset total CA area: " + sum(CAarea))
print("CA dataset total crop area: " + sum(HAarea))
print("CA dataset CA to crop fraction: " + (100*sum(CAarea)/sum(HAarea)))

; Aggregate the CA data onto the CLM resolution
CAarea_new               = new((/NLAT,NLON/),"double",P15in@_FillValue)
do ii = 0, NLAT-1
  do jj = 0, NLON-1

    if (PFTMASK(ii,jj).eq.0) then
 
      CAarea_new(ii,jj)  = 0

    else

      lat                = LAT(ii)
      lon                = LON(jj)
      latind             = ind(CAlat.gt.(lat-LATRES/2.) .AND. CAlat.lt.(lat+LATRES/2.))
      lonind             = ind(CAlon.gt.(lon-LONRES/2.) .AND. CAlon.lt.(lon+LONRES/2.))
      latmin             = latind(0)
      latmax             = latind(dimsizes(latind)-1)
      lonmin             = lonind(0)
      lonmax             = lonind(dimsizes(lonind)-1)
      totalCAarea        = sum(CAarea(latmin:latmax,lonmin:lonmax))
      totalgridarea      = sum(GAarea(latmin:latmax,lonmin:lonmax))
      ; Check to see if the grid area is consistent
      ; there are 5 grid cells where there is a mismatch - islands
;      if ( .not.ismissing(AREA(ii,jj)) .AND. .not.ismissing(totalgridarea) .AND. (PFTFRAC(ii,jj)*AREA(ii,jj)).lt.totalgridarea*0.01 ) then
;        print("AREA mismatch at: " + lat + " , " + lon)
;        print("CLM AREA: " + (PFTFRAC(ii,jj)*AREA(ii,jj)) + " and CA data: " + totalgridarea*0.01 )
;      end if
      if (TAG.eq."byCROParea") then
        totalHAarea        = sum(HAarea(latmin:latmax,lonmin:lonmax))
        if (ismissing(totalHAarea).OR.totalHAarea.eq.0)
          CAarea_new(ii,jj)  = 0
        else
          CAarea_new(ii,jj)  = (totalCAarea / totalHAarea)
        end if
        delete(totalHAarea)
      else
        CAarea_new(ii,jj)  = (totalCAarea / totalgridarea)
      end if
      delete([/lat,lon,latind,lonind,latmin,latmax,lonmin,lonmax,totalCAarea,totalgridarea/])

    end if

  end do
end do

; For splitting the existing crop PFT
P15            = new((/NLAT,NLON/),"double")
P16            = new((/NLAT,NLON/),"double")
AREASUM        = new((/NLAT,NLON/),"double")
CROPAREASUM    = new((/NLAT,NLON/),"double")

do ii = 0, NLAT-1
  do jj = 0, NLON-1

    ; Where there are no crops, set the new crop fractions both to zero
    if(P15in(ii,jj).eq.0) then
      P15(ii,jj)   = 0.
      P16(ii,jj)   = 0.
    else
    if(.not.ismissing(CAarea_new(ii,jj))) then

        P15(ii,jj) = P15in(ii,jj) * (1 - CAarea_new(ii,jj))
        P16(ii,jj) = P15in(ii,jj) * CAarea_new(ii,jj)

    else
      P15(ii,jj)   = P15in(ii,jj)
      P16(ii,jj)   = 0.
    end if 
    end if

    AREASUM(ii,jj) = AREA(ii,jj) * P16(ii,jj)
    CROPAREASUM(ii,jj) = AREA(ii,jj) * P15in(ii,jj)

  end do
end do

print("CA Scenario: " + CASES(cc))
print("Number of grid cells where there is CA: " + num(CAarea_new.gt.0))
print("Number of grid cells where there is CLM C3 crop: " + num(P15in.gt.0))
print("Area in km^2 where there is CA: " + sum(AREASUM))
print("Crop Area in km^2: " + sum(CROPAREASUM))
print("% are that is CA: " + (100*sum(AREASUM)/sum(CROPAREASUM)))

INVFILE->PCT_PFT(15,:,:) = (/ P15 /)
INVFILE->PCT_PFT(16,:,:) = (/ P16 /)

; Update PFT 16 parameters with PFT 15 values
INVFILE->MONTHLY_LAI(:,16,:,:)        = MONTHLY_LAI15_IN
INVFILE->MONTHLY_SAI(:,16,:,:)        = MONTHLY_SAI15_IN
INVFILE->MONTHLY_HEIGHT_TOP(:,16,:,:) = MONTHLY_HGT_TOP15_IN
INVFILE->MONTHLY_HEIGHT_BOT(:,16,:,:) = MONTHLY_HGT_BOT15_IN

delete([/P15in,P15,P16,MONTHLY_LAI15_IN,MONTHLY_SAI15_IN,MONTHLY_HGT_TOP15_IN,MONTHLY_HGT_BOT15_IN,INVFILE/])
delete(AREASUM)

end do ; CASES loop

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Update the parameters in the PFT physiology file
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

system("scp -p " + PFT_PHYS_FILE + " " + PFT_PHYS_FILE_NEW)

PHYSFILE                 = addfile(PFT_PHYS_FILE_NEW, "w")

vNames = getfilevarnames(PHYSFILE)

do vv = 0, dimsizes(vNames)-1

  if (vNames(vv).eq."pftname") then 
    PHYSFILE->$vNames(vv)$(16,0) = tochar("c")
    PHYSFILE->$vNames(vv)$(16,1) = tochar("3")
    PHYSFILE->$vNames(vv)$(16,2) = tochar("_")
    PHYSFILE->$vNames(vv)$(16,3) = tochar("c")
    PHYSFILE->$vNames(vv)$(16,4) = tochar("r")
    PHYSFILE->$vNames(vv)$(16,5) = tochar("o")
    PHYSFILE->$vNames(vv)$(16,6) = tochar("p")
    PHYSFILE->$vNames(vv)$(16,7) = tochar("_")
    PHYSFILE->$vNames(vv)$(16,8) = tochar("m")
    PHYSFILE->$vNames(vv)$(16,9) = tochar("a")
    PHYSFILE->$vNames(vv)$(16,10) = tochar("n")
    PHYSFILE->$vNames(vv)$(16,11) = tochar("a")
    PHYSFILE->$vNames(vv)$(16,12) = tochar("g")
    PHYSFILE->$vNames(vv)$(16,13) = tochar("e")
    PHYSFILE->$vNames(vv)$(16,14) = tochar("d")
  else
    PFT15_IN                   = PHYSFILE->$vNames(vv)$(15)
    PHYSFILE->$vNames(vv)$(16) = PFT15_IN
    delete(PFT15_IN)
  end if

end do

delete([/vNames,PHYSFILE/])

end



