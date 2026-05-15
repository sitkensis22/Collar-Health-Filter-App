# Collar Health Filter App

MoveApps

Github repository: *github.com/sitkensis22/Collar-Health-Filter-App* (*https://github.com/sitkensis22/Collar-Health-Filter-App*)

## Description
Provides 3 classes of filtering for 7 different types of collar health alerts (mortality, cluster, nsd, voltage, gps_accuracy, gps_transmission, and gps_resurrection) in the data that were triggered by Collar Health Alert App: (1) filter-specific, (2) individual-specific, and (3) variable-specific.

## Documentation
This App provides functionality to filter collar health alerts that were appended to the user's move2 dataset from using the Collar Health Alert App in the previous step in a workflow. It allows the user to (1) filter the data for a specific alert type (e.g., mortality) and identifier (either the track id(s) or serial number(s) ("tag_local_identifier") but not both at the same time), (2) filter all alerts in the data for a specific identifier (either the track id(s) or serial number(s)), or (3) filter all alerts in the data based on a field (e.g., "collar_end_type") in the data and specific value in that field (e.g., "off-air"). The filters will not remove individual(s) from the dataset. Rather, the filtering will change the respective alert fields from a value of 1 to 0 (denoting no alert present). The custom filter that uses a variable in the data will identifiy any individual(s) in the data that have the value of that variable and set all of their alert variables to 0. 
Finally, this App was designed as a precusor step in a workflow for the Collar Health Shiny App that allows the user to visualize the data in Leaflet basemaps, as well as graphical and tabular form.

### Application scope
#### Generality of App usability
This app was developed for any taxinomic group.  

#### Required data properties
The App should work for any kind of (location) data. However, the App is only meant to work in conjunction with the Collar Health Alert App in the previous step of workflow.

### Input type
`move2::move2_loc`

### Output type
`move2::move2_loc`

### Artefacts

### Settings 
**Set mortality-specific filter (`mortality`):** This logical input acts as a switch to turn on mortality alert filtering based on idenfier(s) provided in the `mortality_id` input. 

**Identifier(s) for mortality-specifc filtering (`mortality_id`):** This character string input is the track id(s) or serial number(s) (i.e., local_tag_identifier) to filter mortality alerts by. Note that multiple id(s) may be provided but they must be either the track id(s) or serial number(s) and not a mix of both. Multiple values must be comma-separated and input is only used if mortality filter is activated.

**Set cluster-specific filter (`cluster`):** This logical input acts as a switch to turn on cluster alert filtering based on idenfier(s) provided in the `cluster_id` input. 

**Identifier(s) for cluster-specifc filtering (`cluster_id`):** This character string input is the track id(s) or serial number(s) (i.e., local_tag_identifier) to filter cluster alerts by. Note that multiple id(s) may be provided but they must be either the track id(s) or serial number(s) and not a mix of both. Multiple values must be comma-separated and input is only used if cluster filter is activated.

**Set net-squared displacement-specific filter (`nsd`):** This logical input acts as a switch to turn on cluster alert filtering based on idenfier(s) provided in the `nsd_id` input. 

**Identifier(s) for net-squared displacement-specific filtering (`nsd_id`):** This character string input is the track id(s) or serial number(s) (i.e., local_tag_identifier) to filter net-squared displacement alerts by. Note that multiple id(s) may be provided but they must be either the track id(s) or serial number(s) and not a mix of both. Multiple values must be comma-separated and input is only used if nsd filter is activated.

**Set voltage-specific filter (`voltage`):** This logical input acts as a switch to turn on voltage alert filtering based on idenfier(s) provided in the `voltage_id` input. 

**Identifier(s) for voltage-specifc filtering (`voltage_id`):** This character string input is the track id(s) or serial number(s) (i.e., local_tag_identifier) to filter voltage alerts by. Note that multiple id(s) may be provided but they must be either the track id(s) or serial number(s) and not a mix of both. Multiple values must be comma-separated and input is only used if voltage filter is activated.

**Set GPS accuracy-specific filter (`gps_accuracy`):** This logical input acts as a switch to turn on GPS accuracy alert filtering based on idenfier(s) provided in the `gps_accuracy_id` input. 

**Identifier(s) for GPS accuracy-specifc filtering (`gps_accuracy_id`):** This character string input is the track id(s) or serial number(s) (i.e., local_tag_identifier) to filter GPS accuracy alerts by. Note that multiple id(s) may be provided but they must be either the track id(s) or serial number(s) and not a mix of both. Multiple values must be comma-separated and input is only used if GPS accuracy filter is activated.

**Set GPS transmission-specific filter (`gps_transmission`):** This logical input acts as a switch to turn on GPS transmission alert filtering based on idenfier(s) provided in the `gps_transmission_id` input. 

**Identifier(s) for GPS transmission-specifc filtering (`gps_transmission_id`):** This character string input is the track id(s) or serial number(s) (i.e., local_tag_identifier) to filter GPS transmission alerts by. Note that multiple id(s) may be provided but they must be either the track id(s) or serial number(s) and not a mix of both. Multiple values must be comma-separated and input is only used if GPS transmission filter is activated.

**Set GPS resurrection-specific filter (`gps_resurrection`):** This logical input acts as a switch to turn on GPS transmission alert filtering based on idenfier(s) provided in the `gps_resurrection_id` input. 

**Identifier(s) for GPS resurrection-specifc filtering (`gps_resurrection_id`):** This character string input is the track id(s) or serial number(s) (i.e., local_tag_identifier) to filter GPS resurrection alerts by. Note that multiple id(s) may be provided but they must be either the track id(s) or serial number(s) and not a mix of both. Multiple values must be comma-separated and input is only used if GPS resurrection filter is activated.

**Set GPS individual-specific filter (`filter_specific`):** This logical input acts as a switch to turn on individual-specific alert filtering based on idenfier(s) provided in the `filter_specific_id` input. 

**Identifier(s) for individual-specifc filtering (`filter_specific_id`):** This character string input is the track id(s) or serial number(s) (i.e., local_tag_identifier) to filter all alerts for a specific individual. Note that multiple id(s) may be provided but they must be either the track id(s) or serial number(s) and not a mix of both. Multiple values must be comma-separated and input is only used if individual-specific resurrection filter is activated.

**Set custom variable-specific alert filter (`filter_custom`):** This logical input acts as a switch to turn on custom variable-specific alert filtering for specific track id(s) that meet the criteria for custom alias(es) and value(s). 

**Custom variable-specific alert filter field name (`filter_custom_alias`):** This character string field will filter out all alerts for a specific track id(s) in the dataset that meet the criteria for the variable in 'filter_custom_value'. Note that multiple fields may be provided, but they must be comma-separated. Input is only used if custom filter is activated.

**Custom variable-specific alert filter value (`filter_custom_value`):** This character string input is the value of custom alias field to use to filter out all alerts for a specific track id(s) in the dataset. Note that multiple values may be provided, but they must be comma-separated. Input is only used if custom filter is activated.

### Changes in output data
The App filters the binary numerical (1/0) fields that were appended to the move2 data in the previous workflow step by the Collar Health Alert App, where the condition is 1 for locations that meet the alert criteria and 0 otherwise. When a filtering condition is met, one or all of the alert fields (mortality, cluster, nsd, voltage, gps_accuracy, gps_transmission, and gps_resurrection) are set to 0 for the identifier(s) present in the filter input settings (e.g., `filter_specific_id`) depending on which filter types are activated. Note that these alert fields are used downstream in other Apps that integrate into a workflow such as the Collar Health Shiny App. The field `nAlerts` in the data, which tracks the number of unique alert events for each individual, is also updated after the filtering has occurred.

### Most common errors

### Null or error handling
**Setting `mortality_id`:** If the identifier(s) are not present in the input dataset or not provided when the mortality filter switch is activated, an error will be returned. If the spelling does not match exactly, an error will be returned. Review available variables in the input dataset to confirm their existence and spelling. 

**Setting `cluster_id`:** If the identifier(s) are not present in the input dataset or not provided when the cluster filter switch is activated, an error will be returned. If the spelling does not match exactly, an error will be returned. Review available variables in the input dataset to confirm their existence and spelling. 

**Setting `nsd_id`:** If the identifier(s) are not present in the input dataset or not provided when the net_squared displacement filter switch is activated, an error will be returned. If the spelling does not match exactly, an error will be returned. Review available variables in the input dataset to confirm their existence and spelling. 

**Setting `voltage_id`:** If the identifier(s) are not present in the input dataset or not provided when the voltage filter switch is activated, an error will be returned. If the spelling does not match exactly, an error will be returned. Review available variables in the input dataset to confirm their existence and spelling. 

**Setting `gps_accuracy_id`:** If the identifier(s) are not present in the input dataset or not provided when the GPS accuracy filter switch is activated, an error will be returned. If the spelling does not match exactly, an error will be returned. Review available variables in the input dataset to confirm their existence and spelling. 

**Setting `gps_transmission_id`:** If the identifier(s) are not present in the input dataset or not provided when the GPS transmission filter switch is activated, an error will be returned. If the spelling does not match exactly, an error will be returned. Review available variables in the input dataset to confirm their existence and spelling. 

**Setting `gps_resurrection_id`:** If the identifier(s) are not present in the input dataset or not provided when the GPS resurrection filter switch is activated, an error will be returned. If the spelling does not match exactly, an error will be returned. Review available variables in the input dataset to confirm their existence and spelling.

**Setting `filter_specific_id`:** If the identifier(s) are not present in the input dataset or not provided when the individual-specific filter switch is activated, an error will be returned. If the spelling does not match exactly, an error will be returned. Review available variables in the input dataset to confirm their existence and spelling.

**Setting `filter_custom_alias`:** If the variable(s) is (or are) not present in the input dataset or not provided when the custom variable-specific filter switch is activated, an error will be returned. If the spelling does not match exactly, an error will be returned. Review available variables in the input dataset to confirm their existence and spelling. 

**Setting `filter_custom_value`:** If the value given is not in the variable provided for the `filter_custom_alias` or not provided when the custom variable-specific filter switch is activated, an error will be returned. If the spelling does not match exactly, an error will be returned. Review available variable levels in the input dataset to confirm their existence and spelling.
