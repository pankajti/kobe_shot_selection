filename  outfile1 "/folders/myfolders/stats2_hw/term_proj2/kobe_shot_selection/Analysis
/sas/output/lda_output_sz_cross_val.csv";
 
libname xl XLSX  '/folders/myfolders/stats2_hw/term_proj2/project2Summer2019/project2KobeData.xlsx';

data modelData; set xl.modelData; run;
 
data predData; set xl.predData; run;


/* proc sgscatter data=modelData; 	 	 	 */
/*   matrix	shot_made_flag lat	loc_x	loc_y/ diagonal=(histogram);  */
/* run; */
/**
Transform data based on time remaining factor
*/

data transformed_data ;
set  modelData;
time_remaining = minutes_remaining*60 +seconds_remaining;
run;

data transformed_pred_data ;
set  predData;
time_remaining = minutes_remaining*60 +seconds_remaining;
run;

/*  */
/* proc print data=transformed_data; */
/* run; */
/*  */
/* proc print data=transformed_pred_data; */
/* run; */
 
 /**
 Run model based on continuos variable and cross_list
 #1 exclude loc_x and loc_y as these variables show perfect correlation with 
 lat and lan.
 #2. cook's d doesn't show any influential observation.
 #3. there is a relation 
 #3. VIF doesn't show any other multicolinear variables 
 */


title "Descriminate Analysis With Cross List";

 proc discrim data = transformed_data pool=yes crosslist
 testdata = transformed_pred_data testout= out_data_cross_list;
 class shot_made_flag ; 
 var  	 	 	 	
  	lat	lon	time_remaining	
  	period	playoffs	 	
 shot_distance avgnoisedb; 
 run;
 
/* proc print data=out_data_cross_list; */
/* run; */

data lda_output_cross_list ;
set out_data_cross_list ;
prediction = _INTO_;
keep recId  prediction;
run;

proc export data=lda_output_cross_list dbms = csv
outfile= "/folders/myfolders/stats2_hw/term_proj2/kobe_shot_selection/Analysis/sas/output/lda_output_cross_list.csv"
replace;
run;

 /**
 Run model based on continuos variable and cross validate
 #1 exclude loc_x and loc_y as these variables show perfect correlation with 
 lat and lan.
 #2. cook's d doesn't show any influential observation.
 #3. there is a relation 
 #3. VIF doesn't show any other multicolinear variables 
 */

title "Descriminate Analysis With Cross Validation";


 proc discrim data = transformed_data pool=yes crossvalidate
 testdata = transformed_pred_data testout= out_data_cross_val;
 class shot_made_flag ; 
 var  	 	 	 	
  	lat	lon	time_remaining	
  	period	playoffs	 	
 shot_distance	 	avgnoisedb; 
 run;
 
 
/*   */
/*  proc print data=out_data_cross_val; */
/* run; */

data lda_output_cross_val ;
set out_data_cross_val ;
prediction = _INTO_;
keep recId  prediction;
run;

proc export data=lda_output_cross_val dbms = csv

outfile="/folders/myfolders/stats2_hw/term_proj2/kobe_shot_selection/Analysis/sas/output/lda_output_cross_val.csv"
replace;

run;

/**

converting some categorical variables to continuos variable
*/

title "Descriminate Analysis With Cross Validation After Converting zone and basic to numerical values";


data transformed_data_with_sz; set transformed_data; 
 if shot_zone_basic = "Above the Break" then szBasic =  4;
 if shot_zone_basic = "Backcourt" then szBasic =  4;
 if shot_zone_basic = "In The Paint (Non-RA)" then szBasic =  1;
 if shot_zone_basic = "Left Corner" then szBasic =  3;
 if shot_zone_basic = "Left Corner 3" then szBasic =  3;
 if shot_zone_basic = "Mid-Range" then szBasic =  2;
 if shot_zone_basic = "Restricted Area" then szBasic =  1;
 if shot_zone_basic = "Right Corner" then szBasic =  4;
 if shot_zone_basic = "Right Corner 3" then szBasic =  4;
 if shot_zone_range = "24+ ft." then szRange = 4;
 if shot_zone_range = "8-16 ft." then szRange = 2;
 if shot_zone_range = "16-24 ft." then szRange = 3;
 if shot_zone_range = "Back Court Shot" then szRange = 4;
 if shot_zone_range = "Less Than 8 ft." then szRange = 1;
run;

data transformed_pred_data_with_sz; set transformed_pred_data; 
 if shot_zone_basic = "Above the Break 3" then szBasic =  4;
 if shot_zone_basic = "Backcourt" then szBasic =  4;
 if shot_zone_basic = "In The Paint (Non-RA)" then szBasic =  1;
 if shot_zone_basic = "Left Corner" then szBasic =  3;
 if shot_zone_basic = "Left Corner 3" then szBasic =  3;
 if shot_zone_basic = "Mid-Range" then szBasic =  2;
 if shot_zone_basic = "Restricted Area" then szBasic =  1;
 if shot_zone_basic = "Right Corner" then szBasic =  4;
 if shot_zone_basic = "Right Corner 3" then szBasic =  4;
 if shot_zone_range = "24+ ft." then szRange = 4;
 if shot_zone_range = "8-16 ft." then szRange = 2;
 if shot_zone_range = "16-24 ft." then szRange = 3;
 if shot_zone_range = "Back Court Shot" then szRange = 4;
 if shot_zone_range = "Less Than 8 ft." then szRange = 1;
run;

 proc discrim data = transformed_data_with_sz pool=yes  crossvalidate
 testdata = transformed_pred_data_with_sz testout= out_data__sz_cross_val;
 class shot_made_flag ; 
 var  	 	 	 	
  	lat	lon	time_remaining	
  	period	playoffs	 	
 shot_distance	 	avgnoisedb szBasic szRange; 
 run;
 
/*  proc print data=out_data__sz_cross_val; */
/* run; */

data lda_output_sz_cross_val ;
set out_data__sz_cross_val ;
prediction = _INTO_;
keep recId  prediction;
run;

proc export data=lda_output_sz_cross_val dbms = csv
outfile="/folders/myfolders/stats2_hw/term_proj2/kobe_shot_selection/Analysis/sas/output/lda_output_sz_cross_val.csv"
replace;
run;