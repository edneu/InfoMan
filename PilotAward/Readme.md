		
### University of Florida
### Clinical and Translational Science Institute
### Office of Information Management
_ _ _ _ _ _ _ 
#### Pilot Award Related Code
> _These SQL scripts were developed to convert the Existing Pilot Award Tracking File into_
> _a relational database consisting of three major tables:_  
>     **PILOTS_MASTER** - Information about each Pilot Award  
>     **PILOTS_PUB_MASTER** - Information about Publications related to the Pilot Award  
>     **PILOTS_ROI_MASTER** - Information about Awards Related to the Pilot Award  
>    
> The Key derived tables are:  
>     **PILOTS_ROI_DETAIL** - Detailed Project level records for awards identified in PILOTS_ROI_MASTER (Updated with DSP Awards History)  
   
_ _ _ _ _   
##### MySQL Scripts
>   
>  **ADMIN New Pilot Tables.sql** - Administrative Updates to clean and verify data 
>  **Make New Pilot Tables.sql**  - Convert the old Data tables to new structure
>  **Make Pilot CM and ROI Tables.sql**  -  Create the Common Metrics and Return on Investment report tables
>  **Pilot Award ROI Update.sql** - Administraive Script to Update the PILOTS_ROI_DETAIL table from the AWARDS_HISTORY_TABLE
>  **Pilot Analytics.sql**  -  Scripts used for Pilot Award Analysis for CTSI Management
>  **Pilot Reconcile.sql** - Administrative code to verify and updates to reconcile data with all sources  	

