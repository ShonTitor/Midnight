Space

Comet halley(planet n) -> blackhole {
    print("Este es un procedimiento");
    print(n);
}

Comet twice(planet n) -> planet {
    print("Esta es una Funci�n");
    return 2*n;
}

Comet double(planet @n) -> blackhole {
    n *= 2
}

(planet -> planet) Comet f = twice;
planet z = f(2);

EndofSpace

