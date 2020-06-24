    [y,fs]=audioread('flute.mp3');
    [yupper,ylower] = envelope(y,400,'rms');

    t=linspace(0,21888/fs,21888);
    n = 12;

    fund =  (1.0595^(n - 1))*262;
    A = [5 3 1 0.5]; %4 harmonics with diminishing amplitudes
    f = [fund 2*fund 3*fund 4*fund];
    total = A(1)*sin(2*pi*f(1)*t);
    for i = 2:4
        total = total + A(i)*sin(2*pi*f(i)*t);
    end
    
    fluteSound = (total.*transpose(yupper))/4.8;
    %c= app.NoteKnob.Value;
    cv = app.ShrillnessKnob.Value;
    if strcmp(cv,'Off')
        c = 12;
    elseif strcmp(cv,'Low')
        c = 20;
    elseif strcmp(cv,'Medium')
        c =25;
    elseif strcmp(cv,'High')
        c = 50;
    end
    song = [c+1 c+3 c+5 c+6 c+8 c+10 c+12 c+13];

    noise = 0.01*sqrt(0.01)*randn(21888,1);

%for j = 1:8
   %total = synthesizer(song(j),t);
   j = str2num(app.NoteKnob.Value);
    
   if j==0
       for j = 1:8
            n = song(j);
            fund =  (1.0595^(n - 1))*262;
             A = [5 3 1 0.5]; %4 harmonics with diminishing amplitudes
            f = [fund 2*fund 3*fund 4*fund];
            total = A(1)*sin(2*pi*f(1)*t);
        for i = 2:4
            total = total + A(i)*sin(2*pi*f(i)*t);
         end
         fluteSound = (total.*transpose(yupper))/4.8 + transpose(noise);
         sound(fluteSound,fs);
        pause(1);
       end
   elseif j >= 0
        n = song(j);
            fund =  (1.0595^(n - 1))*262;
             A = [5 3 1 0.5]; %4 harmonics with diminishing amplitudes
            f = [fund 2*fund 3*fund 4*fund];
            total = A(1)*sin(2*pi*f(1)*t);
        for i = 2:4
            total = total + A(i)*sin(2*pi*f(i)*t);
         end
         fluteSound = (total.*transpose(yupper))/4.8 + transpose(noise);
         sound(fluteSound,fs);
        pause(1);
   end
  