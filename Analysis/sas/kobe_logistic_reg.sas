libname xl XLSX 
  '/folders/myfolders/stats2_hw/term_proj2/project2Summer2019/project2KobeData.xlsx';

data modelData; set xl.modelData; run;
 
data predData; set xl.predData; run;

 
 proc logistic data = modelData    ;
 model shot_made_flag=   	 	 	 	
  	avgnoisedb arena_temp attendance game_date  seconds_remaining 
  minutes_remaining  lon     lat  game_event_id /  ctable pprob= 0.6 ; 
  output out=kobe_result_out 
  predprobs= individual p=predprob   ;
run;
  
  
proc print data= kobe_result_out;
run;