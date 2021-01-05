
## SumoLogic Template Details
This query analyses a set of Google VPC flow logs for high-egress events.
The incoming set of flow logs are bucketed into non-overlapping time slices
and grouped by project / VM name to identify VMs with high amounts of egress
in a given period of time.

We currently manually publish the below query into SumoLogic. It's feasible
to automate this, but we haven't invested the effort yet.

All SumoLogic saved searches are collected in the "AoU RW Egress Alerts" folder
located at https://service.us2.sumologic.com/ui/#/library/folder/10810149.
There should be one saved search for each {environment, window width} tuple.

Unfortunately, not all parameters involved in a saved search can be specified in
this query file. There are a number of parameters which must be entered via the
"Edit search" dialog in order to properly configure each search.

Note: the "time range" parameter is set to be double the window_in_seconds duration,
causing the search to query across multiple windows' worth of log messages. This may
result in duplicate high-egress event notifications being sent, but it may also increase
resiliency to delays or outages in SumoLogic's execution of saved searches.
                                
Each environment should be set up with the following searches. The test environment
is shown as an example.

- 3 minutes, 100Mib
  - Parameters: environment=test, window_in_seconds=180, egress_threshold_in_mib=100
  - Time range: -6m ("use receipt time" is checked)
  - Search schedule:
    - Run frequency: real time
    - Time range for scheduled search: -6m

- 10 minutes, 150 Mib
  - Parameters: environment=test, window_in_seconds=600, egress_threshold_in_mib=150
  - Time range: -20m ("use receipt time" is checked)
  - Search schedule:
    - Run frequency: Every 15 minutes
    - Time range for scheduled search: -20m

- 60 minutes, 200 Mib
  - Parameters: environment=test, window_in_seconds=3600, egress_threshold_in_mib=200
  - Time range: -120m ("use receipt time" is checked)
  - Search schedule:
    - Run frequency: Hourly
    - Time range for scheduled search: -120m
