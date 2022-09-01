
# # ####################################################
# # # This script is a psychTestR implementation of MUSBEAT, 
# # # an online study investigating the effect of pitch on beat perception in 2:3 and 3:4 polyrhythms. 
# # # 
# # # NOTE: The script is based on POLY_ONLINE which also include, ratio and tempo experiments reported in doi: 10.1371/journal.pone.0252174. 
# # # 
# # # Date:20/4- 2022
# # # Author: Cecilie Møller
# # # Project group: Above + Jan Stupacher, Alexandre Celma-Miralles, Peter Vuust
# # ###################################################


library(htmltools)
library(psychTestR)
library(tibble)


jspsych_dir <- "jspsych-6.1.0"

head <- tags$head(
  # jsPsych files
  
  
  # # If you want to use original jspsych.js, use this:
  # includeScript(file.path(jspsych_dir, "jspsych.js")),
  
  # If you want to display text while preloading files (to save time), specify your intro_text
  # in jsPsych.init (in run-jspsych.js) and call jspsych_preloadprogressbar.js here:
  includeScript(file.path(jspsych_dir, "jspsych_preloadprogressbar.js")),
  
  includeScript(
    file.path(jspsych_dir, "plugins/jspsych-html-button-response.js")
  ),
  
  includeScript(
    file.path(jspsych_dir, "plugins/jspsych-audio-button-response.js")
  ),
  
  includeScript(
    file.path(jspsych_dir, "plugins/jspsych-html-slider-response.js")
  ),
  
  # Custom files
  includeScript(
    file.path(
      jspsych_dir,
      "plugins/jspsych_BPM/jspsych-audio-bpm-button-response.js"
    )
  ),
  includeCSS(file.path(jspsych_dir, "css/jspsych.css")),
  includeCSS("css/style.css")
)


ui_exp <- tags$div(
  head,
  includeScript("exp-rand.js"),
  includeScript("new-timeline.js"),
  includeScript("run-jspsych.js"),
  tags$div(id = "js_psych")
)


poly_pitch <- page(               #NB - this experiment is pitch only but named "poly_ratio" because it used to be part of the ratio/tempo/pitch study, and because we want to concatenate this data with the original pitch data
  ui = ui_exp,
  label = "poly_pitch",
  get_answer = function(input, ...)
    input$jspsych_results,
  validate = function(answer, ...)
    nchar(answer) > 0L,
  save_answer = TRUE
)

# PsychTestR elements


intro <- c(
welcome <-
  one_button_page(div(
    HTML("<img src='img/au_logo.png'></img> <img src='img/mib_logo.png'></img>"),
    div(
      h3(strong("Welcome!")),
      p("Thank you for your interest in participating in Center for Music in the Brain's online scientific study, which aims to assess individual differences in"),
      p(strong("musical beat perception!")),
      p("The test is fun, fast, and very simple. You will hear some musical rhythms, and your task is to simply tap along to the beat of the rhythms, using the designated button. Afterwards, we will ask you a few questions about your background."),
      p(strong("Please use headphones!")),
      p("Recommendations: take the test in quiet surroundings, use a touchscreen (smartphone/tablet) if at all possible, and do not use the browser 'Safari'."),
      p("You can expect this to take 10-15 minutes."),
      p("Please note: You have to be at least 18 years old to participate."),
      HTML("<br>"),
      HTML("<p style= 'font-size:14px'> <em>The data you generate is completely anonymous. It will be used for research purposes and shared with other researchers in a publicly available research data repository. Your participation is completely voluntary and you can leave the experiment at any time by simply closing the browser window. If you have questions, you can always contact the research group by emailing Cecilie Møller at cecilie@clin.au.dk.</em></p>"),
      p("By clicking the button below (I understand. Continue!) you confirm that you are at least 18 years old and you give your consent to participate."),
      )
  ),
  button_text = "I understand. Continue!"
       
    ),


# PAGES
device <-dropdown_page(
  label = "device",
  prompt = div(h4(strong("Device")),
              
               p("First, we need to know which device you are using to take the test?"),
               p("If possible, use a device with a touchscreen, alternatively a clickpad or mouse, rather than a laptop touchpad."),
               p(strong ("You can not use a keyboard.")),
               p("Please make sure you stick with your chosen input method throughout the test."),
               HTML("<p style= 'font-size:14px'> <em>Note, that once you click the next button, you can’t return to previous pages.</em></p>"),
               ),
  save_answer=TRUE,
  choices = c("Select current device", "Smartphone (touchscreen)","Tablet (touchscreen)","Laptop (touchscreen)", "Laptop (click button/clickpad)", "Laptop (external mouse)", "Desktop (external mouse)"),
  alternative_choice = TRUE,
  alternative_text = "Other - please state which?",
  next_button_text = "Next",
  max_width_pixels = 250,
  validate = function(answer, ...) {
    if (answer=="Select current device")
      "Which device are you using to take the test? Click the small arrow on the right of the first box to see the options. We ask because it matters for the analyses of the data you provide."
    else if (answer=="") 
      "Please tell us which device you are currently using. If you select 'Other' at the bottom of the list, please state in the designated field which type of device you use to take the test."
    else TRUE
  },
  on_complete = function(answer, state, ...) {
    set_global(key = "device", value = answer, state = state)
  }     
),

browser <- dropdown_page(
  label = "browser",
  prompt = div(h4(strong("Browser")),
               p("Which browser are you using?"),
               # HTML("<br>"),
                p("PLEASE NOTE: Safari may not work, depending on your computer's settings."),
                  ),
  save_answer=TRUE,
  choices = c("Select current browser","Firefox", "Chrome","Edge","Internet Explorer","Safari", "Opera", "I do not know"),
  alternative_choice = TRUE,
  alternative_text = "Other - please state which?",
  next_button_text = "Next",
  max_width_pixels = 250,
  validate = function(answer, ...) {
    if (answer=="Select current browser")
      "Please tells us which browser you use (click the small arrow on the right of the first box to see the options). We ask because it matters for the analyses of the data you provide."
    else if (answer=="") 
      "Please answer the question. If you select 'Other' at the bottom of the list, please state the name of your browser in the designated field."
    else TRUE
  },
  on_complete = function(answer, state, ...) {
    set_global(key = "browser", value = answer, state = state)
  }  
),


headphones<-dropdown_page(
  label = "headphones",
  prompt = div(h4(strong("Headphones?")),
               p("To take part in this experiment, please use headphones!"),
               p("How do you play the sounds?"),
  ),
  save_answer=TRUE,
  choices = c("I will play sounds through...", "over-ear headphones", "on-ear headphones","in-ear headphones", "my device's internal speakers", "external speakers"),
  alternative_choice = TRUE,
  alternative_text = "Other - please state which?",
  next_button_text = "Next",
  max_width_pixels = 260,
  validate = function(answer, ...) {
    if (answer=="I will play sounds through...")
      "Please tells how you will hear the sounds (click the small arrow on the right of the first box to see the options). We ask because it matters for the analyses of the data you provide."
    else if (answer=="") 
      "If you select 'Other' at the bottom of the list, please state in the designated field which kind of headphones or speakers you use."
    else TRUE
  },
  on_complete = function(answer, state, ...) {
    set_global(key = "headphones", value = answer, state = state)
  }  
)
)

sound_check<-one_button_page(
  
  body = div(h4(strong("Quick sound check")),
             
             p("When you click the button below, you will hear some random sounds that you can use to adjust the volume of your device to a comfortable level."),
             # p("If the experiment fails to load, or you cannot hear the sounds despite having turned up the volume, close the window and open it in a different browser, e.g., Chrome, Firefox or Edge.")
  ),
  button_text = "Play sounds"
)



# DEMOGRAPHICS



age <-dropdown_page(
  label = "age",
  prompt = div(h4(strong("We would love to know more about you...")),
               p("Thanks! You are done with the tapping part and we would like to ask some questions about yourself and your musical background before you leave us."),
               p(strong ("What is your age?")),
               ),
  save_answer=TRUE,
  choices = c("Please select","18-19 years","20-21","22-23","24-25","26-27","28-29","30-31","32-33","34-35","36-37","38-39","40-41","42-43","44-45","46-47","48-49","50-51","52-53","54-55","56-57","58-59","60-61","62-63","64-65","66-67","68-69","70-71","72-73","74-75","76-77","78-79","80 years or above"),
  next_button_text = "Next",
  max_width_pixels = 250,
  validate = function(answer, ...) {
    if (answer=="Please select")
      "Please state your age (click the small arrow on the right of the box to see the options). "
    #else if (answer=="") 
   #   "Please answer the question. If you select 'Other' at the bottom of the list, please state the name of your browser in the designated field."
    else TRUE
  },
  on_complete = function(answer, state, ...) {
    set_global(key = "age", value = answer, state = state)
  }  
)


gender<-NAFC_page(
  label = "gender",
  prompt = p(strong ("Whats is your gender?")), 
  choices = c("Female", "Male","Other","I prefer not to tell you"),
)

demographics <- c(
# RESIDENCE
residence <- dropdown_page(
  label = "residence",
  prompt = p(strong ("Country of current residency:")),
  save_answer=TRUE,
  choices = c("Please select", "Afghanistan	", "Albania	", "Algeria	", "Andorra	", "Angola	", "Anguilla	", "Antigua & Barbuda	", "Argentina	", "Armenia	", "Australia	", 
              "Austria	", "Azerbaijan	", "Bahamas	", "Bahrain	", "Bangladesh	", "Barbados	", "Belarus	", "", "Belgium	", "Belize	", "Benin	", "Bermuda	", 
              "Bhutan	", "Bolivia	", "Bosnia & Herzegovina	", "Botswana	", "Brazil	", "Brunei Darussalam	", "Bulgaria	", "Burkina Faso	", "Burundi	", "Cambodia	", 
              "Cameroon	", "Canada	", "Cape Verde	", "Cayman Islands	", "Central African Republic	", "Chad	", "Chile	", "China	", "China - Hong Kong / Macau	", "Colombia ",
              "Comoros	", "Congo	", "Congo, Democratic Republic of	", "Costa Rica	", "Croatia	", "Cuba	", "Cyprus	", "Czech Republic	", "Denmark	", "Djibouti	", "Dominica	", 
              "Dominican Republic	", "Ecuador	", "Egypt	", "El Salvador	", "Equatorial Guinea	", "Eritrea	", "Estonia	", "Ethiopia	", "Fiji	", "Finland	", "France	", 
              "French Guiana	", "Gabon	", "Gambia	", "Georgia	", "Germany	", "Ghana	", "Greece	", "Grenada	", "Guadeloupe	", "Guatemala	", "Guinea	", 
              "Guinea-Bissau	", "Guyana	", "Haiti	", "Honduras	", "Hungary	", "Iceland ", "India	", "Indonesia	", "Iran	", "Iraq	", "Israel and the Occupied Territories	",
              "Italy	", "Ivory Coast (Cote d'Ivoire)	", "Jamaica	", "Japan	", "Jordan	", "Kazakhstan	", "Kenya	", "Korea, Democratic Republic of (North Korea)	",
              "Korea, Republic of (South Korea)	", "Kosovo	", "Kuwait	", "Kyrgyz Republic (Kyrgyzstan)	", "Laos	", "Latvia	", "Lebanon	", "Lesotho	", "Liberia	",
              "Libya	", "Liechtenstein	", "Lithuania	", "Luxembourg	", "Macedonia, Republic of	", "Madagascar	", "Malawi	", "Malaysia	", "Maldives	", "Mali	",
              "Malta	", "Martinique	", "Mauritania	", "Mauritius	", "Mayotte	", "Mexico	", "Moldova, Republic of	", "Monaco	", "Mongolia	", "Montenegro	",
              "Montserrat	", "Morocco	", "Mozambique	", "Myanmar/Burma	", "Namibia	", "Nepal", "New Zealand	", "Nicaragua	", "Niger	", "Nigeria	", "Norway	",
              "Oman	", "Pacific Islands	", "Pakistan	", "Panama	", "Papua New Guinea	", "Paraguay	", "Peru	", "Philippines	", "Poland	", "Portugal	",
              "Puerto Rico	", "Qatar	", "Republic of Ireland ", "Reunion	", "Romania	", "Russian Federation	", "Rwanda	", "Saint Kitts and Nevis	", "Saint Lucia	", "Saint Vincent and the Grenadines	",
              "Samoa	", "Sao Tome and Principe	", "Saudi Arabia	", "Senegal	", "Serbia	", "Seychelles	", "Sierra Leone	", "Singapore	", "Slovak Republic (Slovakia)	",
              "Slovenia	", "Solomon Islands	", "Somalia	", "South Africa	", "South Sudan	", "Spain	", "Sri Lanka	", "Sudan	", "Suriname	", "Swaziland	", "Sweden	",
              "Switzerland	", "Syria	", "Tajikistan	", "Tanzania", "Thailand	", "Netherlands	", "Timor Leste	", "Togo	", "Trinidad & Tobago	", "Tunisia	", "Turkey	",
              "Turkmenistan	", "Turks & Caicos Islands	", "Uganda	", "UK ", "Ukraine	", "United Arab Emirates	", "United States of America (USA)	", "Uruguay	", "Uzbekistan	",
              "Venezuela	", "Vietnam	", "Virgin Islands (UK)	", "Virgin Islands (US)	", "Yemen	", "Zambia	", "Zimbabwe", "I prefer not to tell you"
),
  alternative_choice = TRUE,
  alternative_text = "Other (please state which)",
  next_button_text = "Next",
  max_width_pixels = 250,
  validate = function(answer, ...) {
    if (answer=="Please select")
      "Please select your country from the dropdown menu. If your country is not on the list, select 'other' at the bottom of the list and write the name of your country in the designated field."
    else if (answer=="") 
      "In which country do you currently live? If you select 'Other' at the bottom of the list, please write the name of your country in the designated field."
    else TRUE
  },
  on_complete = function(answer, state, ...) {
    set_global(key = "residence", value = answer, state = state)
  }     
),


# CHILDHOOD/YOUTH COUNTRY
youth_country <- dropdown_page(
  label = "youth_country",
  prompt = p(strong ("Country in which you spent the formative years of your childhood and youth:")),
  save_answer=TRUE,
  choices = c("Please select", "Afghanistan	", "Albania	", "Algeria	", "Andorra	", "Angola	", "Anguilla	", "Antigua & Barbuda	", "Argentina	", "Armenia	", "Australia	", 
              "Austria	", "Azerbaijan	", "Bahamas	", "Bahrain	", "Bangladesh	", "Barbados	", "Belarus	", "", "Belgium	", "Belize	", "Benin	", "Bermuda	", 
              "Bhutan	", "Bolivia	", "Bosnia & Herzegovina	", "Botswana	", "Brazil	", "Brunei Darussalam	", "Bulgaria	", "Burkina Faso	", "Burundi	", "Cambodia	", 
              "Cameroon	", "Canada	", "Cape Verde	", "Cayman Islands	", "Central African Republic	", "Chad	", "Chile	", "China	", "China - Hong Kong / Macau	", "Colombia ",
              "Comoros	", "Congo	", "Congo, Democratic Republic of	", "Costa Rica	", "Croatia	", "Cuba	", "Cyprus	", "Czech Republic	", "Denmark	", "Djibouti	", "Dominica	", 
              "Dominican Republic	", "Ecuador	", "Egypt	", "El Salvador	", "Equatorial Guinea	", "Eritrea	", "Estonia	", "Ethiopia	", "Fiji	", "Finland	", "France	", 
              "French Guiana	", "Gabon	", "Gambia	", "Georgia	", "Germany	", "Ghana	", "Greece	", "Grenada	", "Guadeloupe	", "Guatemala	", "Guinea	", 
              "Guinea-Bissau	", "Guyana	", "Haiti	", "Honduras	", "Hungary	", "Iceland ", "India	", "Indonesia	", "Iran	", "Iraq	", "Israel and the Occupied Territories	",
              "Italy	", "Ivory Coast (Cote d'Ivoire)	", "Jamaica	", "Japan	", "Jordan	", "Kazakhstan	", "Kenya	", "Korea, Democratic Republic of (North Korea)	",
              "Korea, Republic of (South Korea)	", "Kosovo	", "Kuwait	", "Kyrgyz Republic (Kyrgyzstan)	", "Laos	", "Latvia	", "Lebanon	", "Lesotho	", "Liberia	",
              "Libya	", "Liechtenstein	", "Lithuania	", "Luxembourg	", "Macedonia, Republic of	", "Madagascar	", "Malawi	", "Malaysia	", "Maldives	", "Mali	",
              "Malta	", "Martinique	", "Mauritania	", "Mauritius	", "Mayotte	", "Mexico	", "Moldova, Republic of	", "Monaco	", "Mongolia	", "Montenegro	",
              "Montserrat	", "Morocco	", "Mozambique	", "Myanmar/Burma	", "Namibia	", "Nepal", "New Zealand	", "Nicaragua	", "Niger	", "Nigeria	", "Norway	",
              "Oman	", "Pacific Islands	", "Pakistan	", "Panama	", "Papua New Guinea	", "Paraguay	", "Peru	", "Philippines	", "Poland	", "Portugal	",
              "Puerto Rico	", "Qatar	", "Republic of Ireland ", "Reunion	", "Romania	", "Russian Federation	", "Rwanda	", "Saint Kitts and Nevis	", "Saint Lucia	", "Saint Vincent and the Grenadines	",
              "Samoa	", "Sao Tome and Principe	", "Saudi Arabia	", "Senegal	", "Serbia	", "Seychelles	", "Sierra Leone	", "Singapore	", "Slovak Republic (Slovakia)	",
              "Slovenia	", "Solomon Islands	", "Somalia	", "South Africa	", "South Sudan	", "Spain	", "Sri Lanka	", "Sudan	", "Suriname	", "Swaziland	", "Sweden	",
              "Switzerland	", "Syria	", "Tajikistan	", "Tanzania", "Thailand	", "Netherlands	", "Timor Leste	", "Togo	", "Trinidad & Tobago	", "Tunisia	", "Turkey	",
              "Turkmenistan	", "Turks & Caicos Islands	", "Uganda	", "UK ", "Ukraine	", "United Arab Emirates	", "United States of America (USA)	", "Uruguay	", "Uzbekistan	",
              "Venezuela	", "Vietnam	", "Virgin Islands (UK)	", "Virgin Islands (US)	", "Yemen	", "Zambia	", "Zimbabwe", "I prefer not to tell you"
  ),
  alternative_choice = TRUE,
  alternative_text = "Other (please state which)",
  next_button_text = "Next",
  max_width_pixels = 250,
  validate = function(answer, ...) {
    if (answer=="Please select")
      "From the dropdown menu please select the country you grew up in. If your country is not on the list, select 'other' at the bottom of the list and write the name of your country in the designated field."
    else if (answer=="") 
      "In which country did you grow up? If you select 'other' at the bottom of the list then please write the name of your country in the designated field."
    else TRUE
  },
  on_complete = function(answer, state, ...) {
    set_global(key = "youth_country", value = answer, state = state)
  }     
),



# MOTHER TONGUE
language <- text_input_page(
  label = "language",
  width = "290px",
  prompt = p(strong ("Which language(s) do you consider your mother tongue (the language(s) of the family you grew up in)?"),
             p("If you are bilingual, please write the names of both languages beginning with the one with the strongest influence in your daily life.")),
  save_answer=TRUE,
  button_text = "Next",
  validate = function(answer, ...) {if (answer=="")
    "Please state the language(s) used in the family you grew up in."
  else TRUE
  },
  on_complete = function(answer, state, ...) {
    set_global(key = "language", value = answer, state = state)
  }  
)
)


# MUSICAL EXPERIENCE

music_exp <- c(


# ollen
ollen<-NAFC_page(
  label = "ollen",
  prompt = p(strong ("Which title best describes you?")), 
  choices = c("Nonmusician", "Music-loving nonmusician","Amateur musician","Serious amateur musician","Semiprofessional musician","Professional musician"),
  on_complete = function(answer, state, ...) {
    set_global(key = "ollen", value = answer, state = state)
    if (answer == "Nonmusician"|answer =="Music-loving nonmusician") skip_n_pages(state,16)
  }
  ),

#gold-msi item 06 from musical training subscale

MT_06<-NAFC_page(
  label = "MT_06",
  prompt = p(strong ("I can play the following number of musical instruments:")),
  choices = c("0", "1","2","3","4","5","6 or more"),
),

# gold-msi instrument item
instrument_1 <-dropdown_page(
  label = "instrument_1",
  prompt = p(strong ("The instrument I play best (including voice) is...")), 
  save_answer=TRUE,
  choices = c("Please select", "bass guitar", "clarinet (alto)","clarinet (basset)", "clarinet (soprano)", "contrabassoon", 
              "double bass", "drums", "flute", "guitar", "harp", "oboe", "organ", "piano", "saxophone (alto)", "saxophone (soprano)", "sousaphone", "trumpet", 
              "tuba", "violin", "voice", "I don't play any instrument"),
  ############## should we add piccolo, timpani, percussion? If so, this should be stated in the preregistration! ##########################################################################
  alternative_choice = TRUE,
  alternative_text = "Other (please state which)",
  next_button_text = "Next",
  max_width_pixels = 250,
  validate = function(answer, ...) {
    if (answer=="Please select")
      "Please select the instrument you play best from the dropdown menu."
    else if (answer=="") 
      "If your instrument is not on the list, please select 'Other' at the bottom of the list and write the name of the instrument you play best in the designated field."
    else TRUE
  },
  on_complete = function(answer, state, ...) {
    set_global(key = "instrument_1", value = answer, state = state)
  }
),

# custom made question on instrument experience

years_instrument_1 <- dropdown_page(
  label = "years_instr_1",
  prompt = p(strong("For how many years have you played this musical instrument?")),
  save_answer=TRUE,
  choices = c("Please select", "Less than one year", "1",	"2",	"3",	"4",	"5",	"6",	"7",	"8",	"9",	"10",	"11",	"12",	"13",	"14",	"15",	"16",	"17",
              "18",	"19",	"20", "more than 20 years", "I don't play any instrument"),

  next_button_text = "Next",
  max_width_pixels = 250,
  validate = function(answer, ...) {
    if (answer=="Please select")
      "Please provide your best estimate of the number of years you have played this musical instrument (click the small arrow on the right of the box to see the options)."
    else TRUE
  },
  on_complete = function(answer, state, ...) {
    set_global(key = "years_instr_1", value = answer, state = state)
  }  
),
# custom made question on practice habits

reg_play_1<-NAFC_page(
  label = "reg_play_1",
  prompt = p(strong ("When was the last time you played this instrument regularly?")),
  choices = c("I am currently playing this on a regular basis", "I stopped playing regularly less than a year ago","I played this on a regular basis 1-3 years ago","I played this on a regular basis more than three years ago",
              "I never played this instrument on a regular basis"),
  on_complete = function(answer, state, ...) {
    set_global(key = "reg_play_1", value = answer, state = state)
  } 
),

hours_instrument_1 <- dropdown_page(
  label = "hours_instr_1",
  prompt = p(strong("On average, how many hours per week do/did you play this instrument?")),
  save_answer=TRUE,
  choices = c("Please select", "Less than one hour", "1",	"2",	"3",	"4",	"5",	"6",	"7",	"8",	"9",	"10",	"11",	"12",	"13",	"14",	"15",	"16",	"17",
              "18",	"19",	"20", "more than 20 hours", "I never played this instrument on a regular basis", "I don't play any instrument"),
  
  next_button_text = "Next",
  max_width_pixels = 250,
  validate = function(answer, ...) {
    if (answer=="Please select")
      "Please provide your best estimate of the number of years you have played this musical instrument (click the small arrow on the right of the box to see the options). "
    else TRUE
  },
  on_complete = function(answer, state, ...) {
    set_global(key = "hours_instr_1", value = answer, state = state)
  }  
),



# instrument_2

instrument_2 <-dropdown_page(
  label = "instrument_2",
  prompt = p(strong ("The instrument I play second best (including voice) is...")), 
  save_answer=TRUE,
  choices = c("Please select", "I already stated all the instruments that I play", "bass guitar", "clarinet (alto)","clarinet (basset)", "clarinet (soprano)", "contrabassoon", 
              "double bass", "drums", "flute", "guitar", "harp", "oboe", "organ", "piano", "saxophone (alto)", "saxophone (soprano)", "sousaphone", "trumpet", 
              "tuba", "violin", "voice"),
  ############## should we add piccolo, timpani, percussion? If so, this should be stated in the preregistration! ##########################################################################
  alternative_choice = TRUE,
  alternative_text = "Other (please state which)",
  next_button_text = "Next",
  max_width_pixels = 250,
  validate = function(answer, ...) {
    if (answer=="Please select")
      "Please select the instrument you play second best from the dropdown menu."
    else if (answer=="") 
      "If your instrument is not on the list, please select 'Other' at the bottom of the list and write the name of the instrument you play second best in the designated field."
    else TRUE
  },
  on_complete = function(answer, state, ...) {
    set_global(key = "instrument_2", value = answer, state = state)
    if (answer == "I already stated all the instruments that I play") skip_n_pages(state,8)
  }
),


# custom made question on instrument experience

years_instrument_2 <- dropdown_page(
  label = "years_instr_2",
  prompt = p(strong("For how many years have you played this musical instrument?")),
  save_answer=TRUE,
  choices = c("Please select", "Less than one year", "1",	"2",	"3",	"4",	"5",	"6",	"7",	"8",	"9",	"10",	"11",	"12",	"13",	"14",	"15",	"16",	"17",
              "18",	"19",	"20", "more than 20 years"),
  
  next_button_text = "Next",
  max_width_pixels = 250,
  validate = function(answer, ...) {
    if (answer=="Please select")
      "Please provide your best estimate of the number of years you have played this musical instrument (click the small arrow on the right of the box to see the options)."
    else TRUE
  },
  on_complete = function(answer, state, ...) {
    set_global(key = "years_instr_2", value = answer, state = state)
  }  
),
# custom made question on practice habits

reg_play_2<-NAFC_page(
  label = "reg_play_2",
  prompt = p(strong ("When was the last time you played this instrument regularly?")),
  choices = c("I am currently playing this on a regular basis", "I stopped playing regularly less than a year ago","I played this on a regular basis 1-3 years ago","I played this on a regular basis more than three years ago",
              "I never played this instrument on a regular basis"),
  on_complete = function(answer, state, ...) {
    set_global(key = "reg_play_2", value = answer, state = state)
  } 
),

hours_instrument_2 <- dropdown_page(
  label = "hours_instr_2",
  prompt = p(strong("On average, how many hours per week do/did you play this instrument?")),
  save_answer=TRUE,
  choices = c("Please select", "Less than one hour", "1",	"2",	"3",	"4",	"5",	"6",	"7",	"8",	"9",	"10",	"11",	"12",	"13",	"14",	"15",	"16",	"17",
              "18",	"19",	"20", "more than 20 hours", "I never played this instrument on a regular basis"),
  
  next_button_text = "Next",
  max_width_pixels = 250,
  validate = function(answer, ...) {
    if (answer=="Please select")
      "Please provide your best estimate of the number of years you have played this musical instrument (click the small arrow on the right of the box to see the options). "
    else TRUE
  },
  on_complete = function(answer, state, ...) {
    set_global(key = "hours_instr_2", value = answer, state = state)
  }  
),


# instrument_3

instrument_3 <-dropdown_page(
  label = "instrument_3",
  prompt = p(strong ("The instrument I play third best (including voice) is...")), 
  save_answer=TRUE,
  choices = c("Please select", "I already stated all the instruments that I play", "bass guitar", "clarinet (alto)","clarinet (basset)", "clarinet (soprano)", "contrabassoon", 
              "double bass", "drums", "flute", "guitar", "harp", "oboe", "organ", "piano", "saxophone (alto)", "saxophone (soprano)", "sousaphone", "trumpet", 
              "tuba", "violin", "voice"),
  ############## should we add piccolo, timpani, percussion? If so, this should be stated in the preregistration! ##########################################################################
  alternative_choice = TRUE,
  alternative_text = "Other (please state which)",
  next_button_text = "Next",
  max_width_pixels = 250,
  validate = function(answer, ...) {
    if (answer=="Please select")
      "Please select the instrument you play third best from the dropdown menu."
    else if (answer=="") 
      "If your instrument is not on the list, please select 'Other' at the bottom of the list and write the name of the instrument you play third best in the designated field."
    else TRUE
  },
  on_complete = function(answer, state, ...) {
    set_global(key = "instrument_3", value = answer, state = state)
    if (answer == "I already stated all the instruments that I play") skip_n_pages(state,4)
  }
),


# custom made question on instrument experience

years_instrument_3 <- dropdown_page(
  label = "years_instr_3",
  prompt = p(strong("For how many years have you played this musical instrument?")),
  save_answer=TRUE,
  choices = c("Please select", "Less than one year", "1",	"2",	"3",	"4",	"5",	"6",	"7",	"8",	"9",	"10",	"11",	"12",	"13",	"14",	"15",	"16",	"17",
              "18",	"19",	"20", "more than 20 years"),
  
  next_button_text = "Next",
  max_width_pixels = 250,
  validate = function(answer, ...) {
    if (answer=="Please select")
      "Please provide your best estimate of the number of years you have played this musical instrument (click the small arrow on the right of the box to see the options)."
    else TRUE
  },
  on_complete = function(answer, state, ...) {
    set_global(key = "years_instr_3", value = answer, state = state)
  }  
),
# custom made question on practice habits

reg_play_3<-NAFC_page(
  label = "reg_play_3",
  prompt = p(strong ("When was the last time you played this instrument regularly?")),
  choices = c("I am currently playing this on a regular basis", "I stopped playing regularly less than a year ago","I played this on a regular basis 1-3 years ago","I played this on a regular basis more than three years ago",
              "I never played this instrument on a regular basis"),
  on_complete = function(answer, state, ...) {
    set_global(key = "reg_play_3", value = answer, state = state)
  } 
),

hours_instrument_3 <- dropdown_page(
  label = "hours_instr_3",
  prompt = p(strong("On average, how many hours per week do/did you play this instrument?")),
  save_answer=TRUE,
  choices = c("Please select", "Less than one hour", "1",	"2",	"3",	"4",	"5",	"6",	"7",	"8",	"9",	"10",	"11",	"12",	"13",	"14",	"15",	"16",	"17",
              "18",	"19",	"20", "more than 20 hours", "I never played this instrument on a regular basis"),
  
  next_button_text = "Next",
  max_width_pixels = 250,
  validate = function(answer, ...) {
    if (answer=="Please select")
      "Please provide your best estimate of the number of years you have played this musical instrument (click the small arrow on the right of the box to see the options). "
    else TRUE
  },
  on_complete = function(answer, state, ...) {
    set_global(key = "hours_instr_3", value = answer, state = state)
  }  
), 

other_instr<- text_input_page(
  label="other_instr",
  prompt= p(strong("Do you play any more instruments? If so, please let us know which by typing it into the text field below.")),
  width = "400px",
  save_answer = T,
  button_text = "Next"
),

# STOMP (Rentfrow & Gosling, 2003): alternative, blues, classical, country, electronica/dance, rap/hip-hop, jazz, pop, religious, rock, soul/funk, folk, and sound tracks

#(Rentfrow & Goldberg, Levitin, 2011) MUSIC: 
# Mellow: soft rock, R & B, and adult contemporary ; 
# Unpretentious: country and folk 
# Sophisticated: classical, opera, jazz, and world 
# Intense: rock, punk, and heavy metal 
# Contemporary: rap, electronica, and pop


genre <- dropdown_page(
  label = "genre",
  prompt = p(strong("Which genre do you play the most?")),
  save_answer=TRUE,
  # choices = c("Please select", "adult contemporary", "classical", "country", "electronica","folk", "heavy metal", "jazz", "opera","pop", "punk", "rap", "R&B", "rock", "soft rock", "world", "I don't play any instrument"),
  choices = c("Please select","alternative", "bluegrass", "blues", "classical", "country", "electronica/dance", "folk", "funk", "gospel", "heavy metal", "world", "jazz", "new age", "oldies", "opera", "pop", "punk", "rap/hiphop",
              "reggae", "religious", "rock", "soul/R&B", "soundtracks/theme songs"),
  alternative_choice = TRUE,
  alternative_text = "Other - please state which?", 
  next_button_text = "Next",
  max_width_pixels = 250,
  validate = function(answer, ...) {
    if (answer=="Please select")
      "Please provide your best estimate of the genre you play most (click the small arrow on the right of the box to see the options)."
    else if (answer=="") 
      "If you select 'Other' at the bottom of the list, please write in the designated field which genre you play the most."
    else TRUE
  },
  on_complete = function(answer, state, ...) {
    set_global(key = "genre", value = answer, state = state)
  }  
)


# mus exp ends here

)

  
# COMMENTS

duplets <- dropdown_page(
  label = "duplets",
  prompt = p(strong("Did you take part in this experiment within the last weeks?")),
  save_answer=TRUE,
  choices = c("Please select", "No", "Yes, once before", "Yes, twice before",	"Yes, three times before",	"Yes, four times before",	"Yes, five times before",	"Yes, six or more times before"),
  # alternative_choice = TRUE,
  # alternative_text = "I prefer not to tell you",
  next_button_text = "Next",
  max_width_pixels = 250,
  validate = function(answer, ...) {
    if (answer=="Please select")
      "Please let us know if you tried this exact same experiment recently. We ask because it matters for the analyses of the data you provide. If you like, you can provide additional comments in the next and final question."
    else TRUE
  },
  on_complete = function(answer, state, ...) {
    set_global(key = "duplets", value = answer, state = state)
  }  
)


# prev<-NAFC_page(
#   label = "prev",
#   prompt =div(h4(strong("Are you sure it was the same experiment?")),
#               p("We ran a similar version of this experiment two years ago."),
#               p("In some cases, the sounds were different (they consisted of polyrhythms with varying levels of complexity and/or tempo played on a cowbell, 
#                 in some cases they were identical to the marimba sounds used in the polyrhythms in this experiment."),
#               p("Which of the following options apply to you:"),
#               p(strong ("I am sure I have previously participated in a polyrhythm experiment with...")),
#   ),
#   choices = c("Cowbell sounds", "Marimba sounds","I am not entirely sure"),
#   on_complete = function(answer, state, ...) {
#     set_global(key = "prev", value = answer, state = state)
#    
#   }
# )



comments <- text_input_page(
  label = "comments",
  one_line = FALSE,
  width = "400px",
  prompt = div(
    HTML("<br>"),
    p(strong("Optional: Is there anything else you would like to tell us?")),
    HTML("<br>"),
    p("Here, you can provide comments about your experience of participating in this study, if you think it may be useful for the researchers to know."),
    p("Please do not write any personal information such as full name, email address, phone number etc."),
    p("You are also welcome to contact us by email on cecilie@clin.au.dk")
  ),
  save_answer = T,
  button_text = "Next"
)
thanks<-final_page(div(
      HTML("<img src='img/au_logo.png'></img> <img src='img/mib_logo.png'></img>"),
               div(
            h3(strong("Thanks very much!")),
            p("We hope you enjoyed taking part in this scientific experiment."),
            p("The data you provided is very valuable to us."),
            p("............."),
            HTML("<br>"),
            
            p("Your data has been saved now and you can safely close the browser window.")
             )
            ))


elts <- join(
  intro,
  elt_save_results_to_disk(complete = FALSE),
  sound_check,
  poly_pitch,
   elt_save_results_to_disk(complete = FALSE), 
  age,
  gender,
   elt_save_results_to_disk(complete = FALSE),
  demographics,
   elt_save_results_to_disk(complete = FALSE),
  music_exp,
   elt_save_results_to_disk(complete = FALSE),
  duplets,
   elt_save_results_to_disk(complete = TRUE),
  # prev,
  #  elt_save_results_to_disk(complete = TRUE),
  comments,
   elt_save_results_to_disk(complete = TRUE),
  thanks
)


 make_test(
     elts = elts,
     opt = test_options(title="Polyrhythms, Aarhus 2022",
                        admin_password="", # write a secret password here
                        enable_admin_panel=TRUE,
                        researcher_email="cecilie@clin.au.dk",
                        problems_info="Problems? Contact cecilie@clin.au.dk",
                        display = display_options(
                         full_screen = TRUE,
                         css = c(file.path(jspsych_dir, "css/jspsych.css"),"css/style.css")
         )))

# shiny::runApp(".")


