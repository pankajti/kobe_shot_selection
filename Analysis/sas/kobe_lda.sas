libname xl XLSX 
  '/folders/myfolders/stats2_hw/term_proj2/project2Summer2019/project2KobeData.xlsx';

data modelData; set xl.modelData; run;
 
data predData; set xl.predData; run;

proc sgscatter data=modelData; 	 	 	
  matrix	shot_made_flag lat	loc_x	loc_y/ diagonal=(histogram); 
run;

 
 proc discrim data = modelData pool=yes crosslist
 testdata = predData testout= out_data;
 class shot_made_flag ; 
 var  	 	 	 	
  	lat	loc_x	loc_y	lon	minutes_remaining	
  	period	playoffs	 	seconds_remaining
 shot_distance	 	avgnoisedb; 
 run;
 

 proc discrim data = modelData pool=yes crossvalidate
 testdata = predData testout= out_data;
 class shot_made_flag ; 
 var  	 	 	 	
  	lat	loc_x	loc_y	lon	minutes_remaining	
  	period	playoffs	 	seconds_remaining
 shot_distance	 	avgnoisedb; 
 run;
 
 
 
 proc print data= out_data;
 run;
 
 
 
 