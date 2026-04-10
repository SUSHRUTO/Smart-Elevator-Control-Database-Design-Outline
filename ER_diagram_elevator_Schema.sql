title Smart Elevator Control

// BUILDINGS

buildings [icon: building, color: blue] {
  id char(36) pk
  name varchar(100)
  location varchar(150)
  total_floors int
  created_at timestamp
}

// FLOORS

floors [icon: layers, color: green] {
  id char(36) pk
  building_id char(36) fk
  floor_number int
  floor_name varchar(50)
}

// SHAFTS

shafts [icon: columns, color: gray] {
  id char(36) pk
  building_id char(36) fk
  shaft_code varchar(20)
}

// ELEVATORS

elevators [icon: arrow-up-down, color: yellow] {
  id char(36) pk
  building_id char(36) fk
  shaft_id char(36) fk
  name varchar(50)
  capacity int
  max_speed decimal(5,2)
  installed_at timestamp
}

// ELEVATOR-FLOOR MAPPING (M:M)

elevator_floor_map [icon: link, color: purple] {
  id char(36) pk
  elevator_id char(36) fk
  floor_id char(36) fk
}

// ZONES (ADVANCED)

zones [icon: map, color: teal] {
  id char(36) pk
  building_id char(36) fk
  zone_name varchar(50)
  min_floor int
  max_floor int
}

// ZONE-ELEVATOR MAP

zone_elevator_map [icon: link, color: teal] {
  id char(36) pk
  zone_id char(36) fk
  elevator_id char(36) fk
}

// FLOOR REQUESTS

requests [icon: bell, color: red] {
  id char(36) pk
  floor_id char(36) fk
  direction varchar(10)  // up/down
  requested_at timestamp
  status varchar(20)     // pending/assigned/completed
  priority_level int
}

// RIDE ASSIGNMENTS

assignments [icon: target, color: orange] {
  id char(36) pk
  request_id char(36) fk
  elevator_id char(36) fk
  assigned_at timestamp
}

// RIDES (TRIPS LOG)

rides [icon: activity, color: blue] {
  id char(36) pk
  elevator_id char(36) fk
  request_id char(36) fk
  start_floor_id char(36) fk
  end_floor_id char(36) fk
  start_time timestamp
  end_time timestamp
  passengers_count int
}

// ELEVATOR STATUS TRACKING

elevator_status_logs [icon: cpu, color: green] {
  id char(36) pk
  elevator_id char(36) fk
  status varchar(20)   // idle/moving/maintenance/offline
  current_floor int
  recorded_at timestamp
}

// MAINTENANCE RECORDS

maintenance_logs [icon: tool, color: red] {
  id char(36) pk
  elevator_id char(36) fk
  issue_description text
  reported_at timestamp
  resolved_at timestamp
  status varchar(20)
}

// FAILURE / ALERT LOGS (ADVANCED)

alerts [icon: alert-triangle, color: red] {
  id char(36) pk
  elevator_id char(36) fk
  alert_type varchar(50)
  severity varchar(20)
  created_at timestamp
}

// LOAD TRACKING (ADVANCED)

load_logs [icon: bar-chart, color: purple] {
  id char(36) pk
  elevator_id char(36) fk
  weight decimal(10,2)
  recorded_at timestamp
}

// ANALYTICS (ADVANCED)

usage_logs [icon: trending-up, color: blue] {
  id char(36) pk
  elevator_id char(36) fk
  total_rides int
  avg_wait_time decimal(10,2)
  recorded_date date
}


floors.building_id > buildings.id
shafts.building_id > buildings.id
elevators.building_id > buildings.id
elevators.shaft_id > shafts.id

elevator_floor_map.elevator_id > elevators.id
elevator_floor_map.floor_id > floors.id

zones.building_id > buildings.id
zone_elevator_map.zone_id > zones.id
zone_elevator_map.elevator_id > elevators.id

requests.floor_id > floors.id

assignments.request_id > requests.id
assignments.elevator_id > elevators.id

rides.elevator_id > elevators.id
rides.request_id > requests.id
rides.start_floor_id > floors.id
rides.end_floor_id > floors.id

elevator_status_logs.elevator_id > elevators.id
maintenance_logs.elevator_id > elevators.id
alerts.elevator_id > elevators.id
load_logs.elevator_id > elevators.id
usage_logs.elevator_id > elevators.id