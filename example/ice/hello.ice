#pragma once

module Fear
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