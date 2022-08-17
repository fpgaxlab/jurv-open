# Nexys4DDR 
create_project -part xc7a100tcsg324-1 -force lab ./

# Add framework sources
add_files -scan_for_includes ./framework/srcs

# Import IPs
import_files -quiet [glob -nocomplain ./framework/ip/*/*.xci]

# Add constraints
add_files -fileset constrs_1 -quiet ./framework/constrs
