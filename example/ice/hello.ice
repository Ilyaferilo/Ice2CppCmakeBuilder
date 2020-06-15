#pragma once

module HelloIce
{
    exception RequestCanceledException
    {
    };

    interface Hello
    {
         idempotent void sayHello(int delay, int ms)
            throws RequestCanceledException;

        void shutdown(int x);
    };
};