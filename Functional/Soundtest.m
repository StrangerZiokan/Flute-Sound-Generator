[y,fs]=audioread('flute.mp3');
[yupper,ylower] = envelope(y,400,'rms');

t=linspace(0,21360/fs,21360);
total = synthesizer(13,t);
fluteSound = (total.*transpose(yupper))/4.8;
c=12;
song = [c+1 c+3 c+5 c+6 c+8 c+10 c+12 c+13];

noise = 0.01*sqrt(0.01)*randn(21360,1);

for j = 1:8
    total = synthesizer(song(j),t);
    fluteSound = (total.*transpose(yupper))/4.8 + transpose(noise);
    sound(fluteSound,fs);
    pause(1);
end