; To create different maps and panels
;
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_code.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_csm.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/contributed.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/shea_util.ncl"

; Basic map with a nice label bar format
; Lon must be the last dim, lat must be the dimension before.
; Does not draw the plot! Returns the plot for the user to draw or use as desired.
; 
; Arguments:
; ---------
; wks: an open workstation
; data: a 2D array, lat*lon
; map_res: contains the map resources
; opt: for options as attributes
; 
; Options:
; --------
; opt@lbformat: string format for labelbar prints
undef("basic_contour")
function basic_contour(wks, data, map_res:logical, opt:logical)
local format,rank,map,levels
begin

;---------------------------------------------------------------------
; Check options
  format = "%4.2f"
  if (opt .and. isatt(opt,"lbformat")) then
    format = opt@lbformat
  end if
;  format = "%4.2f"

  if (.not.map_res) then
    map_res=True
  end if

  rank = dimsizes(dimsizes(data))

;---------------------------------------------------------------------
; Create contour map

  if (rank .eq. 2) then

    ; Create contour map
    map_res@gsnDraw  = False
    map_res@gsnFrame = False
    map = gsn_csm_contour_map(wks,data, map_res)
    
    ; Change format of label bar labels if there is a labelbar.
    if (.not.isatt(map_res,"lbLabelBarOn").or.map_res@lbLabelBarOn)
      getvalues map@contour
        "cnLevels": levels
      end getvalues

      if isatt(map_res,"lbLabelStrings") then
        delete(map_res@lbLabelStrings)
      end if
      map_res@lbLabelStrings = sprintf(format,levels)
      map = gsn_csm_contour_map(wks,data,map_res)
    end if
  else
    print("in basic_contour: The data must have 2 dimensions")
    exit
  end if

  ; Return the plot to caller
  return(map)

end


; Comparison panel
;
; Create a panel to compare outputs. The panel will have the data given for
; each file/model, then the absolute differences, then the relative 
; differences (%).
; Rows will be: 
;   1.data for file = 0
;   2.data for files = 1,nfile-1
;   3.abs. difference for files = 1,nfile-1
;
; By default, the panel expect to use the attributes long_name and units as
; title of each contour plot. 
;
; WARNINGS:
;  Do not use gsnMaximize in map_res options!!!
;
; Arguments:
; wks: an open workstation
; data: 3D real array, the data to be panelled. Must have a _FillValue
;       attribute. 
; map_res: logical, attributes are plotting resources for gsn_csm_contour_map
; opt: logical, attributes are optional arguments
;
; Optional arguments:
;  wkOrientation: to change paper orientation from portrait (default) to 
;                 landscape. Note: gsnPaperOrientation will not work.
undef("panel_map")
procedure panel_map(wks, indata, map_res, opt)
local res,dim_var,model_name,seqmap,divmap,levseq,levdiv,diff_time,data,diff,tmp,max_var,min_var,abs_max,expo,max_diff,min_diff,max_perc,min_perc,xinter,yinter,nfile,ncols,maps,name_orig,long_name,nf,mres

begin

;---------------------------------------------------------------------
; Check arguments

  if (.not.isatt(indata,"_FillValue")) then
    print("panel_map: Data array needs a _FillValue attribute")
  end if

;---------------------------------------------------------------------
; Default resources

  ; Global drawing
  res = True
  res@gsnDraw         = False
  res@gsnFrame        = False
  res@gsnAddCyclic    = False
  res@gsnSpreadColors = True
  res@tfDoNDCOverlay  = True

  ; Contour mode
  res@cnFillOn             = True
  res@cnLinesOn            = False
  res@cnLevelSelectionMode = "ManualLevels"
  res@cnFillMode           = "CellFill"
  res@cnLineDrawOrder      = "Predraw"
  res@cnLineLabelsOn       = False
  res@cnInfoLabelOn        = False

  ; Label bar
  res@lbLabelBarOn         = True
  res@lbBoxMinorExtentF    = 0.20
  res@lbLabelFontHeightF   = 0.008
  res@lbLabelFontThicknessF = 2.0

  ; Continents
  res@mpGeophysicalLineColor      = "Black"
  res@mpGeophysicalLineThicknessF = 2

  ; Tick marks
  res@pmTickMarkDisplayMode = "Always"
  res@tmXTOn = False
  res@tmYROn = False

  ; Titles
  res@gsnStringFontHeightF = 0.008
  res@tiMainString         = ""

  ; Add time labels for animations
  if (opt.and.isatt(opt, "TimeLabel")) then
    res@gsnCenterString = opt@TimeLabel
  end if
  
  ; for significance
  if (opt.and.isatt(opt,"signif")) then

    ; split data array up into the actual differences and the stat sig probabilities
    data                = indata(0,:,:,:)
    sigdata             = indata(1,:,:,:)

    sigdata!0           = "model"
    sigdata&model       = indata&model
    sigdata!1           = "lat"
    sigdata&lat         = indata&lat
    sigdata!2           = "lon"
    sigdata&lon         = indata&lon
    sigdata@units       = ""

    data@units          = indata@units
    data!0              = "model"
    data&model          = indata&model
    data!1              = "lat"
    data&lat            = indata&lat
    data!2              = "lon"
    data&lon            = indata&lon  

    ; define resources for stippling
    sigres                 = True
    sigres@gsnDraw         = False
    sigres@gsnFrame        = False
    sigres@gsnAddCyclic    = False
    sigres@cnLevelSelectionMode = "ManualLevels"
    sigres@cnMinLevelValF   = 0.00
    sigres@cnMaxLevelValF   = 1.05
    sigres@cnLevelSpacingF  = 0.05
    sigres@cnInfoLabelOn    = False
    sigres@cnLinesOn        = False
    sigres@cnLineLabelsOn   = False
    sigres@cnFillScaleF     = 0.3 ;0.2 - for QIRRIG comp
    sigres@mpGeophysicalLineColor      = "Black"
    sigres@mpGeophysicalLineThicknessF = 2
 
 else
  data = indata
 end if

;---------------------------------------------------------------------
; Copy user specified resources from map_res

  copy_VarAtts(map_res, res)

;---------------------------------------------------------------------
; Get options

  dim_var = dimsizes(data)
; For titles
  if (opt.and.isatt(opt, "model_name")) then
    model_name=opt@model_name
  end if

; Default orientation is portrait
  if opt .and. isatt(opt, "wkOrientation") then
    setvalues wks
       "wkOrientation": opt@wkOrientation
    end setvalues
  end if

; Get color maps
  seqmap = "precip4_11lev"
  divmap = "precip_diff_12lev"
  levseq = 11
  levdiv = 12

  if (opt ) then
    if (isatt(opt, "seqmap")) then
      seqmap = opt@seqmap
    end if
    if (isatt(opt, "divmap")) then
      divmap = opt@divmap
    end if
    if (isatt(opt, "levseq")) then
      levseq = opt@levseq
    end if
    if (isatt(opt, "levdiv")) then
      levdiv = opt@levdiv
    end if
  end if


;---------------------------------------------------------------------
; Calculate differences

  diff_time = new(dim_var,float)
  diff = data - conform_dims(dim_var, data(0,:,:), (/1,2/))

;---------------------------------------------------------------------
; Get attributes, named dimensions and coordinates

  ; Copy attributes to get long_name and units if defined
  copy_VarAtts(data, diff)
  diff@long_name = "Abs. difference with " + model_name(0)

  ; Copy named dimensions and coordinates if any
  copy_VarCoords(data, diff)

;---------------------------------------------------------------------
; Define min and max over all data.
; We rescale data to have min>=1 (or min<=-1)

  ; Get max and min for plots
  max_var = max(data)
  min_var = min(data)

  abs_max = max(abs(data))
 
  ; Check if values are not too small
  if (abs_max .lt. 1 .and. abs_max .ne. 0) then
    expo = 0
    do while (abs_max .lt. 1)
      data = data*100.
      diff = diff*100.
      max_var = max_var*100.
      min_var = min_var*100.
      abs_max = abs_max*100.
      expo = expo+2
    end do
    if (.not.(isatt(data,"units"))) then
      data@units = ""
      diff@units = ""
    end if
    data@units = data@units+" (x 10^"+tostring(expo)+")"
    diff@units = diff@units+" (x 10^"+tostring(expo)+")"
  end if
      
  ; Get min/max for differences
  max_diff = max(abs(diff(1:dim_var(0)-1,:,:)))
  min_diff = -max_diff
 
  ; Limit max and min
  if (opt) then
     if (isatt(opt,"lim_Mvar") .and. max_var .gt. opt@lim_Mvar) then 
        max_var = opt@lim_Mvar
     end if
     if (isatt(opt,"lim_mvar") .and. min_var .lt. opt@lim_mvar) then
        min_var = opt@lim_mvar
     end if
     if (isatt(opt,"lim_Mdiff")) then ; .and. max_diff .gt. opt@lim_Mdiff) then
        max_diff = opt@lim_Mdiff
        min_diff = -max_diff
     end if
  end if

  ; Limit max and min
  if (opt) then
     if (isatt(opt,"lim_max")) then
        max_var = opt@lim_max
     end if
     if (isatt(opt,"lim_min")) then
        min_var = opt@lim_min
     end if
     if (isatt(opt,"lim_diff")) then
        max_diff = opt@lim_diff
        min_diff = -max_diff
     end if
  end if

;---------------------------------------------------------------------
; Define positions and size of each plot

  res@vpKeepAspect = True
; 3 rows always
  res@vpHeightF = 0.15

  if(opt) then
    if (isatt(opt,"xinter")) then
      xinter = opt@xinter
    else
      xinter = 0.03
    end if
    if (isatt(opt,"yinter")) then
      yinter = opt@yinter
    else
      yinter = 0.001
    end if
  end if

  ;xinter = 0.05 ;for single ; 0.03 ; for many 
  ;yinter = 0.07 ;for single ;0.001 ; for many

; Determine the number of columns
  nfile = dim_var(0)
  ncols = nfile - 1

  res@vpWidthF = 0.8/ncols - xinter*(ncols-1)
  
;---------------------------------------------------------------------
; Define plots, but not drawing

  maps = new((nfile-1)*3+1,graphic)
  plotsig = new((nfile-1)*3+1,graphic)
  gsn_define_colormap(wks, seqmap)

  ; First plot
  if (.not.(isatt(res, "cnMaxLevelValF"))) then
    res@cnMaxLevelValF = max_var
  end if
  if (.not.(isatt(res, "cnMinLevelValF"))) then
    res@cnMinLevelValF = min_var
  end if

res@cnMaxLevelValF = 100.
res@cnMinLevelValF = 0.
res@cnLevelSpacingF = 10.

  max_var = tofloat(res@cnMaxLevelValF)
  min_var = tofloat(res@cnMinLevelValF)
  if (map_res .and.isatt(map_res,"cnLevelSpacingF")) then
    cnLevelSpacingF = tofloat(map_res@cnLevelSpacingF)
  else
    cnLevelSpacingF = tofloat((max_var - min_var)/levseq)
  end if
  res@cnLevelSpacingF = cnLevelSpacingF
  res@vpXF = 0.05
  res@vpYF = 0.95

  ; Define long_name
  ; Use model_name if defined
  name_orig=""
  if isatt(data, "long_name") then
    name_orig = data@long_name
  end if

  long_name = ""
  if (isvar("model_name")) then
    long_name = model_name(0)+ " "+name_orig
  end if
  data@long_name = long_name

  maps(0) = basic_contour(wks,data(0,:,:),res,opt)
  
  ; Plot data per column now: 1/ data, 2/ abs. difference, 3/ percentage 
  ; this way we only need 1 loop over the number of files

  do nf=1, nfile-1

    ;-------------------------
    ; DATA

    ; Define long_name
    ; Use model_name if defined
    long_name = ""
    if (isvar("model_name")) then
      long_name = model_name(nf)+ " "+name_orig
    end if
    data@long_name = long_name

    ; Get levels for contour
    gsn_define_colormap(wks, seqmap)
    res@cnMaxLevelValF = max_var
    res@cnMinLevelValF = min_var
    res@cnLevelSpacingF = cnLevelSpacingF

    ; Position: 
    res@vpXF = 0.05 + (res@vpWidthF + xinter)*(nf-1)
    res@vpYF = 0.95 - (res@vpHeightF + yinter)

    if (opt.and.isatt(opt, "TimeLabel")) then
      res@gsnCenterString = opt@TimeLabel
    end if

res@cnMaxLevelValF = 100.
res@cnMinLevelValF = 0.
res@cnLevelSpacingF = 10.

    ; Plot
    maps(nf) = basic_contour(wks,data(nf,:,:),res,opt)

    if (opt.and.isatt(opt, "TimeLabel")) then
      delete(res@gsnCenterString)
    end if

    ;-------------------------
    ; ABS DIFFERENCE

    gsn_define_colormap(wks, divmap)
    res@cnMaxLevelValF = max_diff
    res@cnMinLevelValF = min_diff
    res@cnLevelSpacingF = (max_diff - min_diff)/levdiv

    ; Position
    res@vpYF = res@vpYF - (res@vpHeightF + yinter)

;    maps(nfile+nf-1)= basic_contour(wks,diff(nf,:,:),res,opt)

    if (opt.and.isatt(opt,"signif")) then

      plotsig(nfile+nf-1) = gsn_csm_contour(wks,gsn_add_cyclic_point(sigdata(nf,:,:)),sigres)
      sigopt              = True
      sigopt@gsnShadeFillType = "pattern"
      sigopt@gsnShadeLow  = 17
      plotsig(nfile+nf-1) = gsn_contour_shade(plotsig(nfile+nf-1),0.05,30,sigopt)
      ;overlay(maps(nfile+nf-1),plotsig(nfile+nf-1))

    else

      print("No significance plot")

    end if

  end do

;---------------------------------------------------------------------
; Make panel 

  ; Maximize size on page
  mres = True
  mres@gsnDraw = False
  mres@gsnFrame = False
  maximize_output(wks, mres)

  ; Now draw with good size and good colormap!
  gsn_define_colormap(wks, seqmap)
  do nf=0, nfile-1
    print((/nf/))
    draw(maps(nf))
  end do

  gsn_define_colormap(wks, divmap)
  do nf=nfile,nfile+nfile-1-1
    print((/nf/))
    draw(maps(nf))
  end do
  do nf=2*nfile-1,3*(nfile-1)
    print((/nf/))
    draw(maps(nf))
  end do
  frame(wks)

;---------------------------------------------------------------------
; Clean up
  delete(diff)
  delete(maps)
  delete(res)

end

