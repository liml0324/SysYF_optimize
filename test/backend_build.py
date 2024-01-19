#!/usr/bin/env python3
import subprocess
import os
import time

IRBuild_ptn = '"{}" "-S" "-o" "{}" "{}" "-O2"'
ExeGen_ptn = '"clang" "{}" "-o" "{}" "{}" "../lib/lib.c"'
Exe_ptn = '"{}"'
time_detailed = True
time_cost_ir = 0
time_cost_exegen = 0
time_cost_exe = 0

def Gen(EXE_PATH, TEST_BASE_PATH, optimization):
    global time_cost_ir
    global time_cost_exegen
    global time_cost_exe
    global time_detailed

    print('===========TEST START===========')
    print('now in {}'.format(TEST_BASE_PATH))
    dir_succ = True
    for case in testcases:
        print('Case %s:' % case, end='')
        TEST_PATH = TEST_BASE_PATH + case
        SY_PATH = TEST_BASE_PATH + case + '.sy'
        S_PATH = TEST_BASE_PATH + case + '.s'
        subprocess.call(["rm", "-rf", TEST_PATH, TEST_PATH + ".s"])

        # 生成IR
        time_start_ir = time.time()
        IRBuild_result = subprocess.run(IRBuild_ptn.format(EXE_PATH, S_PATH, SY_PATH), shell=True, stderr=subprocess.PIPE)
        # time_end_ir = time.time()
        # time_cost_ir += time_end_ir - time_start_ir
        #IRBuild运行成功
        if IRBuild_result.returncode == 0:
            print('\t\033[32mIRBuild Success\033[0m')
        else:
            dir_succ = False
            print('\t\033[31mIRBuild Fail\033[0m')
    if dir_succ:
        print('\t\033[32mSuccess\033[0m in dir {}'.format(TEST_BASE_PATH))
    else:
        print('\t\033[31mFail\033[0m in dir {}'.format(TEST_BASE_PATH))

    print('============BUILD END============')
    return dir_succ


if __name__ == "__main__":

    # you can only modify this to add your testcase
    # 测试目录
    TEST_DIRS = [
                './Test_H/Easy_H/',
                './Test_H/Medium_H/',
                './Test_H//Hard_H/',
                './Test/Easy/',
                './Test/Medium/',
                './Test/Hard/'
                ]
    # you can only modify this to add your testcase

    optimization = "-O0"     # -O0 -O1 -O2 -O3 -O4 -Ofast
    fail_dirs = set()
    for TEST_BASE_PATH in TEST_DIRS:
        testcases = {}  # { name: need_input }
        EXE_PATH = os.path.abspath('../build/SysYFCompiler') # 编译器路径
        if not os.path.isfile(EXE_PATH):
            print("compiler does not exist")
            exit(1)
        # 获取测试文件
        for Dir in TEST_DIRS:
            if not os.path.isdir(Dir):
                print("folder {} does not exist".format(Dir))
                exit(1)
        testcase_list = list(map(lambda x: x.split('.'), os.listdir(TEST_BASE_PATH)))
        testcase_list.sort()
        for i in range(len(testcase_list)-1, -1, -1):
            if len(testcase_list[i]) == 1:
                testcase_list.remove(testcase_list[i])
        for i in range(len(testcase_list)):
            testcases[testcase_list[i][0]] = False
        for i in range(len(testcase_list)):
            testcases[testcase_list[i][0]] = testcases[testcase_list[i][0]] | (testcase_list[i][1] == 'in')
        # 评测文件夹
        if not Gen(EXE_PATH, TEST_BASE_PATH, optimization=optimization):
            fail_dirs.add(TEST_BASE_PATH)
    if len(fail_dirs) > 0:
        fail_dir_str = ''
        for Dir in fail_dirs:
            fail_dir_str += (Dir + "\t")
        print("\t\033[31mTest Fail\033[0m in dirs {}".format(fail_dir_str))
    else:
        print("\t\033[32mAll Tests Passed\033[0m")
        
