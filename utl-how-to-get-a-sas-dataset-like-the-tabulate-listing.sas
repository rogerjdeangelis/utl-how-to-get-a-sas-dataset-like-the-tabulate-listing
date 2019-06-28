How to get a sas dataset like the tabulate listing                                                                  
                                                                                                                    
This one of the more difficult problems to do in one proc.                                                          
                                                                                                                    
github                                                                                                              
http://tinyurl.com/y2g8echk                                                                                         
https://github.com/rogerjdeangelis/utl-how-to-get-a-sas-dataset-like-the-tabulate-listing                           
                                                                                                                    
SAS Forum                                                                                                           
http://tinyurl.com/y4teujdc                                                                                         
https://communities.sas.com/t5/SAS-Procedures/Proc-Tabulate-Total-sum-in-last-column/m-p/569343                     
                                                                                                                    
Don't get pointed into a corner with 'proc tabulate'.                                                               
Create an output dataset that looks like the tabulate output;                                                       
The output dataset from proc tabulate is useless.                                                                   
                                                                                                                    
                                                                                                                    
It should be easier to get a 'ceosstab' SAS table.                                                                  
We need a single proc that will sort, transpose and do frequency analysis (like proc corresp)                       
                                                                                                                    
  Three solutions                                                                                                   
                                                                                                                    
      1. Use this simple solution by                                                                                
         Koyelghosh profile                                                                                         
         https://communities.sas.com/t5/user/viewprofilepage/user-id/212247                                         
                                                                                                                    
      My complicated and incomplete solutions                                                                       
                                                                                                                    
      2. Report and preloadformat (use #1 no need for preloadfmt or gen additional obs)                             
      3. Proc corresp if you can live without the completely missing columns                                        
                                                                                                                    
*_                   _                                                                                              
(_)_ __  _ __  _   _| |_                                                                                            
| | '_ \| '_ \| | | | __|                                                                                           
| | | | | |_) | |_| | |_                                                                                            
|_|_| |_| .__/ \__,_|\__|                                                                                           
        |_|                                                                                                         
;                                                                                                                   
                                                                                                                    
data have;                                                                                                          
  infile cards4;                                                                                                    
  input Patient$ CareProvider$ ProviderSex$;                                                                        
cards4;                                                                                                             
Max PT F                                                                                                            
Max PT M                                                                                                            
Pat RN F                                                                                                            
Pat MD M                                                                                                            
Pat PT F                                                                                                            
Rod MD M                                                                                                            
Tom PT M                                                                                                            
Tom PT F                                                                                                            
;;;;                                                                                                                
run;quit;                                                                                                           
                                                                                                                    
*            _               _                                                                                      
  ___  _   _| |_ _ __  _   _| |_                                                                                    
 / _ \| | | | __| '_ \| | | | __|                                                                                   
| (_) | |_| | |_| |_) | |_| | |_                                                                                    
 \___/ \__,_|\__| .__/ \__,_|\__|                                                                                   
                |_|                                                                                                 
;                                                                                                                   
                                                                                                                    
                   Medical        Physical       Registered       All                                               
WANT total obs=4   Doctor         Therapist      Nurse            Practitioners                                     
                  ------------    ------------   -------------    --------------                                    
Obs    Patient    MD_F    MD_M    PT_F    PT_M    RN_F    RN_M    TOT_F    TOT_M                                    
                                                                                                                    
 1       Max        .       .       1       1       .       .       1        1                                      
 2       Pat        .       1       1       .       1       .       2        1                                      
 3       Rod        .       1       .       .       .       .       .        1                                      
 4       Tom        .       .       1       1       .       .       1        1                                      
                                                                                                                    
                                                                                                                    
                                                                                                                    
*          _       _   _                                                                                            
 ___  ___ | |_   _| |_(_) ___  _ __  ___                                                                            
/ __|/ _ \| | | | | __| |/ _ \| '_ \/ __|                                                                           
\__ \ (_) | | |_| | |_| | (_) | | | \__ \                                                                           
|___/\___/|_|\__,_|\__|_|\___/|_| |_|___/                                                                           
                                                                                                                    
*_      _  __                _       _               _                                                              
/ |    | |/ /___  _   _  ___| | __ _| |__   ___  ___| |__                                                           
| |    | ' // _ \| | | |/ _ \ |/ _` | '_ \ / _ \/ __| '_ \                                                          
| |_   | . \ (_) | |_| |  __/ | (_| | | | | (_) \__ \ | | |                                                         
|_(_)  |_|\_\___/ \__, |\___|_|\__, |_| |_|\___/|___/_| |_|                                                         
                  |___/        |___/                                                                                
;                                                                                                                   
                                                                                                                    
data have;                                                                                                          
  infile cards4;                                                                                                    
  input Patient$ CareProvider$ ProviderSex$;                                                                        
cards4;                                                                                                             
Max PT F                                                                                                            
Max PT M                                                                                                            
Pat RN F                                                                                                            
Pat MD M                                                                                                            
Pat PT F                                                                                                            
Rod MD M                                                                                                            
Tom PT M                                                                                                            
Tom PT F                                                                                                            
;;;;                                                                                                                
run;quit;                                                                                                           
                                                                                                                    
proc report data=have nowd missing completecols out=want (drop=_break_ rename=(                                     
          _C2_  =  MD_F      /* always in alphabetical order */                                                     
          _C3_  =  MD_M                                                                                             
          _C4_  =  PT_F                                                                                             
          _C5_  =  PT_M                                                                                             
          _C6_  =  RN_F                                                                                             
          _C7_  =  RN_M                                                                                             
          _C8_  =  TOT_F                                                                                            
          _C9_  =  TOT_M                                                                                            
          ));                                                                                                       
      COLUMNS patient (careprovider, providersex) ('Total' providersex=providersex_Total);                          
      DEFINE patient / GROUP;                                                                                       
      DEFINE careprovider / ACROSS;                                                                                 
      DEFINE providersex / ACROSS;                                                                                  
      DEFINE providersex_Total / ACROSS ;                                                                           
RUN;quit;                                                                                                           
                                                                                                                    
*____                      _                 _  __           _                                                      
|___ \      _ __  _ __ ___| | ___   __ _  __| |/ _|_ __ ___ | |_                                                    
  __) |    | '_ \| '__/ _ \ |/ _ \ / _` |/ _` | |_| '_ ` _ \| __|                                                   
 / __/ _   | |_) | | |  __/ | (_) | (_| | (_| |  _| | | | | | |_                                                    
|_____(_)  | .__/|_|  \___|_|\___/ \__,_|\__,_|_| |_| |_| |_|\__|                                                   
           |_|                                                                                                      
;                                                                                                                   
                                                                                                                    
* I generate an extra set of records to male and female overall totals;                                             
data have;                                                                                                          
  input Patient$ CareProvider$ ProviderSex$;                                                                        
  output;                                                                                                           
  CareProvider='TOT';                                                                                               
  output;                                                                                                           
cards4;                                                                                                             
Max PT F                                                                                                            
Max PT M                                                                                                            
Pat RN F                                                                                                            
Pat MD M                                                                                                            
Pat PT F                                                                                                            
Rod MD M                                                                                                            
Tom PT M                                                                                                            
Tom PT F                                                                                                            
;;;;                                                                                                                
run;quit;                                                                                                           
                                                                                                                    
                                                                                                                    
/* for documentation only                                                                                           
proc sort data=have out=delete;                                                                                     
by CareProvider;                                                                                                    
run;quit;                                                                                                           
                                                                                                                    
WORK.HAVE total obs=16                                                                                              
                                                                                                                    
              Care      Provider                                                                                    
 Patient    Provider      Sex                                                                                       
                                                                                                                    
   Max        PT           F                                                                                        
   Max        PT           M                                                                                        
   Pat        PT           F                                                                                        
   Tom        PT           M                                                                                        
   Tom        PT           F                                                                                        
   Pat        MD           M                                                                                        
   Rod        MD           M                                                                                        
   Pat        RN           F                                                                                        
                                                                                                                    
   Max        TOT          F   ** for all Care Providers totals;                                                    
   Max        TOT          M   ** not needed with proc corresp                                                      
   Pat        TOT          F                                                                                        
   Pat        TOT          M                                                                                        
   Pat        TOT          F                                                                                        
   Rod        TOT          M                                                                                        
   Tom        TOT          M                                                                                        
   Tom        TOT          F                                                                                        
*/                                                                                                                  
                                                                                                                    
proc format ;                                                                                                       
  value $CareProvider2fil  "PT"="PT" "MD"="MD" "RN"="RN" "TOT"="TOT";                                               
  value $ProviderSex2fil   "M"="M" "F"="F" ;                                                                        
run;                                                                                                                
                                                                                                                    
* proc report output dataset does not honor the ods or out= layout;                                                 
proc report data=have nowd missing out=want (drop=_break_ rename=(                                                  
                                                                                                                    
          _C2_  =  MD_F      /* always in alphabetical order */                                                     
          _C3_  =  MD_M                                                                                             
          _C4_  =  PT_F                                                                                             
          _C5_  =  PT_M                                                                                             
          _C6_  =  RN_F                                                                                             
          _C7_  =  RN_M                                                                                             
          _C8_  =  TOT_F                                                                                            
          _C9_  =  TOT_M                                                                                            
          ));                                                                                                       
cols (Patient) CareProvider, ProviderSex,  n;                                                                       
define Patient / group;                                                                                             
define CareProvider  /'' across  preloadfmt f=$CareProvider2fil. ;                                                  
define ProviderSex   /'' across  preloadfmt f=$ProviderSex2fil.  ;                                                  
define n    / '';                                                                                                   
run;quit;                                                                                                           
                                                                                                                    
/*                                                                                                                  
 WANT Table total obs=4                                                                                             
                                                                                                                    
  Patient    MD_F    MD_M    PT_F    PT_M    RN_F    RN_M    TOT_F    TOT_M                                         
                                                                                                                    
    Max        .       .       1       1       .       .       1        1                                           
    Pat        .       1       1       .       1       .       2        1                                           
    Rod        .       1       .       .       .       .       .        1                                           
    Tom        .       .       1       1       .       .       1        1                                           
*/                                                                                                                  
                                                                                                                    
*_____                                                                                                              
|___ /      ___ ___  _ __ _ __ ___  ___ _ __                                                                        
  |_ \     / __/ _ \| '__| '__/ _ \/ __| '_ \                                                                       
 ___) |   | (_| (_) | |  | | |  __/\__ \ |_) |                                                                      
|____(_)   \___\___/|_|  |_|  \___||___/ .__/                                                                       
                                       |_|                                                                          
;                                                                                                                   
                                                                                                                    
                                                                                                                    
data have;                                                                                                          
  infile cards4;                                                                                                    
  input Patient$ CareProvider$ ProviderSex$;                                                                        
  output;                                                                                                           
  CareProvider='TOT';                                                                                               
  output;                                                                                                           
cards4;                                                                                                             
Max PT F                                                                                                            
Max PT M                                                                                                            
Pat RN F                                                                                                            
Pat MD M                                                                                                            
Pat PT F                                                                                                            
Rod MD M                                                                                                            
Tom PT M                                                                                                            
Tom PT F                                                                                                            
;;;;                                                                                                                
run;quit;                                                                                                           
                                                                                                                    
ods exclude all;                                                                                                    
ods output observed=want (drop=sum where=(label ne "Sum"));                                                         
proc corresp data=have observed dim=1 cross=both;                                                                   
Table Patient, CareProvider ProviderSex;                                                                            
run;quit;                                                                                                           
ods select all;                                                                                                     
                                                                                                                    
/*                                                                                                                  
NOTE Proc corresp does not provide the missing columns                                                              
                                                                                                                    
Thse are missing                                                                                                    
                                                                                                                    
Patient    MD_F   RN_M                                                                                              
                                                                                                                    
  Max        .      .                                                                                               
  Pat        .      .                                                                                               
  Rod        .      .                                                                                               
  Tom        .      .                                                                                               
                                                                                                                    
HAVCOR total obs=4                                                                                                  
                                                                                                                    
  Label    MD___M    PT___F    PT___M    RN___F    TOT___F    TOT___M                                               
                                                                                                                    
   Max        0         1         1         0         1          1                                                  
   Pat        1         1         0         1         2          1                                                  
   Rod        1         0         0         0         0          1                                                  
   Tom        0         1         1         0         1          1                                                  
*/                                                                                                                  
                                                                                                                    
