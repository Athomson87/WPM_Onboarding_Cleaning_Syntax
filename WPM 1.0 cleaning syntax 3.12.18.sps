* Encoding: UTF-8.

***Creating kick_nosurveyresponse

DATASET ACTIVATE DataSet1.
RECODE purpose_1 (MISSING=1) (ELSE=0) INTO kick_nosurveyresponse.
EXECUTE.

***Creating_kick_betterup

RECODE organization ('BetterUp'=1) ('BetterUp Sales'=1) (ELSE=0) INTO kick_betterup.
EXECUTE.

***Creating_kick_fidelity

RECODE organization ('Fidelity'=1) (ELSE=0) INTO kick_fidelity.
EXECUTE.

* Identify Duplicate Cases.
SORT CASES BY assessment_id(A).
MATCH FILES
  /FILE=*
  /BY assessment_id
  /FIRST=PrimaryFirst
  /LAST=PrimaryLast.
DO IF (PrimaryFirst).
COMPUTE  MatchSequence=1-PrimaryLast.
ELSE.
COMPUTE  MatchSequence=MatchSequence+1.
END IF.
LEAVE  MatchSequence.
FORMATS  MatchSequence (f7).
COMPUTE  InDupGrp=MatchSequence>0.
SORT CASES InDupGrp(D).
MATCH FILES
  /FILE=*
  /DROP=PrimaryFirst InDupGrp MatchSequence.
VARIABLE LABELS  PrimaryLast 'Indicator of each last matching case as Primary'.
VALUE LABELS  PrimaryLast 0 'Duplicate Case' 1 'Primary Case'.
VARIABLE LEVEL  PrimaryLast (ORDINAL).
FREQUENCIES VARIABLES=PrimaryLast.
EXECUTE.

***kick_duplicate

RECODE PrimaryLast (0=1) (ELSE=0) INTO kick_duplicate.
EXECUTE.

***Creating 9 items that are reverse-coded versions of 9 original items (Mindless to Mindful, Stress to Calm, Burnout to Energy)

RECODE mindless_1 mindless_2 mindless_3 stress_1 stress_2 stress_3 burnout_2 burnout_1 burnout_3 
    (1=5) (2=4) (3=3) (4=2) (5=1) INTO mindful_1 mindful_2 mindful_3 calm_1 calm_2 calm_3 energy_2 energy_1 
    energy_3.
EXECUTE.

***Create_Composite_Vars 

COMPUTE purposecomp=(purpose_1+purpose_2+purpose_3)/3.
EXECUTE.

COMPUTE engagecomp=(engage_1+engage_2+engage_3)/3.
EXECUTE.

COMPUTE energycomp=(energy_1+energy_2+energy_3)/3.
EXECUTE.

COMPUTE calmcomp=(calm_1+calm_2+calm_3)/3.
EXECUTE.

COMPUTE focuscomp=(focus_1+focus_2+focus_3)/3.
EXECUTE.

COMPUTE flowcomp=(flow_1+flow_2+flow_3)/3.
EXECUTE.

COMPUTE valuescomp=(values_1+values_2+values_3)/3.
EXECUTE.

COMPUTE mindfulcomp=(mindful_1+mindful_2+mindful_3)/3.
EXECUTE.

COMPUTE emoregcomp=(emoreg_1+emoreg_2+emoreg_3)/3.
EXECUTE.

COMPUTE resiliencecomp=(resilience_1+resilience_2+resilience_3)/3.
EXECUTE.

COMPUTE growthmindcomp=(growthmind_1+growthmind_2+growthmind_3)/3.
EXECUTE.

COMPUTE controlcomp=(control_1+control_2+control_3)/3.
EXECUTE.

COMPUTE risktolcomp=(risktol_1+risktol_2+risktol_3)/3.
EXECUTE.

COMPUTE opencomcomp=(opencom_1+opencom_2+opencom_3)/3.
EXECUTE.

COMPUTE participationcomp=(participation_1+participation_2+participation_3)/3.
EXECUTE.

COMPUTE relbuildingcomp=(relbuilding_1+relbuilding_2+relbuilding_3)/3.
EXECUTE.

COMPUTE trustclimatecomp=(trustclimate_1+trustclimate_2+trustclimate_3)/3.
EXECUTE.

COMPUTE motivatingcomp=(motivating_1+motivating_2+motivating_3)/3.
EXECUTE.

COMPUTE coachingcomp=(coaching_1+coaching_2+coaching_3)/3.
EXECUTE.

COMPUTE recogcomp=(recog_1+recog_2+recog_3)/3.
EXECUTE.

COMPUTE encowncomp=(encown_1+encown_2+encown_3)/3.
EXECUTE.

COMPUTE aligncomp=(align_1+align_2+align_3)/3.
EXECUTE.

COMPUTE probsolvecomp=(probsolve_1+probsolve_2+probsolve_3)/3.
EXECUTE.

COMPUTE feedbackcomp=(feedback_1+feedback_2+feedback_3)/3.
EXECUTE.

COMPUTE influencecomp=(influence_1+influence_2+influence_3)/3.
EXECUTE.

COMPUTE burnoutcomp=(burnout_1+burnout_2+burnout_3)/3.
EXECUTE.

COMPUTE stresscomp=(stress_1+stress_2+stress_3)/3.
EXECUTE.

COMPUTE mindlesscomp=(mindless_1+mindless_2+mindless_3)/3.
EXECUTE.

****creating kick seven point scale

SORT CASES BY activated_at(A).

COMPUTE spss_id=$CASENUM.
EXECUTE.

RECODE spss_id (Lowest thru 2692=1) (ELSE=0) INTO kick_sevenpoint.
EXECUTE.

***Selecting data to be used for analysis

DATASET ACTIVATE DataSet1.
USE ALL.
COMPUTE filter_$=(kick_sevenpoint=0 and kick_nosurveyresponse=0 and kick_betterup=0 and 
    kick_fidelity=0 and kick_duplicate=0 and user_id ~= 2809 and user_id ~= 3320).
VARIABLE LABELS filter_$ 'kick_sevenpoint=0 and kick_nosurveyresponse=0 and kick_betterup=0 and '+
    'kick_fidelity=0 and kick_duplicate=0 and user_id ~= 2809 and user_id ~= 3320 and user_id ~= 4188 and user_id ~= 4195 and user_id ~= 4187 and user_id ~= 4201 and user_id ~= 7713 and user_id ~= 7248 (FILTER)'.
VALUE LABELS filter_$ 0 'Not Selected' 1 'Selected'.
FORMATS filter_$ (f1.0).
FILTER BY filter_$.
EXECUTE.

***Freqs at indivdiual item-level

FREQUENCIES VARIABLES=purpose_1 purpose_2 purpose_3 engage_1 engage_2 engage_3 burnout_1 burnout_2 
    burnout_3 stress_1 stress_2 stress_3 focus_1 focus_2 focus_3 flow_1 flow_2 flow_3 values_1 values_2 
    values_3 mindless_1 mindless_2 mindless_3 emoreg_1 emoreg_2 emoreg_3 resilience_1 resilience_2 
    resilience_3 growthmind_1 growthmind_2 growthmind_3 control_1 control_2 control_3 risktol_1 
    risktol_2 risktol_3 opencom_1 opencom_2 opencom_3 participation_1 participation_2 participation_3 
    relbuilding_1 relbuilding_2 relbuilding_3 trustclimate_1 trustclimate_2 trustclimate_3 motivating_1 
    motivating_2 motivating_3 coaching_1 coaching_2 coaching_3 recog_1 recog_2 recog_3 encown_1 
    encown_2 encown_3 align_1 align_2 align_3 probsolve_1 probsolve_2 probsolve_3 feedback_1 feedback_2 
    feedback_3 influence_1 influence_2 influence_3
  /FORMAT=NOTABLE
  /STATISTICS=STDDEV MINIMUM MAXIMUM MEAN MEDIAN SKEWNESS SESKEW KURTOSIS SEKURT
  /HISTOGRAM NORMAL
  /ORDER=ANALYSIS.
