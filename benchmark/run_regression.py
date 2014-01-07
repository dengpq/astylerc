#!/usr/bin/python
import os
import os.path
import string

def main():
    #attention, I can't use ~/benchmark/ISPD02_bookshelf/, python cannot distinguish it
    fastplace_gp = "/home/pqdeng/FastPlace3.0_bin/FastPlace3.0_GP"
    fastplace_dp = "/home/pqdeng/FastPlace3.0_bin/FastPlace3.0_DP"

    parent_dir = "/home/pqdeng/benchmark/ISPD02_bookshelf/"
    bench_list = os.listdir(parent_dir)
    bench_list.sort()
    bench_size = len(bench_list)
    print("There're %d test circuits in ISPD02 benchmark." %(bench_size))

    os.chdir(parent_dir)
    #then create the regression_result.log file in benchmark directory
    regression_result_file = "regression_result.log"
    fwrite = open(regression_result_file, "w")
    fwrite.write("circuit      GP_HPWL    GP_Rumtime     DP_HPWL    DP_Runtime\n")

    count = 0
    while (count < bench_size):
        test_circuit = bench_list[count]
        os.chdir(test_circuit)
        bench_dir = os.getcwd()
        print("current test circuit is %s, its directory is %s" %(test_circuit,\
                bench_dir))
        aux_file = test_circuit + ".aux"
        #FastPlace3_GP [OPTIONS] <benchmark_dir> <aux_file> <output_dir>
        output_dir = bench_dir + "/placement_output"
        if (not os.path.exists(output_dir)):
            os.mkdir(output_dir)

        redirect_file = test_circuit + "_gp_result.log"
        #e.g. FastPlace3_GP ~/benchmark/ISPD02_bookshelf/ibm01 ibm01.aux \
        # placement_output/ > ibm01_gp_result.log
        placement_cmd = fastplace_gp + " " + bench_dir + " " + aux_file + " "\
                + output_dir + " > " + redirect_file

        gp_output_file = test_circuit + "_FP_gp.pl"
        #if global placement result file doesn't exists, then run global placement
        #else run detailed placement directly
        os.chdir(output_dir)
        if (not os.path.exists(gp_output_file)):
            os.chdir(bench_dir)
            os.system(placement_cmd)
            print("%s run global placement OK!" %test_circuit)

        #then run detailed placement......
        redirect_file = test_circuit + "_dp_result.log" 
        #FastPlace3_DP [OPTIONS] <benchmark_dir> <aux_file> <input_dir> <input_file_name>
        #e.g. FastPlace3_DP -legalize ~/benchmark/ISPD02_bookshelf/ibm01 ibm01.aux \
        #placement_output/ ibm01_FP_gp.pl > ibm01_dp_result.log
        placement_cmd = fastplace_dp + " -legalize " + bench_dir + " " + aux_file + " "\
                + output_dir + " " + gp_output_file + " > " + redirect_file
        #if detailed placement result file had existed, it needn't run detailed
        #placement.
        dp_output_file = test_circuit + "_FP_dp.pl"
        if (not os.path.exists(dp_output_file)):
            os.chdir(bench_dir)
            os.system(placement_cmd)
            print("%s run detailed placement OK!" %test_circuit)

        #wait, I should record the HPWL result after GP and DP
        write_regression_result(test_circuit, bench_dir, fwrite)

        os.chdir(parent_dir)
        count += 1
    #end of while (count < bench_size)
    fwrite.close()
#end of main()

def write_regression_result(test_circuit, bench_dir, fwrite):
    os.chdir(bench_dir);
    #first read global placement output file
    gp_result_file = test_circuit + "_gp_result.log"
    fread = open(gp_result_file, "r")
    #circuit_regression_result was used to record the GP and DP HPWL result
    #e.g.  ibm01  2822892.000   3730001.000
    circuit_regression_result = test_circuit
    find_gp_hpwl = False
    while True:
        line = fread.readline()
        if (find_gp_hpwl == False and "Global Placement Wirelength" in line):
        #then get the HPWL value after GP
        #the gp_hpwl is: X = ? Y = ?, the next line is total wirelength
             find_gp_hpwl = True
        elif (find_gp_hpwl == True):
             gp_hpwl = strip_value(line, "=")
             print("%s global placement HPWL is: %s" %(test_circuit, gp_hpwl))
             circuit_regression_result += ("        " + gp_hpwl)
             find_gp_hpwl = False
        elif ("Total Global Placement Time" in line):
        #then get global placement runtime
            gp_runtime = strip_value(line, ":")
            print("%s global Placement runtime is: %s" %(test_circuit,\
                    gp_runtime))
            circuit_regression_result += ("    " + gp_runtime)
            break
    #end of while True
    fread.close()

    #then read detailed placement output file
    dp_result_file = test_circuit + "_dp_result.log"
    fread = open(dp_result_file, "r")
    while True:
        line = fread.readline()
        if ("Final Half-Perimeter Wirelength" in line):
        #then get the HPWL value after DP
            dp_hpwl = strip_value(line, ":")
            circuit_regression_result += ("     " + dp_hpwl)
            print("%s detailed placement HPWL result is: %s" %(test_circuit,\
                    dp_hpwl))
        elif ("Total Detailed Placement Time" in line):
            dp_runtime = strip_value(line, ":")
            print("%s detailed placement runtime is: %s" %(test_circuit,\
                    dp_runtime))
            circuit_regression_result += ("    " + dp_runtime + "\n")
            break
    #end of while True:
    fread.close()

    fwrite.write(circuit_regression_result)
    fwrite.flush()
#end of write_regression_result(test_circuit, output_dir, fwrite)

def strip_value(line, s):
    length = len(line)
    loc = line.find(s)
    if (loc != -1):
        target_str = line[loc + 1:length - 1]
        return_val = target_str.strip()
        return return_val 
#end of strip_value(line, s)


if __name__ == '__main__':
    main()
