* Encoding: UTF-8.

***Creating kick_nosurveyresponse

DATASET ACTIVATE DataSet1.
RECODE finds_work_meaningful (MISSING=1) (ELSE=0) INTO kick_nosurveyresponse.
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

*** Renaming Variables

RENAME VARIABLES (finds_work_meaningful = Purpose_1).
RENAME VARIABLES (feels_inspired = Purpose_2).
RENAME VARIABLES (feels_sense_of_purpose = Purpose_3).
RENAME VARIABLES (feels_fully_immersed = Engage_1).
RENAME VARIABLES (enjoys_work = Engage_2).
RENAME VARIABLES (feels_motivated = Engage_3).
RENAME VARIABLES (feels_burned_out = Burnout_2).
RENAME VARIABLES (feels_emotionally_drained = Burnout_1).
RENAME VARIABLES (dreads_going_to_work = Burnout_3).
RENAME VARIABLES (struggles_with_stress = Stress_1).
RENAME VARIABLES (angers_over_inconveniences = Stress_2).
RENAME VARIABLES (feels_irritable = Stress_3).
RENAME VARIABLES (stays_focused_throughout_the_day = Focus_1).
RENAME VARIABLES (focuses_without_distraction = Focus_2).
RENAME VARIABLES (can_refocus_after_distraction = Focus_3).
RENAME VARIABLES (finds_self_absorbed = Flow_2).
RENAME VARIABLES (becomes_absorbed_by_work = Flow_1).
RENAME VARIABLES (loses_track_of_time = Flow_3).
RENAME VARIABLES (acts_according_to_values = Values_3).
RENAME VARIABLES (finds_values_important = Values_1).
RENAME VARIABLES (understands_core_values = Values_2).
RENAME VARIABLES (thinks_about_non_current_events = Mindless_1).
RENAME VARIABLES (distracted_by_non_current_events = Mindless_2).
RENAME VARIABLES (acts_on_autopilot = Mindless_3).
RENAME VARIABLES (controls_emotions = EmoReg_1).
RENAME VARIABLES (emotions_do_not_get_the_best_of_them = EmoReg_2).
RENAME VARIABLES (emotions_do_not_control_behavior = EmoReg_3).
RENAME VARIABLES (gets_back_on_track = Resilience_1).
RENAME VARIABLES (recovers_from_stressful_experiences = Resilience_2).
RENAME VARIABLES (copes_with_setbacks = Resilience_3).
RENAME VARIABLES (likes_to_stretch_capabilities = GrowthMind_1).
RENAME VARIABLES (enjoys_challenging_projects = GrowthMind_2).
RENAME VARIABLES (enjoys_learning_from_projects = GrowthMind_3).
RENAME VARIABLES (can_achieve_anything = Control_1).
RENAME VARIABLES (believes_can_achieve_things_they_want = Control_2).
RENAME VARIABLES (believes_has_control_over_life = Control_3).
RENAME VARIABLES (believes_it_is_better_to_try_and_fail = RiskTol_1).
RENAME VARIABLES (expects_mistakes_for_new_projects = RiskTol_2).
RENAME VARIABLES (believes_growth_requires_risks = RiskTol_3).
RENAME VARIABLES (team_openly_discusses_problems = OpenCom_1).
RENAME VARIABLES (includes_team_in_discussions = Participation_1).
RENAME VARIABLES (ensures_others_are_comfortable_providing_feedback = OpenCom_2).
RENAME VARIABLES (encourages_team_to_ask_for_help = OpenCom_3).
RENAME VARIABLES (encourages_others_to_share_ideas = Participation_2).
RENAME VARIABLES (encourages_others_to_participate_in_discussions = Participation_3).
RENAME VARIABLES (has_high_quality_relationships_with_coworkers = RelBuilding_1).
RENAME VARIABLES (knows_coworkers_personally = RelBuilding_2).
RENAME VARIABLES (trusts_coworkers = RelBuilding_3).
RENAME VARIABLES (cultivates_trust = TrustClimate_2).
RENAME VARIABLES (coworkers_can_discuss_problems = TrustClimate_1).
RENAME VARIABLES (prevents_cliques_on_teams = TrustClimate_3).
RENAME VARIABLES (expresses_energy_and_passion = Motivating_2).
RENAME VARIABLES (inspires_coworkers_to_think_creatively = Motivating_1).
RENAME VARIABLES (communicates_vision_to_coworkers = Motivating_3).
RENAME VARIABLES (has_open_conversations = Coaching_2).
RENAME VARIABLES (helps_coworkers_craft_career_goals = Coaching_1).
RENAME VARIABLES (suggests_coworkers_growth_opportunities = Coaching_3).
RENAME VARIABLES (acknowledges_individuals = Recog_1).
RENAME VARIABLES (acknowledges_team_for_great_work = Recog_2).
RENAME VARIABLES (acknowledges_coworker_for_effort = Recog_3).
RENAME VARIABLES (allows_team_to_decide_best_way = EncOwn_1).
RENAME VARIABLES (gives_coworkers_autonomy = EncOwn_2).
RENAME VARIABLES (helps_coworkers_feel_ownership = EncOwn_3).
RENAME VARIABLES (ensures_clear_understanding_of_responsibilities = Align_1).
RENAME VARIABLES (ensures_coworkers_have_resources = Align_2).
RENAME VARIABLES (ensures_coworkers_understand_goals = Align_3).
RENAME VARIABLES (finds_creative_ways_to_solve_problems = ProbSolve_1).
RENAME VARIABLES (discusses_problem_solving_with_coworkers = ProbSolve_2).
RENAME VARIABLES (develops_strategies_with_coworkers = ProbSolve_3).
RENAME VARIABLES (provides_feedback = Feedback_1).
RENAME VARIABLES (compliments_team_members = Feedback_2).
RENAME VARIABLES (provides_feedback_to_coworkers = Feedback_3).
RENAME VARIABLES (uses_logic_to_persuade = Influence_1).
RENAME VARIABLES (uses_goal_alignment_to_persuade = Influence_2).
RENAME VARIABLES (asks_for_input_on_new_ideas = Influence_3).
EXECUTE.

***Creating 9 items that are reverse-coded versions of 9 original items (Mindless to Mindful, Stress to Calm, Burnout to Energy)

RECODE Mindless_1 Mindless_2 Mindless_3 Stress_1 Stress_2 Stress_3 Burnout_2 Burnout_1 Burnout_3 
    (1=5) (2=4) (3=3) (4=2) (5=1) INTO Mindful_1 Mindful_2 Mindful_3 Calm_1 Calm_2 Calm_3 Energy_2 Energy_1 
    Energy_3.
EXECUTE.

***Create_Composite_Vars 

COMPUTE PurposeComp=(Purpose_1+Purpose_2+Purpose_3)/3.
EXECUTE.

COMPUTE EngageComp=(Engage_1+Engage_2+Engage_3)/3.
EXECUTE.

COMPUTE EnergyComp=(Energy_1+Energy_2+Energy_3)/3.
EXECUTE.

COMPUTE CalmComp=(Calm_1+Calm_2+Calm_3)/3.
EXECUTE.

COMPUTE FocusComp=(Focus_1+Focus_2+Focus_3)/3.
EXECUTE.

COMPUTE FlowComp=(Flow_1+Flow_2+Flow_3)/3.
EXECUTE.

COMPUTE ValuesComp=(Values_1+Values_2+Values_3)/3.
EXECUTE.

COMPUTE MindfulComp=(Mindful_1+Mindful_2+Mindful_3)/3.
EXECUTE.

COMPUTE EmoRegComp=(EmoReg_1+EmoReg_2+EmoReg_3)/3.
EXECUTE.

COMPUTE ResilienceComp=(Resilience_1+Resilience_2+Resilience_3)/3.
EXECUTE.

COMPUTE GrowthMindComp=(GrowthMind_1+GrowthMind_2+GrowthMind_3)/3.
EXECUTE.

COMPUTE ControlComp=(Control_1+Control_2+Control_3)/3.
EXECUTE.

COMPUTE RiskTolComp=(RiskTol_1+RiskTol_2+RiskTol_3)/3.
EXECUTE.

COMPUTE OpenComComp=(OpenCom_1+OpenCom_2+OpenCom_3)/3.
EXECUTE.

COMPUTE ParticipationComp=(Participation_1+Participation_2+Participation_3)/3.
EXECUTE.

COMPUTE RelBuildingComp=(RelBuilding_1+RelBuilding_2+RelBuilding_3)/3.
EXECUTE.

COMPUTE TrustClimateComp=(TrustClimate_1+TrustClimate_2+TrustClimate_3)/3.
EXECUTE.

COMPUTE MotivatingComp=(Motivating_1+Motivating_2+Motivating_3)/3.
EXECUTE.

COMPUTE CoachingComp=(Coaching_1+Coaching_2+Coaching_3)/3.
EXECUTE.

COMPUTE RecogComp=(Recog_1+Recog_2+Recog_3)/3.
EXECUTE.

COMPUTE EncOwnComp=(EncOwn_1+EncOwn_2+EncOwn_3)/3.
EXECUTE.

COMPUTE AlignComp=(Align_1+Align_2+Align_3)/3.
EXECUTE.

COMPUTE ProbSolveComp=(ProbSolve_1+ProbSolve_2+ProbSolve_3)/3.
EXECUTE.

COMPUTE FeedbackComp=(Feedback_1+Feedback_2+Feedback_3)/3.
EXECUTE.

COMPUTE InfluenceComp=(Influence_1+Influence_2+Influence_3)/3.
EXECUTE.

COMPUTE BurnoutComp=(Burnout_1+Burnout_2+Burnout_3)/3.
EXECUTE.

COMPUTE StressComp=(Stress_1+Stress_2+Stress_3)/3.
EXECUTE.

COMPUTE MindlessComp=(Mindless_1+Mindless_2+Mindless_3)/3.
EXECUTE.

****creating kick seven point scale

SORT CASES BY activated_at(A).

COMPUTE spss_id=$CASENUM.
EXECUTE.

RECODE spss_id (Lowest thru 1962=1) (ELSE=0) INTO kick_sevenpoint.
EXECUTE.

***Selecting data to be used for analysis

USE ALL.
COMPUTE filter_$=(kick_sevenpoint=0 and kick_duplicate=0 and kick_fidelity=0 and kick_betterup=0 
    and kick_nosurveyresponse=0).
VARIABLE LABELS filter_$ 'kick_sevenpoint=0 and kick_duplicate=0 and kick_fidelity=0 and '+
    'kick_betterup=0 and kick_nosurveyresponse=0 (FILTER)'.
VALUE LABELS filter_$ 0 'Not Selected' 1 'Selected'.
FORMATS filter_$ (f1.0).
FILTER BY filter_$.
EXECUTE.
