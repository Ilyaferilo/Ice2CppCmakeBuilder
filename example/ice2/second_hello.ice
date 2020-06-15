#pragma once

#include "../ice/hello.ice"

module HelloIce
{

    interface HelloSecond
    {
         idempotent void sayHello(int delay)
            throws RequestCanceledException;

        void shutdown(int x);
    };
};