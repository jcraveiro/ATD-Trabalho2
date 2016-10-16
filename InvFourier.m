function [y]=InvFourier(Cm,tetam,t,t0,m_max)
    total = 0;
    y = zeros(size(t));
    
    for j=1:length(y);
        total = 0;
        for i=0:m_max
            total = total + Cm(i+1)*cos((2*pi/t0)*i*t(j) + tetam(i+1));
        end
        
        y(j) = total;
    end
  
    
end