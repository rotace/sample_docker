#include "CppUTest/CommandLineTestRunner.h"

int inc(int x){
    return x+1;
}

TEST_GROUP(TestFuncInc){

};

TEST(TestFuncInc, CheckReturnValue){
    LONGS_EQUAL(11, inc(10));
}

int main(int argc, char **argv){
    return CommandLineTestRunner::RunAllTests(argc,argv);
}