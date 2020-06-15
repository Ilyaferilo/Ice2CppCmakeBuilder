#include "second_hello.h"
#include "hello2.h"
#include <Ice/Communicator.h>
#include <iostream>

int stub()
{
    HelloIce::Hello2Prx f;
    f->say2Hello(12);
    HelloIce::HelloSecondPrx s;
    s->sayHello(34);
    return 12 + 20 + 10;
}