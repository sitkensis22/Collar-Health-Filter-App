# Collar Health Filter App

MoveApps

Github repository: *github.com/sitkensis22/Collar-Health-Filter-App* (*https://github.com/sitkensis22/Collar-Health-Filter-App*)

## Description
Provides 3 classes of filtering for 7 different types of alerts (mortality, cluster, nsd, voltage, gps_accuracy, gps_transmission, and gps_resurrection) in the data that were triggered by Collar Health Alert App: (1) filter-specific, (2) individual-specific, and (3) variable-specific.

## Documentation
This App provides functionality to filter collar health alerts that were appended to the user's move2 dataset from using the Collar Health Alert App in the previous step in a workflow. It allows the user to (1) filter the data for a specific alert type (e.g., mortality) and identifier (either the track id(s) or serial number(s) ("tag_local_identifier") but not both at the same time), (2) filter all alerts in the data for a specific identifier (either the track id(s) or serial number(s)), or (3) filter all alerts in the data based on a field (e.g., "collar_end_type") in the data and specific value in that field (e.g., "off-air"). The filters will not remove individual(s) from the dataset. Rather, the filtering will change the respective alert fields from a value of 1 to 0 (denoting no alert present). The custom filter that uses a variable in the data will identifiy any individual(s) in the data that have the value of that variable and set all of their alert variables to 0. 
Finally, this App was designed as a precusor step in a workflow for the Collar Health Shiny App that allows the user to visualize the data in Leaflet basemaps, as well as graphical and tabular form.

### Application scope
#### Generality of App usability
This app was developed for any taxinomic group.  

#### Required data properties
The App should work for any kind of (location) data. However, the App is meant to work only in conjunction with the Collar Health Alert App.

### Input type
`move2::move2_loc`

### Output type
`move2::move2_loc`

### Artefacts

### Settings 
**Set mortality alert (`mortality`):** This logical input acts as a switch to turn on mortality event monitoring based on a field or multiple fields provided in the next input. 

**Mortality field name (`mortality_id`):** This character string input is the field name that tracks mortality status in the dataset. Note that multiple fields may be provided to accomodate datasets that are from multiple collar vendors with different mortality status fields. Multiple values must be comma-separated. The field is ignored if the mortality alert is not activated.

**Set cluster alert (`cluster`):** This logical input acts as a switch to turn on cluster event monitoring. 

**Cluster search radius (`cluster_id`):** This numeric input defines the search radius in meters for cluster analysis. Note that the input will only be used when cluster trigger is activated.

**Set net-squared displacement alert (`nsd`):** This logical input acts as a switch to turn on maximum net-squared displacement event monitoring.

**Threshold for maximum net-squared displacement (`nsd_id`):** This numeric input defines the threshold in square meters for the maximum net-squared displacement to trigger an event. Note that the input will only be used when net-squared displacement trigger is activated.

**Set voltage alert (`voltage`):** This logical input acts as a switch to turn on voltage condition monitoring.

**Voltage field name (`voltage_id`):** This character string input is the field name that tracks voltage in the dataset. Note that multiple fields may be provided to accomodate datasets that are from multiple collar vendors with different voltage fields. Multiple values must be comma-separated. The field is ignored if the voltage alert is not activated.

**Set GPS accuracy alert (`gps_accuracy`):** This logical input acts as a switch to turn on GPS accuracy monitoring.

**GPS accuracy field name (`gps_accuracy_id`):** This character string input is the field name that tracks GPS accuracy in the dataset. Note that multiple fields may be provided to accomodate datasets that are from multiple collar vendors with different GPS accuracy fields. Multiple values must be comma-separated. The field is ignored if the GPS accuracy alert is not activated.

**Set GPS transmission alert (`GPS transmission`):** This logical input acts as a switch to turn on GPS transmission gap monitoring.

**GPS transmission gap value (`gps_transmission_id`):** This integer input defines the gap in days to trigger a GPS transmission event. Note that the input will only be used when GPS transmission gap trigger is activated.

**Set GPS resurrection alert (`GPS resurrection`):** This logical input acts as a switch to turn on GPS resurrection monitoring. This feature detects when a collar or tag has resurrected after a period of non-transmission, which is indicated by a gap in GPS transmission. Note that this feature uses the input `gps_transmission_gap` to first identify gaps in GPS transmission and then determine if the collar is resurrected.

**GPS resurrection duration (`gps_resurrection_id`):** This integer input defines the duration in days to trigger a GPS resurrection event. When the collar or tag has resurrected longer than this duration after a period of non-transmission, the alert will be activated. Note that the input will only be used when GPS resurrection gap trigger is activated.

**Set GPS resurrection alert (`filter_specific`):** This logical input acts as a switch to turn on GPS resurrection monitoring. This feature detects when a collar or tag has resurrected after a period of non-transmission, which is indicated by a gap in GPS transmission. Note that this feature uses the input `gps_transmission_gap` to first identify gaps in GPS transmission and then determine if the collar is resurrected.

**GPS resurrection duration (`filter_specific_id`):** This integer input defines the duration in days to trigger a GPS resurrection event. When the collar or tag has resurrected longer than this duration after a period of non-transmission, the alert will be activated. Note that the input will only be used when GPS resurrection gap trigger is activated.

**Set GPS accuracy alert (`gps_accuracy`):** This logical input acts as a switch to turn on GPS accuracy monitoring.

**GPS accuracy field name (`gps_accuracy_alias`):** This character string input is the field name that tracks GPS accuracy in the dataset. Note that multiple fields may be provided to accomodate datasets that are from multiple collar vendors with different GPS accuracy fields. Multiple values must be comma-separated. The field is ignored if the GPS accuracy alert is not activated.

**GPS accuracy value (`gps_accuracy_value`):** This character string input is the value that indicates that a missed location or poor GPS accuracy has occurred. Note that multiple values may be provided to accomodate datasets that are from multiple collar vendors and more than one GPS accuracy value indicates a missed location or poor GPS accuracy has occured. Multiple values must be comma-separated. The field is ignored if the GPS accuracy alert is not activated.

### Changes in output data
The App adds binary numerical (1/0) fields to the input data for each alert class where the condition is 1 for locations that meet the alert criteria and 0 otherwise. The following fields are added to the data: (1) mortality, (2) cluster, (3) nsd, (4) voltage, (5) gps_accuracy, (6) gps_transmission, and (7) gps_resurrection regardless if event triggers are detected or not. The App also adds a field called `nAlerts` to the dataset, which tracks the number of alerts for each individual. This functionality allows the App to be used in conjunction with the Email-Alert App when the `nAlerts` is included as the `Location alert property` and the `Property relation` input is set to `>= 1` in the Email-Alert App. Note that these fields are used downstream in other Apps that integrate into a workflow such as the Notification Filter App and Notification Shiny App. The alias and value names provided as input for the App for `voltage_alias` and `voltage_value` and `gps_accuracy_prop` (when triggers are set) are also added variables in the move2 data object that is output by the App for use in the Notification Shiny App within a workflow. 

### Most common errors

### Null or error handling
**Setting `mortality_alias`:** If the variable(s) is (or are) not present in the input dataset or not provided when the mortality switch is activated, an error will be returned. If the spelling does not match exactly, an error will be returned. Review available variables in the input dataset to confirm their existence and spelling. 

**Setting `mortality_value`:** If the value given is not in the variable provided for the `mortality_alias` or not provided when the mortality switch is activated, an error will be returned. If the spelling does not match exactly, an error will be returned. Review available variable levels in the input dataset to confirm their existence and spelling.

**Setting `voltage_alias`:** If the variable(s) is (or are) not present in the input dataset or not provided when the voltage switch is activated, an error will be returned. If the spelling does not match exactly, an error will be returned. Review available variables in the input dataset to confirm their existence and spelling. 

**Setting `gps_accuracy_alias`:** If the variable(s) is (or are) not present in the input dataset or not provided when the GPS accuracy switch is activated, an error will be returned. If the spelling does not match exactly, an error will be returned. Review available variables in the input dataset to confirm their existence and spelling. 

**Setting `gps_accuracy_value`:** If the value given is not in the variable provided for the `gps_accuracy_alias` or not provided when the GPS accuracy switch is activated, an error will be returned. If the spelling does not match exactly, an error will be returned. Review available variable levels in the input dataset to confirm their existence and spelling.
