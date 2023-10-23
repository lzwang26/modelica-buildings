#!/usr/bin/env python3
import sys
sys.path.append('C:/Users/wang005/Documents/Git/Modelica/modelica-buildings/Buildings/Resources/Scripts/EnergyPlus')
import energyplus_csv_to_mos as e

def check():
    args = sys.argv[1:]
    dat_fil = args[0].replace(".idf", ".dat")
    print(dat_fil)

def main():
    args = sys.argv[1:]
    dat_fil = args[0].replace(".idf", ".dat")
    output_list =[
        'Environment:Site Outdoor Air Drybulb Temperature [C](Hourly)',
        'SYS 1 HEAT PUMP COOLING MODE:Cooling Coil Electric Power [W](Hourly)',
        'SYS 1 HEAT PUMP COOLING MODE:Cooling Coil Total Cooling Rate [W](Hourly)',
        'SYS 1 HEAT PUMP COOLING MODE:Cooling Coil Sensible Cooling Rate [W](Hourly)',
        'SYS 1 HEAT PUMP COOLING MODE:Cooling Coil Source Side Heat Transfer Rate [W](Hourly)',
        'SYS 1 HEAT PUMP COOLING MODE:Cooling Coil Part Load Ratio [](Hourly)',
        'SYS 1 HEAT PUMP COOLING MODE:Cooling Coil Air Mass Flow Rate [kg/s](Hourly)',
        'SYS 1 HEAT PUMP COOLING MODE:Cooling Coil Air Inlet Temperature [C](Hourly)',
        'SYS 1 HEAT PUMP COOLING MODE:Cooling Coil Air Inlet Humidity Ratio [kgWater/kgDryAir](Hourly)',
        'SYS 1 HEAT PUMP COOLING MODE:Cooling Coil Air Outlet Temperature [C](Hourly)',
        'SYS 1 HEAT PUMP COOLING MODE:Cooling Coil Air Outlet Humidity Ratio [kgWater/kgDryAir](Hourly)',
        'SYS 1 HEAT PUMP COOLING MODE:Cooling Coil Source Side Mass Flow Rate [kg/s](Hourly)',
        'SYS 1 HEAT PUMP COOLING MODE:Cooling Coil Source Side Inlet Temperature [C](Hourly)',
        'SYS 1 HEAT PUMP COOLING MODE:Cooling Coil Source Side Outlet Temperature [C](Hourly)',
        'SYS 1 HEAT PUMP COOLING MODE:Cooling Coil Upper Speed Level [](Hourly)',
        'SYS 1 HEAT PUMP COOLING MODE:Cooling Coil Neighboring Speed Levels Ratio [](Hourly)',
        'SYS 1 HEAT PUMP COOLING MODE:Cooling Coil Recoverable Heat Transfer Rate [W](Hourly)',
        'TC VS TEMP1 TEST:Performance Curve Output Value [](Hourly)',
        'TC VS AIRFRAC TEST:Performance Curve Output Value [](Hourly)',
        'TC VS WATERFRAC TEST:Performance Curve Output Value [](Hourly)',
        'SYS 1 COOLING COIL AIR INLET NODE:System Node Wetbulb Temperature [C](Hourly)',
        'SpeedRatio'
    ]

    e.energyplus_csv_to_mos(
    output_list = output_list,
    dat_file_name=dat_fil,
    step_size=3600,
    final_time=864000)

if __name__ == '__main__':
    main()
