#pragma once
#include "hello.ice"

module Fear
{
    interface Hello2
    {
         idempotent void say2Hello(int delay)
            throws RequestCanceledException;

    };
};