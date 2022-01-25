; This script plots the PFT fractions from the RCPs used in CESMv122 transient landcover simulations

; Written by Annette Hirsch 2017-APR-18

load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/contributed.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_code.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_csm.ncl"
load "PLOT_FUNCTIONS_MULTI_COLORMAP.ncl"

;************************************************
begin

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; USER INPUT ARGUMENTS
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; Directories
INPUTDIR               = "/net/so4/landclim/hirscha/conserveAG/inputMODS/"
OUTDIR                 = "/net/so4/landclim/hirscha/conserveAG/figures/"

; Input files
PREFIX                 = "surfdata_0.9x1.25_simyr2000_"
CTL                    = "c110921"
CASES                  = (/"BASE_byCROParea","HIGH_byCROParea","LOW_byCROParea", "POT_byCROParea"/)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Program Start - DO NOT EDIT BELOW THIS LINE
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; Common resources for all contour maps
opt                    = True
opt@lbformat           = "%2.0f"  ; Label bar format.
opt@lbLabelAlignment   = "BoxCenters"
opt@seqmap             = "Cat12" ;"wind_17lev"
opt@levseq             = 10
opt@divmap             = "hotcold_18lev"
opt@levdiv             = 20
opt@lim_Mdiff          = 20
opt@lim_Mvar           = 100
opt@lim_mvar           = 100
; For single comparison use:
opt@xinter             = 0.05
opt@yinter             = 0.07

mpres                  = True
mpres@cnMissingValFillColor = "gray"

; Read in the CTL Crop data

ctlfilenm              = INPUTDIR + PREFIX + CTL + ".nc"
ctlfile                = addfile(ctlfilenm,"r")
ctlcrop                = tofloat(ctlfile->PCT_PFT(15,:,:))
ctlmask                = tofloat(ctlfile->PFTDATA_MASK)
lat2d                  = tofloat(ctlfile->LATIXY)
lon2d                  = tofloat(ctlfile->LONGXY)
delete(ctlfile)

; Resources for contour maps 
ndims                = dimsizes(ctlcrop)
nlat                 = ndims(0)
nlon                 = ndims(1)
lats                 = fspan(min(lat2d),max(lat2d),nlat)
lats@units           = "degrees_north"
lons                 = fspan(min(lon2d),max(lon2d),nlon)
lons@units           ="degrees_east"

; Loop through the different cases
do icase = 0,dimsizes(CASES)-1

  plot_var           = new((/3,nlat,nlon/),"float")
  plot_var(0,:,:)    = ctlcrop

  ; Read in the case data
  filenm             = INPUTDIR + PREFIX + "conserveAG_" + CASES(icase) + ".nc"
  efile              = addfile(filenm,"r")
  plot_var(1,:,:)    = tofloat(efile->PCT_PFT(15,:,:))
  plot_var(2,:,:)    = tofloat(efile->PCT_PFT(16,:,:))
  delete(efile)

  plot_var@units     = "[%]"
  plot_var!0         = "model"
  plot_var&model     = (/"ORIG","NON CA","CA"/) 
  plot_var!1         = "lat"
  plot_var&lat       = lats
  plot_var!2         = "lon"
  plot_var&lon       = lons
  opt@model_name     = (/"ORIG","NON CA","CA"/)

  ; Apply Land-sea mask
  locmask            = conform_dims(dimsizes(plot_var),ctlmask,(/1,2/))
  locmask@mask_val   = 0
  plot_var           = mask(plot_var,(locmask.ne.0),True)
  plot_var           = mask(plot_var,plot_var.eq.0,False)

  ; Flip longitudes from [0 ... 360] to [-180 .. 180]
  plot_var_in        = lonFlip(plot_var)
  wks                = gsn_open_wks("pdf",OUTDIR + "/CROP_COMPARISON_" +  CASES(icase))

  panel_map(wks,plot_var_in,mpres,opt)

  delete([/wks,plot_var,plot_var_in/])

end do ;do icase = 0,dimsizes(CASES)

end
