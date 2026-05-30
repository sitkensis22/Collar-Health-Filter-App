library("move2")
library("tidyverse")

## The parameter "data" is reserved for the data object passed on from the previous app

# R function to filter 7 (currently) alert triggers from Collar Health Alert App
rFunction = function(
  data, # read in data (move2 object)
  # alert specific filters
  mortality = FALSE, # logical indicator to filter mortality alerts for the ids provided in 'mortality_id' input
  mortality_id = NULL, # character vector of ids to apply mortality filter to. You can input the track id or local_tag_identifier (serial #) as the input
  cluster = FALSE, # logical indicator to filter cluster alerts for the ids provided in 'cluster_id' input
  cluster_id = NULL, # character vector of ids to apply cluster filter to. You can input the track id or local_tag_identifier (serial #) as the input
  nsd = FALSE, # logical indicator to filter nsd alerts for the ids provided in 'nsd_id' input
  nsd_id = NULL, # character vector of ids to apply nsd filter to. You can input the track id or local_tag_identifier (serial #) as the input
  voltage = FALSE, # logical indicator to filter voltage alerts for the ids provided in 'mortality_id' input
  voltage_id = NULL, # character vector of ids to apply voltage filter to. You can input the track id or local_tag_identifier (serial #) as the input
  gps_accuracy = FALSE, # logical indicator to filter gps_accuracy alerts for the ids provided in 'gps_accuracy_id' input
  gps_accuracy_id = NULL, # character vector of ids to apply gps_accuracy filter to. You can input the track id or local_tag_identifier (serial #) as the input
  gps_transmission = FALSE, # logical indicator to filter gps_transmission alerts for the ids provided in 'gps_transmission_id' input
  gps_transmission_id = NULL, # character vector of ids to apply gps_transmission filter to. You can input the track id or local_tag_identifier (serial #) as the input
  gps_resurrection = FALSE, # logical indicator to filter gps_resurrection alerts for the ids provided in 'gps_resurrection_id' input
  gps_resurrection_id = NULL, # character vector of ids to apply gps_resurrection filter to. You can input the track id or local_tag_identifier (serial #) as the input
  tag_release = FALSE, # logical indicator to filter tag_release alerts for the ids provided in 'tag_release_id' input
  tag_release_id = NULL, # character vector of ids to apply tag_release filter to. You can input the track id or local_tag_identifier (serial #) as the input
  # individual specific fliter (filter any alerts from the given ids)
  filter_specific = FALSE, # logical indicator to activate individual filtering that removes any alerts from the individual
  filter_specific_id = NULL, # # character vector of id(s) to apply individual filtering to. You can input the track id or local_tag_identifier (serial #) as the input
  # custom filters for a specific variable in the data (this will remove alerts for any individual(s) that meet the criteria)
  filter_custom = FALSE, # logical indicator to activate custom filtering that removes alerts for individual(s) that meet the criteria
  filter_custom_alias = NULL, # vector of custom variable(s) to filter by (e.g., collar_end_type)
  filter_custom_value = NULL, # the value(s) to filter for in the custom variable(s)
  ...){
  # create data from with track_id and device serial number (i.e., "tag_local_identifier")
  # check if "tag_local_identifier" exists in the track data frame
  if("tag_local_identifier" %in% colnames(mt_track_data(data))){
    id_data <- data.frame(track_id = as.factor(unique(mt_track_id(data))), tag_local_identifier = unique(mt_track_data(data)[,"tag_local_identifier"]))
  }else
  # if not just use track_id as a filter and give warning
  if(isFALSE("tag_local_identifier" %in% colnames(mt_track_data(data)))){
    logger.info("tag_local_identifier not found in data set. Using only track id to filter data.")
    id_data <- data.frame(track_id = as.factor(unique(mt_track_id(data))))
  }
  # create id_check variable depending on number of columns in id_data
  if(ncol(id_data) == 2){
    id_check <- c(levels(id_data$track_id),levels(id_data$tag_local_identifier))
  }else
    if(ncol(id_data) == 1){
      id_check <- levels(id_data$track_id)
    } 
  # 1) Begin alert-specific filters
  # mortality alerts
  if(mortality){
    # first check if track id(s) or tag_local_identifier(s) exist in the data for mortality alert ids. if not stop operation.
    if(isFALSE(all(mortality_id %in% id_check))){
      logger.warn("Identifier(s) for mortality alert filter does not exist in dataset. Check spelling of id(s) or check in the dataset for individual(s)")
    }
    # now filter mortality alerts for given mortality_id(s)
    # if the id_data has two columns and mortality_id(s) are the track_id(s)
    if(all(ncol(id_data) %in% c(1,2) & mortality_id %in% levels(id_data$track_id))){
      data[mt_track_id(data) %in% mortality_id,]$mortality = 0
    }else
    # if the id_data has two columns and mortality_id(s) are the tag_local_identifier(s)  
    if(all(ncol(id_data) == 2 & mortality_id %in% levels(id_data$tag_local_identifier))){
      temp_id <- id_data[which(id_data$tag_local_identifier %in% mortality_id),]$track_id
      data[mt_track_id(data) %in% temp_id,]$mortality = 0
    }
  }  
  # end mortality alert filtering    
  # cluster alerts
  if(cluster){
    # first check if track id(s) or tag_local_identifier(s) exist in the data for cluster alert ids. if not stop operation.
    if(isFALSE(all(cluster_id %in% id_check))){
      logger.warn("Identifier(s) for cluster alert filter does not exist in dataset. Check spelling of id(s) or check in the dataset for individual(s)")
    }
    # now filter cluster alerts for given cluster_id(s)
    # if the id_data has two columns and cluster_id(s) are the track_id(s)
    if(all(ncol(id_data) %in% c(1,2) & cluster_id %in% levels(id_data$track_id))){
      data[mt_track_id(data) %in% cluster_id,]$cluster = 0
    }else
    # if the id_data has two columns and cluster_id(s) are the tag_local_identifier(s)  
    if(all(ncol(id_data) == 2 & cluster_id %in% levels(id_data$tag_local_identifier))){
      temp_id <- id_data[which(id_data$tag_local_identifier %in% cluster_id),]$track_id
      data[mt_track_id(data) %in% temp_id,]$cluster = 0
    }
  }  
  # end cluster alert filtering  
  # nsd alerts
  if(nsd){
    # first check if track id(s) or tag_local_identifier(s) exist in the data for nsd alert ids. if not stop operation.
    if(isFALSE(all(nsd_id %in% id_check))){
      logger.warn("Identifier(s) for nsd alert filter does not exist in dataset. Check spelling of id(s) or check in the dataset for individual(s)")
    }
    # now filter nsd alerts for given nsd_id(s)
    # if the id_data has two columns and nsd_id(s) are the track_id(s)
    if(all(ncol(id_data) %in% c(1,2) & nsd_id %in% levels(id_data$track_id))){
      data[mt_track_id(data) %in% nsd_id,]$nsd = 0
    }else
    # if the id_data has two columns and nsd_id(s) are the tag_local_identifier(s)  
    if(all(ncol(id_data) == 2 & nsd_id %in% levels(id_data$tag_local_identifier))){
      temp_id <- id_data[which(id_data$tag_local_identifier %in% nsd_id),]$track_id
      data[mt_track_id(data) %in% temp_id,]$nsd = 0
    }
  }  
  # end nsd alert filtering  
  # voltage alerts
  if(voltage){
    # first check if track id(s) or tag_local_identifier(s) exist in the data for voltage alert ids. if not stop operation.
    if(isFALSE(all(voltage_id %in% id_check))){
      logger.warn("Identifier(s) for voltage alert filter does not exist in dataset. Check spelling of id(s) or check in the dataset for individual(s)")
    }
    # now filter voltage alerts for given voltage_id(s)
    # if the id_data has two columns and voltage_id(s) are the track_id(s)
    if(all(ncol(id_data) %in% c(1,2) & voltage_id %in% levels(id_data$track_id))){
      data[mt_track_id(data) %in% voltage_id,]$voltage = 0
    }else
    # if the id_data has two columns and voltage_id(s) are the tag_local_identifier(s)  
    if(all(ncol(id_data) == 2 & voltage_id %in% levels(id_data$tag_local_identifier))){
      temp_id <- id_data[which(id_data$tag_local_identifier %in% voltage_id),]$track_id
      data[mt_track_id(data) %in% temp_id,]$voltage = 0
    }
  }  
  # end voltage alert filtering 
  # gps_accuracy alerts
  if(gps_accuracy){
    # first check if track id(s) or tag_local_identifier(s) exist in the data for gps_accuracy alert ids. if not stop operation.
    if(isFALSE(all(gps_accuracy_id %in% id_check))){
      logger.warn("Identifier(s) for gps_accuracy alert filter does not exist in dataset. Check spelling of id(s) or check in the dataset for individual(s)")
    }
    # now filter gps_accuracy alerts for given gps_accuracy_id(s)
    # if the id_data has two columns and gps_accuracy_id(s) are the track_id(s)
    if(all(ncol(id_data) %in% c(1,2) & gps_accuracy_id %in% levels(id_data$track_id))){
      data[mt_track_id(data) %in% gps_accuracy_id,]$gps_accuracy = 0
    }else
    # if the id_data has two columns and gps_accuracy_id(s) are the tag_local_identifier(s)  
    if(all(ncol(id_data) == 2 & gps_accuracy_id %in% levels(id_data$tag_local_identifier))){
      temp_id <- id_data[which(id_data$tag_local_identifier %in% gps_accuracy_id),]$track_id
      data[mt_track_id(data) %in% temp_id,]$gps_accuracy = 0
    }
  }  
  # end gps_accuracy alert filtering 
  # gps_transmission alerts
  if(gps_transmission){
    # first check if track id(s) or tag_local_identifier(s) exist in the data for gps_transmission alert ids. if not stop operation.
    if(isFALSE(all(gps_transmission_id %in% id_check))){
      logger.warn("Identifier(s) for gps_transmission alert filter does not exist in dataset. Check spelling of id(s) or check in the dataset for individual(s)")
    }
    # now filter gps_transmission alerts for given gps_transmission_id(s)
    # if the id_data has two columns and gps_transmission_id(s) are the track_id(s)
    if(all(ncol(id_data) %in% c(1,2) & gps_transmission_id %in% levels(id_data$track_id))){
      data[mt_track_id(data) %in% gps_transmission_id,]$gps_transmission = 0
    }else
    # if the id_data has two columns and gps_transmission_id(s) are the tag_local_identifier(s)  
    if(all(ncol(id_data) == 2 & gps_transmission_id %in% levels(id_data$tag_local_identifier))){
      temp_id <- id_data[which(id_data$tag_local_identifier %in% gps_transmission_id),]$track_id
      data[mt_track_id(data) %in% temp_id,]$gps_transmission = 0
    }
  }  
  # end gps_transmission alert filtering 
  # gps_resurrection alerts
  if(gps_resurrection){
    # first check if track id(s) or tag_local_identifier(s) exist in the data for gps_resurrection alert ids. if not stop operation.
    if(isFALSE(all(gps_resurrection_id %in% id_check))){
      logger.warn("Identifier(s) for gps_resurrection alert filter does not exist in dataset. Check spelling of id(s) or check in the dataset for individual(s)")
    }
    # now filter gps_resurrection alerts for given gps_resurrection_id(s)
    # if the id_data has two columns and gps_resurrection_id(s) are the track_id(s)
    if(all(ncol(id_data) %in% c(1,2) & gps_resurrection_id %in% levels(id_data$track_id))){
      data[mt_track_id(data) %in% gps_resurrection_id,]$gps_resurrection = 0
    }else
    # if the id_data has two columns and gps_resurrection_id(s) are the tag_local_identifier(s)  
    if(all(ncol(id_data) == 2 & gps_resurrection_id %in% levels(id_data$tag_local_identifier))){
      temp_id <- id_data[which(id_data$tag_local_identifier %in% gps_resurrection_id),]$track_id
      data[mt_track_id(data) %in% temp_id,]$gps_resurrection = 0
    }
    # end gps_resurrection alert filtering 
  }  
  # tag_release alerts
  if(tag_release){
    # first check if track id(s) or tag_local_identifier(s) exist in the data for tag_release alert ids. if not stop operation.
    if(isFALSE(all(tag_release_id %in% id_check))){
      logger.warn("Identifier(s) for tag_release alert filter does not exist in dataset. Check spelling of id(s) or check in the dataset for individual(s)")
    }
    # now filter tag_release alerts for given tag_release_id(s)
    # if the id_data has two columns and tag_release_id(s) are the track_id(s)
    if(all(ncol(id_data) %in% c(1,2) & tag_release_id %in% levels(id_data$track_id))){
      data[mt_track_id(data) %in% tag_release_id,]$tag_release = 0
    }else
    # if the id_data has two columns and tag_release_id(s) are the tag_local_identifier(s)  
    if(all(ncol(id_data) == 2 & tag_release_id %in% levels(id_data$tag_local_identifier))){
      temp_id <- id_data[which(id_data$tag_local_identifier %in% tag_release_id),]$track_id
      data[mt_track_id(data) %in% temp_id,]$tag_release = 0
    }
    # end tag_release alert filtering 
  } 
  # end of alert-specific filter section
  # 2) individual specific filtering (can be track id or tag_local_identifier) 
  if(filter_specific){
    # first check if track id(s) or tag_local_identifier(s) exist in the data for filter specific alert ids. if not stop operation.
    if(isFALSE(all(filter_specific_id %in% id_check))){
      logger.warn("Identifer(s) for individual-specific filter does not exist in dataset. Check spelling of id(s) or check in the dataset for individual(s)")
    } 
    # set all alert variables for these ids to 0
    # if the id_data has two columns and filter_specific_id(s) are the track_id(s)
    if(all(ncol(id_data) %in% c(1,2) & filter_specific_id %in% levels(id_data$track_id))){
      data[mt_track_id(data) %in% filter_specific_id,]$mortality = 0
      data[mt_track_id(data) %in% filter_specific_id,]$cluster = 0
      data[mt_track_id(data) %in% filter_specific_id,]$nsd = 0
      data[mt_track_id(data) %in% filter_specific_id,]$voltage = 0
      data[mt_track_id(data) %in% filter_specific_id,]$gps_accuracy = 0
      data[mt_track_id(data) %in% filter_specific_id,]$gps_transmission = 0
      data[mt_track_id(data) %in% filter_specific_id,]$gps_resurrection = 0
      data[mt_track_id(data) %in% filter_specific_id,]$tag_release = 0
    }else
    # if the id_data has two columns and filter_specific_id(s) are the tag_local_identifier(s)  
    if(all(ncol(id_data) == 2 & filter_specific_id %in% levels(id_data$tag_local_identifier))){
      temp_id <- id_data[which(id_data$tag_local_identifier %in% filter_specific_id),]$track_id
      data[mt_track_id(data) %in% temp_id,]$mortality = 0
      data[mt_track_id(data) %in% temp_id,]$cluster = 0
      data[mt_track_id(data) %in% temp_id,]$nsd = 0
      data[mt_track_id(data) %in% temp_id,]$voltage = 0
      data[mt_track_id(data) %in% temp_id,]$gps_accuracy = 0
      data[mt_track_id(data) %in% temp_id,]$gps_transmission = 0
      data[mt_track_id(data) %in% temp_id,]$gps_resurrection = 0
      data[mt_track_id(data) %in% temp_id,]$tag_release = 0
    }
  }
  # end of individual-specific filter section
  # 3) Begin custom filters for e.g., collar end type events # inputs are filter_custom, filter_custom_alias, filter_custom_value
  if(filter_custom){
    if(filter_custom & is.null(filter_custom_alias) | filter_custom & is.null(filter_custom_value)){
      logger.warn("Must provide filter_custom alias and filter_custom value when filter_custom event is requested")
    }
    # check if filter_custom alias is in the dataset
    if(isFALSE(all(filter_custom_alias %in% colnames(data)))){
      alias_not_found <- filter_custom_alias[which(filter_custom_alias %in% colnames(data) == FALSE)]
      logger.warn("filter_custom alias(es) not found in dataset:",alias_not_found)
    }
    # check if filter_custom variables are a factor, if not, convert them
    if(isFALSE(all(data |> as.data.frame() |> dplyr::select(all_of(filter_custom_alias)) |> sapply(is.factor)))){
      check_factor_index <- which(data |> as.data.frame() |> dplyr::select(all_of(filter_custom_alias)) |> sapply(is.factor) == FALSE)
      data <- data |> mutate(across(filter_custom_alias[check_factor_index], as.factor))
    }
    # check if filter_custom values exist in levels of filter_custom alias variable(s)
    test_levels <- data |> as.data.frame() |> dplyr::select(all_of(filter_custom_alias)) |> 
      pivot_longer(cols = all_of(filter_custom_alias),
                   names_to = "test_var",
                   values_to = "test_vals") 
    # now test if filter_custom_values are in test_vals
    if(any(filter_custom_value %in% levels(test_levels$test_vals) == FALSE)){
      variable_not_found <- filter_custom_value[which(filter_custom_value %in% test_levels$test_vals == FALSE)]
      logger.warn(paste("At least one filter_custom_value not found in levels of filter_custom_alias variable(s):",variable_not_found))
    }
    # only run operation if filter custom value is found in filter custom alias
    if(all(filter_custom_value %in% levels(test_levels$test_vals))){
      # use factor() to remove unused levels
      data <- data |> mutate(across(all_of(filter_custom_alias), factor))
      # combine all customer aliases and values into a single variable in case multiple fields were provided
      filter_custom_check <- data |> 
        pivot_longer(cols = all_of(filter_custom_alias), 
                     names_to = "alias", 
                     values_to = "alias_vals") |>
        group_by(.data[[mt_track_id_column(data)]]) |> 
        mutate(filter_custom_status = alias_vals) |>
        dplyr::select(-alias,-alias_vals) |> 
        ungroup()
      # identify individual_local_identifier where the filter_custom_alias is true
      filter_custom_id <- filter_custom_check |> filter(filter_custom_status %in% filter_custom_value) |>
        as.data.frame() |> dplyr::select(mt_track_id_column(data)) |> unique()
      # set all alerts to 0 for filter_custom_id(s)
      data[mt_track_id(data) %in% filter_custom_id,]$mortality = 0
      data[mt_track_id(data) %in% filter_custom_id,]$cluster = 0
      data[mt_track_id(data) %in% filter_custom_id,]$nsd = 0
      data[mt_track_id(data) %in% filter_custom_id,]$voltage = 0
      data[mt_track_id(data) %in% filter_custom_id,]$gps_accuracy = 0
      data[mt_track_id(data) %in% filter_custom_id,]$gps_transmission = 0
      data[mt_track_id(data) %in% filter_custom_id,]$gps_resurrection = 0
      data[mt_track_id(data) %in% filter_custom_id,]$tag_release = 0
    }
  }
  # end custom filters
  # remove nAlerts field because it will need to be overwritten
  data <- data |> select(-nAlerts)
  # update number of alerts per individual and create tibble after filtering operations
  alertSums <- data |> as.data.frame() |>
               group_by(.data[[mt_track_id_column(data)]]) |>
               summarize(mortality = sum(mortality),cluster = sum(cluster),
               nsd = sum(nsd), voltage = sum(voltage), gps_accuracy = sum(gps_accuracy), 
               gps_transmission = sum(gps_transmission), gps_resurrection = sum(gps_resurrection),
               tag_release = sum(tag_release)) |>
               mutate(mortality = ifelse(mortality >= 1, 1, 0), cluster = ifelse(cluster >= 1, 1, 0),
               nsd = ifelse(nsd >= 1, 1, 0), voltage = ifelse(voltage >= 1, 1, 0),
               gps_accuracy = ifelse(gps_accuracy >= 1, 1, 0), gps_transmission = ifelse(gps_transmission >= 1, 1, 0),
               gps_resurrection = ifelse(gps_resurrection >= 1, 1, 0), tag_release = ifelse(tag_release >= 1, 1, 0)) |> ungroup() |> 
               mutate(nAlerts = rowSums(across(c(mortality,cluster,nsd,voltage,gps_accuracy,gps_transmission,gps_resurrection,tag_release)))) |>
               select(-c(mortality,cluster,nsd,voltage,gps_accuracy,gps_transmission,gps_resurrection,tag_release))
  # merge nAlerts into move2 data
  data <- left_join(data, alertSums, by = mt_track_id_column(data))
  # get index of geometry field
  geometry_index <- which(colnames(data) == "geometry")
  # now organize data set
  data <- data[,c((1:ncol(data))[-geometry_index],geometry_index)]
  # return move2 data
  return(data)
}    
# End of alert filter function
