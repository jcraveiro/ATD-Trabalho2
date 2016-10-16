function [ cm ] = coefComp( Cm, tetam )
    c0 = (Cm(1)/2)*exp(1i*tetam(1)) + Cm(1)/2 * exp(-1i*tetam(1));
    cm = Cm(2:end)/2 .* exp(1i*tetam(2:end));
    c_m = Cm(end:-1:2)/2 .* exp(-1i*tetam(end:-1:2));
    cm = [c_m;c0;cm];
end

