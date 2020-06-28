classdef app2_exported < matlab.apps.AppBase

    % Properties that correspond to app components
    properties (Access = public)
        UIFigure                  matlab.ui.Figure
        PlayButton                matlab.ui.control.Button
        OctaveKnobLabel           matlab.ui.control.Label
        OctaveKnob                matlab.ui.control.DiscreteKnob
        NoteKnobLabel             matlab.ui.control.Label
        NoteKnob                  matlab.ui.control.DiscreteKnob
        FluteSoundGeneratorLabel  matlab.ui.control.Label
    end

    % Callbacks that handle component events
    methods (Access = private)

        % Button pushed function: PlayButton
        function PlayButtonPushed(app, event)
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
    cv = app.OctaveKnob.Value;
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
        %assignin('base','flutes', fluteSound);
      % for j = 1:8
           
      % end
            
        end

        % Value changed function: OctaveKnob
        function OctaveKnobValueChanged(app, event)
            value = app.OctaveKnob.Value;
            
        end
    end

    % Component initialization
    methods (Access = private)

        % Create UIFigure and components
        function createComponents(app)

            % Create UIFigure and hide until all components are created
            app.UIFigure = uifigure('Visible', 'off');
            app.UIFigure.Position = [100 100 426 477];
            app.UIFigure.Name = 'MATLAB App';

            % Create PlayButton
            app.PlayButton = uibutton(app.UIFigure, 'push');
            app.PlayButton.ButtonPushedFcn = createCallbackFcn(app, @PlayButtonPushed, true);
            app.PlayButton.Position = [150 79 100 22];
            app.PlayButton.Text = 'Play';

            % Create OctaveKnobLabel
            app.OctaveKnobLabel = uilabel(app.UIFigure);
            app.OctaveKnobLabel.HorizontalAlignment = 'center';
            app.OctaveKnobLabel.Position = [296 156 44 22];
            app.OctaveKnobLabel.Text = 'Octave';

            % Create OctaveKnob
            app.OctaveKnob = uiknob(app.UIFigure, 'discrete');
            app.OctaveKnob.ValueChangedFcn = createCallbackFcn(app, @OctaveKnobValueChanged, true);
            app.OctaveKnob.Position = [289 193 60 60];

            % Create NoteKnobLabel
            app.NoteKnobLabel = uilabel(app.UIFigure);
            app.NoteKnobLabel.HorizontalAlignment = 'center';
            app.NoteKnobLabel.Position = [75 153 31 22];
            app.NoteKnobLabel.Text = 'Note';

            % Create NoteKnob
            app.NoteKnob = uiknob(app.UIFigure, 'discrete');
            app.NoteKnob.Items = {'All', 'Sa', 'Re', 'Ga', 'Ma', 'Pa', 'Dha', 'Ni', 'Saa'};
            app.NoteKnob.ItemsData = {'0', '1', '2', '3', '4', '5', '6', '7', '8'};
            app.NoteKnob.Position = [59 190 60 60];
            app.NoteKnob.Value = '1';

            % Create FluteSoundGeneratorLabel
            app.FluteSoundGeneratorLabel = uilabel(app.UIFigure);
            app.FluteSoundGeneratorLabel.FontSize = 25;
            app.FluteSoundGeneratorLabel.Position = [82 307 263 47];
            app.FluteSoundGeneratorLabel.Text = 'Flute Sound Generator';

            % Show the figure after all components are created
            app.UIFigure.Visible = 'on';
        end
    end

    % App creation and deletion
    methods (Access = public)

        % Construct app
        function app = app2_exported

            % Create UIFigure and components
            createComponents(app)

            % Register the app with App Designer
            registerApp(app, app.UIFigure)

            if nargout == 0
                clear app
            end
        end

        % Code that executes before app deletion
        function delete(app)

            % Delete UIFigure when app is deleted
            delete(app.UIFigure)
        end
    end
end