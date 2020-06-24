function total = synthesizer(n,t)
    fund = notes(n);
    A = [5 3 1 0.5]; %4 harmonics with diminishing amplitudes
    f = [fund 2*fund 3*fund 4*fund];
    total = A(1)*sin(2*pi*f(1)*t);
    for i = 2:4
        total = total + A(i)*sin(2*pi*f(i)*t);
    end
end