import argparse
import numpy as np
import os
import pandas as pd
import re
import scipy.stats
import sys
import yaml
import glob

def main():
    parser = argparse.ArgumentParser(description='Process results of workloads by intervals.')
    parser.add_argument('-w', '--workloads', required=True, help='.yaml file where the list of workloads is found.')
    parser.add_argument('-od', '--outputdir', default='./output', help='Directory where output files will be placed')
    parser.add_argument('-id', '--inputdir', default='./data', help='Directory where input are found')

    args = parser.parse_args()

    with open(args.workloads, 'r') as f:
        workloads = yaml.load(f)

    for wl_id, wl in enumerate(workloads):
        wl_show_name = "-".join(wl)
        apps = wl_show_name.split("-")
        print(wl_show_name)
        dfW =  pd.DataFrame(columns=['app','time_s','instructions:tot','cycles:tot','ipc'])

        outputPath = args.outputdir + "/" + wl_show_name

        appN = 0
        for app in apps:
            print(app)
            wl_in_path = args.inputdir + "/" + wl_show_name + "/perfCtrs." + str(appN)
            dfApp = pd.read_table(wl_in_path, sep=" ")

            dfW.loc[appN,'app'] = app
            dfW.loc[appN,'time_s'] = dfApp['TIME_ELAPSED_MS'].sum()
            dfW.loc[appN,'instructions:tot'] = dfApp['INST_RETIRED'].sum()
            dfW.loc[appN,'cycles:tot'] = dfApp['UNHALTED_CORE_CYCLES'].sum()
            dfW.loc[appN,'ipc'] = dfApp['INST_RETIRED'].sum() / dfApp['UNHALTED_CORE_CYCLES'].sum()

            # save tables
            dfW.index.name = 'app_id'
            outputW = outputPath + "/" + wl_show_name + "-table.csv"
            dfW.to_csv(outputW, sep=',')

            appN = appN + 1

        print(dfW)



if __name__ == "__main__":
    main()
